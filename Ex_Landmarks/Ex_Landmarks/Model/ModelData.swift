//
//  ModelData.swift
//  Ex_Landmarks
//
//  Created by jjglobal on 2022/06/08.
//

import Foundation
import Combine

// 저장을 위해 관찰 가능한 객체 사용
// SwiftUI는 관찰 가능한 객체를 구독하고 데이터가 변경 될 때 새로 고쳐야 하는 모든 뷰를 업데이트한다
// @Published : SwiftUI의 구독 객체
final class ModelData: ObservableObject {
    @Published var landmarks: [Landmark] = load("landmarkData.json")
    // hikeData는 수정하지 않을 거기 때문에 @Published 속성으로 표기하지 않음
    var hikes: [Hike] = load("hikeData.json")
    @Published var profile = Profile.default
    
    var features: [Landmark] {
        landmarks.filter { $0.isFeatured }
    }

    var categories: [String: [Landmark]] {
        Dictionary(
            grouping: landmarks,
            by: { $0.category.rawValue }
        )
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do{
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
