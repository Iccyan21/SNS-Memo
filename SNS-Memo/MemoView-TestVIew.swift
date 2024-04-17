//
//  MemoView-TestVIew.swift
//  SNS-Memo
//
//  Created by 水原　樹 on 2024/04/18.
//

import SwiftUI

struct MemoView_TestVIew: View {
    @State var inputText = ""
    var body: some View {
        Group{
            NavigationStack{
                ZStack{
                    Color(red: 0.4549, green: 0.5804, blue: 0.7529)
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        HStack{
                            Spacer()
                            Button(action: {
                                // 検索アクション
                            }) {
                                Image(systemName: "magnifyingglass").foregroundColor(.white)
                            }
                            Button(action: {
                                // オプションアクション
                            }) {
                                Image(systemName: "ellipsis").foregroundColor(.white)
                            }
                            
                        }
                        .padding()
                        HStack(alignment: .bottom){
    
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("23:45")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                            Text("こんにちわ")
                                .bold()
                                .padding(10)
                                .foregroundColor(.white)
                                .background(Color.green)
                                .cornerRadius(25)
                        } .padding()
                        
                        Spacer()
                        
                        
                        
                        HStack {
                            TextField("メッセージを入力", text: $inputText)
                                .padding(10)
                                .background(Color.white)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.gray, lineWidth: 0.5)
                                )
                                .padding(.horizontal, 4)
                            
                            
                            
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        
                    }
                    
                }
                .navigationTitle("トークルーム")
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            print("Hello")
                        }) {
                            Image(systemName: "magnifyingglass").foregroundColor(.white)
                        }
                        
                    }
                }
                .toolbarTitleDisplayMode(.inlineLarge)
            }
        }
    }
}

#Preview {
    MemoView_TestVIew()
}
