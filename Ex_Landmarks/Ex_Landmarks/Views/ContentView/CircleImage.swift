//
//  CircleImage.swift
//  Ex_Landmarks
//
//  Created by jjglobal on 2022/06/07.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("turtlerock") // Assets에 등록된 res이름
            .clipShape(Circle())
            .shadow(radius: 7)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
