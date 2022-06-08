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
       LandmarkList()
    }
}

// 두번째 구조) 미리보기, 해당 보기에 대한 미리보기를 선언함
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
