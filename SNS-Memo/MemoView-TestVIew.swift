//
//  MemoView-TestVIew.swift
//  SNS-Memo
//
//  Created by 水原　樹 on 2024/04/18.
//

import SwiftUI

struct MemoView_TestVIew: View {
    @State var inputText = ""
    @State private var searchText = ""
    @State private var showSearchBar = false 
    @ObservedObject var reward = Reward()
    var body: some View {
        Group{
            NavigationStack{
                ZStack{
                    Color(red: 0.4549, green: 0.5804, blue: 0.7529)
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        HStack{
                            if showSearchBar {
                                TextField("Search...", text: $searchText)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                    .transition(.move(edge: .top).combined(with: .opacity)) // アニメーションで表示
                                    .animation(.default, value: showSearchBar)
                            }
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    showSearchBar.toggle() // 検索バーの表示をトグルする
                                }
                            }) {
                                Image(systemName: "magnifyingglass").foregroundColor(.white)
                            }
                            .padding()
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
                        
                        Button(action: {
                            reward.ShowReward()
                        }) {
                            Text(reward.rewardLoaded ? "リワード広告表示" : "読み込み中...")
                        }
                        .onAppear() {
                            reward.LoadReward()
                        }
                        .disabled(!reward.rewardLoaded)
                        
                        Spacer()
                        
             
                        HStack {
                            Button(action: {
                                // ここにアクションを記述
                            }) {
                                Image(systemName: "arrowshape.right.fill")
                                    .foregroundColor(.blue)
                                    .imageScale(.large)
                            }
                            
                            Button(action: {
                                // ここにアクションを記述
                            }) {
                                Image(systemName: "camera")
                                    .foregroundColor(.gray)
                                    .imageScale(.large)
                            }
                            
                            Button(action: {
                                // ここにアクションを記述
                            }) {
                                Image(systemName: "photo")
                                    .foregroundColor(.gray)
                                    .imageScale(.large)
                            }
                            
                            TextField("メッセージを入力", text: $inputText)
                                .padding(10)
                                .background(Color.white)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                                .padding(.horizontal, 4)
                            
                            Button(action: {
                                // ここにアクションを記述
                            }) {
                                Image(systemName: "arrow.up.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .background(Color.blue)
                                    .clipShape(Circle())
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color(white: 0.95))
                
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
