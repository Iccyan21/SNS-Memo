//
//  MemoView.swift
//  SNS-Memo
//
//  Created by 水原　樹 on 2024/03/24.
//

import SwiftUI
import SwiftData
import PhotosUI


class MemoViewModel: ObservableObject {
    @Published var memo: Room
    @Published var text: String = ""
    @State private var sendTime = Date()
    
    init(memo: Room) {
        self.memo = memo
    }
    
    func addMemo() {
        let newMemo = Memo(text: self.text, sendTime: Date())
        self.memo.memo.append(newMemo)
        self.text = "" // テキストフィールドをクリア
    }
}

struct MemoView: View {
    @StateObject var viewModel: MemoViewModel
    
    var body: some View {
        ZStack{
            Color(red: 0.875, green: 0.961, blue: 0.930)
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack {
                    Button("トークルーム") {
                        // 以前はここに戻るボタンのアクションがあるかもしれませんが、ナビゲーションリンクの使用を推奨します
                    }
                    .foregroundColor(.white)
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
                .background(Color.green)
                .foregroundColor(.white)
                .font(.title2)
                
                HStack{
                    Spacer()
                    
                    VStack {
                        ForEach(viewModel.memo.memo) { memo in
                            VStack(alignment: .leading) {
                                Text(memo.text)
                                    .padding()
                                    .background(Color.green)
                                    .cornerRadius(15)
                                    .foregroundColor(.white)
                                Text(memo.sendTime, style: .time)
                                    .font(.subheadline)
                            }
                        }
                    }.padding()
                }
                
                
                
                
                Spacer()
                
                HStack {
                    TextField("メッセージを入力", text: $viewModel.text)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                        .padding(.horizontal, 4)
                    
                    Button(action: viewModel.addMemo) {
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

