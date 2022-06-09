//
//  Profile.swift
//  Ex_Landmarks
//
//  Created by jjglobal on 2022/06/09.
//
import Foundation

struct Profile {
    var username: String
    var prefersNotifications = true
    var seasonalPhoto = Season.winter
    var goalDate = Date()

    // 기본 접근성 작업을 나타내는 값, Profile의 default 초기화 값
    static let `default` = Profile(username: "g_kumar")

    enum Season: String, CaseIterable, Identifiable {
        case spring = "🌷"
        case summer = "🌞"
        case autumn = "🍂"
        case winter = "☃️"

        var id: String { rawValue }
    }
}
