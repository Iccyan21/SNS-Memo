//
//  ContentView.swift
//  SNS-Memo
//
//  Created by 水原　樹 on 2024/03/21.
//

import SwiftUI

struct ContentView: View {
    @State var inputText = ""
    var body: some View {
        VStack {
            ZStack{
                Color.orange.edgesIgnoringSafeArea(.all)
                Text("ホーム")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .padding()
            }.frame(height: 50)
            // ここはもう少しデザインをカスタマイズ
            TextField("キーワード",text: $inputText,prompt: Text("キーワードを入力してください"))
                .padding()
            
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button(action: {
                    // ボタンがタップされたときのアクションを追加します
                }) {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .clipShape(Circle())
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
