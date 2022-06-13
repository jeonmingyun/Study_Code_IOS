//
//  Landmark.swift
//  Ex_Landmarks
//
//  Created by jjglobal on 2022/06/08.
//

import Foundation
import SwiftUI
import CoreLocation

// Hashable 프로토콜 : 데이터 통신시 Hash형태로 구현해준다, 기본자료형의 경우 Hashable선언만 해줘도 된다
// Codable 프로토콜 : 구조와 데이터 파일 간에 데이터를 쉽게 이동 가능 (Decodable & Encodable)
// Identifiable 프로토콜 : struct, class를 정의 할 때 id의 정의를 강제화
struct Landmark: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
    var isFavorite: Bool
    var isFeatured: Bool
    
    var category: Category
    enum Category: String, CaseIterable, Codable {
        case lakes = "Lakes"
        case rivers = "Rivers"
        case mountains = "Mountains"
    }
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
    var featureImage: Image? {
        // featureImage는 기본 이미지와 다른 사이즈의 이미지를 사용함
        isFeatured ? Image(imageName + "_feature") : nil
    }
    
    private var coordinates: Coordinates
    // MapKit 프레임워크와 상호작용하기 편하게 변경
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }

    // 기본자료형이 아니면 Hash함수를 직접 구현해 주어야한다
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}
