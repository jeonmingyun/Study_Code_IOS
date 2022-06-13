//
//  ProfileHost.swift
//  Ex_Landmarks
//
//  Created by jjglobal on 2022/06/09.
//

import SwiftUI

struct ProfileHost: View {
    // @Environment : environmet 값에 접근할 수 있게 해준다
    // \.editMode : editMode값을 통해 편집 범위를 읽거나 쓸 수 있다
    @Environment(\.editMode) var editMode
    @EnvironmentObject var modelData: ModelData
    @State private var draftProfile = Profile.default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                if editMode?.wrappedValue == .active {
                    Button("Cancel") {
                        draftProfile = modelData.profile
                        editMode?.animation().wrappedValue = .inactive
                    }
                }
                Spacer()
                EditButton()
            }
            
            // 수정 불가 상태, EditButton 클릭시 상태 변경
            if editMode?.wrappedValue == .inactive {
                ProfileSummary(profile: modelData.profile)
            } else { // 수정 가능 상태
                ProfileEditor(profile: $draftProfile)
                    .onAppear { // view가 나타날때 action
                        draftProfile = modelData.profile
                    }
                    .onDisappear { // view가 없어질때 action
                        modelData.profile = draftProfile
                    }
            }
        }
        .padding()
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
            .previewDevice("iPhone 13")
            .environmentObject(ModelData()) // 자식view가 해당 속성을 사용하기 때문에 없으면 미리보기가 실패함
    }
}
