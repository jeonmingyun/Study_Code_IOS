/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing featured landmarks above a list of landmarks grouped by category.
*/

import SwiftUI

struct CategoryHome: View {
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        NavigationView {
            List {
                modelData.features[0].image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .listRowInsets(EdgeInsets())

                // 반복할 객체에 완전히 같은 값이 있을 수 있기 때문에 Identifiabled을 지키기 위해 id 값을 줌
                // (swift가 같은 값 때문에 error를 발생시키는 것을 방지)
                // \.self는 ForEach의 Data객체의 item을 id로 가진다
                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, items: modelData.categories[key]!)
                }
                .listRowInsets(EdgeInsets())
            }
            .navigationTitle("Featured")
        }
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .environmentObject(ModelData())
            .previewDevice(/*@START_MENU_TOKEN@*/"iPhone 13"/*@END_MENU_TOKEN@*/)
    }
}
