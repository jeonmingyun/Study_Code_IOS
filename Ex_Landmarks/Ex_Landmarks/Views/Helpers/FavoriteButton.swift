//
//  FavoriteButton.swift
//  Ex_Landmarks
//
//  Created by jjglobal on 2022/06/08.
//

import SwiftUI

struct FavoriteButton: View {
    // 다른 뷰에서 @State 속성으로 선언된 프로퍼티를 사용한다면 @Binding 속성을 사용
    @Binding var isSet: Bool
    
    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .yellow : .gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true))
    }
}
