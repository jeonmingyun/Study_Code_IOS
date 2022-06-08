//
//  Landmark.swift
//  Ex_Landmarks
//
//  Created by jjglobal on 2022/06/08.
//

import Foundation
import SwiftUI
import CoreLocation

// Codable을 사용하면 구조와 데이터 파일 간에 데이터를 쉽게 이동 가능
struct Landmark: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
    
    private var coordinates: Coordinates
    // MapKit 프레임워크와 상호작용하기 편하게 변경
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }

    
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}
