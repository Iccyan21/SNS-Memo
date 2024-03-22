//
//  SettingView.swift
//  SNS-Memo
//
//  Created by 水原　樹 on 2024/03/21.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        VStack{
            ZStack{
                Color.orange.edgesIgnoringSafeArea(.all)
                Text("設定")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .padding()
            }.frame(height: 50)
            Spacer()
        }
    }
}

#Preview {
    SettingView()
}
