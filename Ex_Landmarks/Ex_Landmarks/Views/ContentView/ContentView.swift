//
//  ContentView.swift
//  Ex_Landmarks
//
//  Created by jjglobal on 2022/06/07.
//

import SwiftUI

// SwiftUI view 파일은 두가지 구조를 선언한다 (view, preview)
// 첫번째 구조) 캔버스, View프로토콜을 따름, view의 내용과 레이아웃을 설명함
struct ContentView: View {
    // body는 하나의 view만 반환하기 때문에 stack으로 감싸 하나의 view로 만들어준다
    var body: some View {
        // Vstack: 수직정렬, HStack: 수평정렬, ZStack: 겹침
        VStack {
            MapView()
                .frame(height: 300)
            
            CircleImage()
                .offset(y: -130)
                .padding(.bottom, -130.0)
            
            VStack(alignment: .leading) { // 왼쪽정렬 (.leading)
                Text("Turtle Rock")
                    .font(.title)
                    .foregroundColor(.black)
                
                HStack {
                    Text("Joshua Tree National Park")
                    Spacer()
                    Text("California")
                }
                .font(.subheadline) // Text 공통 속성
                .foregroundColor(.secondary)
                
                Divider()
                
                Text("About Turtle Rock")
                    .font(.title2)
                Text("Descriptive text goes here.")
            }
            .padding()
            
            Spacer() // 하단에 Spacer를 주어 상단 정렬
        }
    }
}

// 두번째 구조) 미리보기, 해당 보기에 대한 미리보기를 선언함
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
