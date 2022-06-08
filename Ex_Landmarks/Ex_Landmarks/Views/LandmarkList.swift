//
//  LandmarkList.swift
//  Ex_Landmarks
//
//  Created by jjglobal on 2022/06/08.
//

import SwiftUI

struct LandmarkList: View {
    var body: some View {
        NavigationView {
            List(landmarks) { landmark in
                NavigationLink { // 클릭시
                    LandmarkDetail(landmark: landmark)
                } label: { // 클릭 view
                    LandmarkRow(landmark: landmark)
                }
            }
            .navigationTitle("Landmarks")
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        // 여러 디바이스의 preview를 한번에 볼 수 있음
        ForEach(["iPhone SE (2nd generation)", "iPhone 12"], id: \.self) { deviceName in
                    LandmarkList()
                        .previewDevice(PreviewDevice(rawValue: deviceName))
                        .previewDisplayName(deviceName)
        }
        .previewDevice("iPhone 13 Pro Max")
    }
}
