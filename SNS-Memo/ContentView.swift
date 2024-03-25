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
        NavigationView{
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
                // ここをfor文で回して表示
                NavigationLink(destination: MemoView()) {
                    HStack {
                        Image(systemName: "person")
                            .resizable()
                            .padding()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            .shadow(radius: 3)
                        
                        VStack(alignment: .leading) {
                            Text("織田信長")
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text("本能寺集合で")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }.padding()
                }
                NavigationLink(destination: MemoView()) {
                    HStack {
                        Image(systemName: "person")
                            .resizable()
                            .padding()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            .shadow(radius: 3)
                        
                        
                        VStack(alignment: .leading) {
                            Text("徳川家康")
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text("今日きびい")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }.padding()
                }
                NavigationLink(destination: MemoView()) {
                    HStack {
                        Image(systemName: "person")
                            .resizable()
                            .padding()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                            .shadow(radius: 3)
                        
                        
                        VStack(alignment: .leading) {
                            Text("羽柴秀吉")
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text("光秀後は頼むわ")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }.padding()
                }
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
}

#Preview {
    ContentView()
}
