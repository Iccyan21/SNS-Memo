//
//  CreateView.swift
//  SNS-Memo
//
//  Created by 水原　樹 on 2024/03/24.
//

import SwiftUI
import PhotosUI
import SwiftData

class CreateViewModel: ObservableObject {
    var model: ModelContext?
    @Published var roomName: String = ""
    @Published var roomImage: Data?
    @Published var item: PhotosPickerItem?
    
    // ビューモデルにモデルコンテキストを設定するためのメソッド。@Environmentから渡されたmodelContextを受け取り、内部プロパティに設定
    
    func setup(model: ModelContext) {
        self.model = model
    }
    
    func addData() {
        guard let model = model else { return }
        let newRoom = Room(room_name: roomName, room_image: roomImage)
        model.insert(newRoom)
        try! model.save()
    }
    // 写真の読み込み
    func loadImage(for item: PhotosPickerItem?) {
        guard let item = item else { return }
        
        item.loadTransferable(type: Data.self) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.roomImage = data
                }
            case .failure(let error):
                print("Error loading image: \(error)")
            }
        }
    }
}


struct CreateView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = CreateViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                Color.orange.edgesIgnoringSafeArea(.all)
                Text("作成")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .padding()
            }.frame(height: 50)
            
            Spacer()
            
            PhotosPicker(selection: $viewModel.item, matching: .images, label: {
                if let data = viewModel.roomImage, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 60, height: 60)
                } else {
                    Image(systemName: "photo.circle.fill")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .foregroundStyle(.secondary)
                }
            })
            
            .onChange(of: viewModel.item) { newItem in
                viewModel.loadImage(for: newItem)
            }
   
            TextField("ルーム名", text: $viewModel.roomName)
                .padding()
                .font(.system(size: 20))  // フォントサイズを大きく設定
                .padding(.horizontal)  // 横方向のパディングを追加してテキストフィールドを広げる
                .frame(height: 50)  // 高さを指定して視覚的なサイズを大きくする
                .overlay(
                    Rectangle()  // 下線を追加
                        .frame(height: 2)
                        .padding(.top, 45),
                    alignment: .bottomLeading
                )
                .padding(.horizontal, 20)  // 全体的なパディングを調整
            Spacer()
            
            Button(action: {
                viewModel.addData()
                dismiss()
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
            
            Spacer()
            
        }
        .onAppear {
            // onAppear内でViewModelの初期化を行う
            viewModel.setup(model: modelContext)
        }
        Spacer()
    }
}

#Preview {
    CreateView()
}
