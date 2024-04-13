//
//  CreateView.swift
//  SNS-Memo
//
//  Created by 水原　樹 on 2024/03/24.
//

import SwiftUI
import PhotosUI

struct CreateView: View {
    @State var inputText = ""
    var body: some View {
        VStack{
            ZStack{
                Color.orange.edgesIgnoringSafeArea(.all)
                Text("作成")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .padding()
            }.frame(height: 50)
            
            Image("profile_pic") // Replace "profile_pic" with your image name
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .padding()
            
            TextField("キーワード", text: $inputText, prompt: Text("キーワードを入力してください"))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Spacer()
            
            // 送信ボタン
            Button(action: {
                
            }) {
                Text("送信")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .font(.title)
                    .background(Color.blue)
                    .cornerRadius(25)
                    .padding(.horizontal)
            }
            .padding(.top)
            
        }
        Spacer()
    }
}

#Preview {
    CreateView()
}
