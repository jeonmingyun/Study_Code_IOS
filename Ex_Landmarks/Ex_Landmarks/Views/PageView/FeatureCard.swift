/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that shows a featured landmark.
*/

import SwiftUI

struct FeatureCard: View {
    var landmark: Landmark
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            landmark.featureImage?
                .resizable() // 이미지 사이즈 수정 가능여부
                .aspectRatio(3 / 2, contentMode: .fit) // 이미지 사이즈 설치
            
            VStack(alignment: .leading) {
                Text(landmark.name)
                    .font(.title)
                    .bold()
                Text(landmark.park)
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}

struct FeatureCard_Previews: PreviewProvider {
    static var previews: some View {
        FeatureCard(landmark: ModelData().features[0])
    }
}
