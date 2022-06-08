//
//  Ex_LandmarksApp.swift
//  Ex_Landmarks
//
//  Created by jjglobal on 2022/06/07.
//

import SwiftUI

// SwiftUI 앱 라이프 사이클을 사용하는 앱은 App프로토콜을 준수하는 구조를 가진다
// @main은 앱의 진입점을 식별한다
@main
struct Ex_LandmarksApp: App {
    // body속성은 하나 이상의 장면을 반환
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
