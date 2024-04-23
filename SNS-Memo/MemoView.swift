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
    @Published var room: Room
    @Published var text: String = ""
    @Published var image: Data?
    @Published var flag: Bool = true
    @State  var sendTime = Date()
    
    init(memo: Room) {
        self.room = memo
    }
    
    func addMemo() {
        let newMemo = Memo(text: self.text, image: image, sendTime: Date(),flag: self.flag)
        self.room.memo.append(newMemo)
        self.text = "" // テキストフィールドをクリア
        self.image = nil // 画像をクリア
    }
    // Flag変更
    func toggleFlag(){
        self.flag.toggle()
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
                        Text(viewModel.room.room_name)
                            .foregroundColor(.white)
                        Spacer()
                        Button(action: {
                            // 検索アクション
                        }) {
                            Image(systemName: "magnifyingglass").foregroundColor(.white)
                        }
                        NavigationLink(destination: EditView(room: viewModel.room)){
                            Image(systemName: "ellipsis").foregroundColor(.white)
                        }
                    }
                    .padding()
                    
                    ScrollView {
                        ScrollViewReader { value in
                            VStack {
                                ForEach(viewModel.room.memo.sorted(by: { $0.sendTime < $1.sendTime }), id: \.id) { memo in
                                    HStack(alignment: .bottom) {
                                        if memo.flag {
                                            VStack(alignment: .trailing) {
                                                Text(memo.sendTime, style: .time)
                                                    .font(.caption2)
                                                    .foregroundColor(.secondary)
                                                Text(memo.text)
                                                    .bold()
                                                    .padding(10)
                                                    .foregroundColor(.white)
                                                    .background(Color.green)
                                                    .cornerRadius(25)
                                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                            }
                                            Spacer()
                                        } else {
                                            Spacer()
                                            VStack(alignment: .leading) {
                                                Text(memo.sendTime, style: .time)
                                                    .font(.caption2)
                                                    .foregroundColor(.secondary)
                                                Text(memo.text)
                                                    .bold()
                                                    .padding(10)
                                                    .foregroundColor(.white)
                                                    .background(Color.blue)
                                                    .cornerRadius(25)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                            }
                                        }
                                    }
                                }
                            }
                            .onAppear {
                                // 最後のメモのIDにスクロール
                                if let lastId = viewModel.room.memo.sorted(by: { $0.sendTime < $1.sendTime }).last?.id {
                                    value.scrollTo(lastId, anchor: .bottom)
                                }
                            }
                            .onChange(of: viewModel.room.memo) { _ in
                                // メモが更新されたときも最下部にスクロール
                                DispatchQueue.main.async {
                                    if let lastId = viewModel.room.memo.sorted(by: { $0.sendTime < $1.sendTime }).last?.id {
                                        value.scrollTo(lastId, anchor: .bottom)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                        
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            viewModel.toggleFlag()
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
                        
                        TextField("メッセージを入力", text: $viewModel.text)
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .padding(.horizontal, 4)
                        
                        Button(action: viewModel.addMemo) {
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
            .toolbarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark)
        } // NavigationStack
    }
}

