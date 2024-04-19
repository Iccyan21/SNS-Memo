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
        NavigationStack{
            
            ZStack{
                Color(red: 0.4549, green: 0.5804, blue: 0.7529)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    HStack {
                        Text(viewModel.memo.room_name)
                            .foregroundColor(.white)
                        Spacer()
                        Button(action: {
                            // 検索アクション
                        }) {
                            Image(systemName: "magnifyingglass").foregroundColor(.white)
                        }
                        NavigationLink(destination: EditView(room: viewModel.memo)){
                            Image(systemName: "ellipsis").foregroundColor(.white)
                        }
                    }
                    .padding()
                    ForEach(viewModel.memo.memo) { memo in
                        HStack(alignment: .bottom){
                        
                        Spacer()
                        
                            VStack(alignment: .trailing) {
                                Text(memo.sendTime,style: .time)
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                            Text(memo.text)
                                .bold()
                                .padding(10)
                                .foregroundColor(.white)
                                .background(Color.green)
                                .cornerRadius(25)
                        }
                    } .padding()
                    
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
                }
            }
            .navigationTitle("トークルーム")
            .toolbarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark)
        } // NavigationStack
    }
}

