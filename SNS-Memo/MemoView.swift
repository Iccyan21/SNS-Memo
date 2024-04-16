//
//  MemoView.swift
//  SNS-Memo
//
//  Created by 水原　樹 on 2024/03/24.
//

import SwiftUI
import SwiftData
import PhotosUI


struct MemoView: View {
    @Bindable var memo: Room
    @State private var show: Bool = false
    @State private var messageText: String = ""
    @State private var text = ""
    @State private var sendTime = Date()
    
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
                
                
                
                HStack{
                    
                    Spacer()
                    VStack{
                        ForEach(memo.memo){ memo in
                            Text(memo.text)
                                .padding(.all, 10)
                                .background(Color.green)
                                .cornerRadius(15)
                                .foregroundColor(.white)
                            Text(memo.sendTime, style: .time)
                                .padding(.all, 10)
                                .font(.subheadline)
                            
                        }
                    }
                    
                }.padding()
                
                Spacer()
                
                HStack {
                    TextField("メッセージを入力", text: $text)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                        .padding(.horizontal, 4)
                    
                    Button(action: {
                        addMemo()
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
    func addMemo(){
        let new = Memo(text: self.text, sendTime: .now)
        memo.memo.append(new)
        
        
    }
}

