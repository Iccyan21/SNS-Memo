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
    @Published var item: PhotosPickerItem?  // PhotosPickerItem を保持するためのプロパティ
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
    @State private var searchText = ""
    @State private var showSearchBar = false
    
    var body: some View {
        NavigationStack{
            
            ZStack{
                Color(red: 0.4549, green: 0.5804, blue: 0.7529)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    HStack {
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
                        NavigationLink(destination: EditView(room: viewModel.room)){
                            Image(systemName: "ellipsis").foregroundColor(.white)
                        }
                    }
                    .padding()
                    
                    MemoListView(viewModel: viewModel, searchText: searchText)
                    
                        
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            viewModel.toggleFlag()
                        }) {
                            Image(systemName: viewModel.flag ? "arrowshape.right.fill" : "arrowshape.left.fill")
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
                        
                        PhotosPicker(
                            selection: $viewModel.item,  // PhotosPickerItem? のバインディング
                            matching: .images,
                            label: {  // クロージャの開始
                                Image(systemName: "photo")
                                    .foregroundColor(.gray)
                                    .imageScale(.large)
                            }  // クロージャの終了
                        )
                        .onChange(of: viewModel.item) { newItem in
                            // 選択された PhotosPickerItem から画像データを非同期でロードする
                            guard let newItem = newItem else { return }
                            newItem.loadTransferable(type: Data.self) { result in
                                switch result {
                                case .success(let data):
                                    if let data = data {
                                        DispatchQueue.main.async {
                                            self.viewModel.image = data// 実際の画像データを更新
                                            viewModel.addMemo()
                                        }
                                    } else {
                                        print("画像データが空です。")
                                    }
                                case .failure(let error):
                                    print("画像のロードに失敗しました: \(error)")
                                }
                            }
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

struct MemoListView: View {
    @ObservedObject var viewModel: MemoViewModel
    var searchText: String
    
    var body: some View {
        ScrollView {
            ScrollViewReader { value in
                VStack {
                    ForEach(viewModel.room.memo.filter { memo in
                        searchText.isEmpty || memo.text.localizedCaseInsensitiveContains(searchText)
                    }.sorted(by: { $0.sendTime < $1.sendTime }), id: \.id) { memo in
                        HStack(alignment: .bottom) {
                            if memo.flag {
                                VStack(alignment: .trailing) {
                                    
                                    Text(memo.sendTime, style: .time)
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                    if let image = memo.image, let uiImage = UIImage(data: image) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFit() // 画像のサイズを適切に調整
                                            .frame(width: 200, height: 200) // 画像のフレームサイズ指定
                                            .cornerRadius(15) // 角を丸く
                                    }
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
                    if let lastId = viewModel.room.memo.sorted(by: { $0.sendTime < $1.sendTime }).last?.id {
                        value.scrollTo(lastId, anchor: .bottom)
                    }
                }
                .onChange(of: viewModel.room.memo) {
                    if let lastId = viewModel.room.memo.sorted(by: { $0.sendTime < $1.sendTime }).last?.id {
                        value.scrollTo(lastId, anchor: .bottom)
                    }
                }
            }
        }
        .padding()
    }
}
