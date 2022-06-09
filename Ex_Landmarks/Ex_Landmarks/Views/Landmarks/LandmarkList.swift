//
//  LandmarkList.swift
//  Ex_Landmarks
//
//  Created by jjglobal on 2022/06/08.
//

import SwiftUI

struct LandmarkList: View {
    // @EnvironmentObject : ObservableObject에 선언된 구독 객체를 사용하게해줌
    // 화면이 이동될때 관찰 객체를 전달해주지 않아도 됨
    @EnvironmentObject var modelData: ModelData
    // @State : View에서 접근 가능하도록 값을 가지고 있는 Property Wrapper
    // @State 변수를 참조할때는 $를 사용하여 상태변수나 프로퍼티에 바인딩함
    @State private var showFavoriteOnly = false
    
    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in
            (!showFavoriteOnly || landmark.isFavorite)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $showFavoriteOnly) {
                    Text("Favorites only")
                }
                
                ForEach(filteredLandmarks) { landmark in
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
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        // 여러 디바이스의 preview를 한번에 볼 수 있음
        /*ForEach(["iPhone SE (2nd generation)", "iPhone 12"], id: \.self) { deviceName in
            LandmarkList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }*/
        LandmarkList()
            .environmentObject(ModelData())
    }
}
