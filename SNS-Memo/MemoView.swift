//
//  MemoView.swift
//  SNS-Memo
//
//  Created by 水原　樹 on 2024/03/24.
//

import SwiftUI

struct MemoView: View {
    @State private var messageText: String = ""
    var body: some View {
        ZStack{
            Color(red: 0.875, green: 0.961, blue: 0.930)
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack {
                    // ここはナビゲーションでどうにかなるかも
                    Button(action: {
                        // 戻るボタンのアクション
                    }) {
                        HStack {
                            Text("トークルーム")
                        }
                        .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // 検索アクション
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        // オプションアクション
                    }) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .font(.title2)
                
                
                // ここもfor文で回して表示
                HStack{
                    Spacer()
                    Text("本能寺集合で")
                        .padding(.all, 10)
                        .background(Color.green)
                        .cornerRadius(15)
                        .foregroundColor(.white)
                }.padding()
                
                Spacer()
                
                HStack {
                    TextField("メッセージを入力", text: $messageText)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                        .padding(.horizontal, 4)
                    
                    Button(action: {
                        // ここにメッセージを送信するためのアクションを記述
                    }) {
                        Image(systemName: "arrow.up.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .background(Color.green)
                            .clipShape(Circle())
                            .foregroundColor(.white)
                    }
                    .padding(.trailing, 4)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color(red: 0.875, green: 0.961, blue: 0.930))
            }
        }
    }
}

#Preview {
    MemoView()
}
