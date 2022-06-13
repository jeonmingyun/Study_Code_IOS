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
    //@StateObject : 앱 수명 동안 한 번만 ObserverObject 객체를 초기화한다. App객체에서 사용됨
    @StateObject private var modelData = ModelData  ()
    
    // body속성은 하나 이상의 장면을 반환
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
