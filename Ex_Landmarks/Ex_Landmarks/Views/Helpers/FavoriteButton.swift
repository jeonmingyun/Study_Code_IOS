//
//  FavoriteButton.swift
//  Ex_Landmarks
//
//  Created by jjglobal on 2022/06/08.
//

import SwiftUI

struct FavoriteButton: View {
    // 해당 view 내에서 수행된 변경사항은 데이터 원본으로 전파된다
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
