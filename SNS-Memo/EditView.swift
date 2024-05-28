//
//  EditView.swift
//  SNS-Memo
//
//  Created by 水原　樹 on 2024/04/18.
//

import SwiftUI
import PhotosUI
import SwiftData

class EditViewModel: ObservableObject {
    var model: ModelContext?
    @Published var room: Room?
    @Published var room_name: String
    @Published var room_image: Data?
    @Published var item: PhotosPickerItem?
    
    
    // 編集読み込み
    init(room: Room? = nil) {
        if let room = room{
            self.room = room
            self.room_name = room.room_name
            self.room_image = room.room_image  // ここで既存の画像データをセット
        } else {
            self.room = nil
            self.room_name = ""
            self.room_image = nil
        }
    }
    
    func save() {
        if let room = room {
            // Edit the existing animal
            room.room_name = room_name
            room.room_image = room_image
        }
    }
    
    // ビューモデルにモデルコンテキストを設定するためのメソッド。
    // @Environmentから渡されたmodelContextを受け取り、内部プロパティに設定
    
    func setup(model: ModelContext) {
        self.model = model
    }
    
    // 写真の読み込み
    func loadImage(for item: PhotosPickerItem?) {
        guard let item = item else { return }
        
        item.loadTransferable(type: Data.self) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.room_image = data
                }
            case .failure(let error):
                print("Error loading image: \(error)")
            }
        }
    }
}


struct EditView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: EditViewModel
    
    init(room: Room) {
        _viewModel = StateObject(wrappedValue: EditViewModel(room: room))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                
                PhotosPicker(selection: $viewModel.item, matching: .images, label: {
                    if let data = viewModel.room_image, let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 150, height: 150)
                            .overlay(Circle().stroke(Color.green, lineWidth: 4))
                    } else {
                        Image(systemName: "photo.circle.fill")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .foregroundColor(.secondary)
                            .overlay(Circle().stroke(Color.green, lineWidth: 4))
                    }
                })
                .onChange(of: viewModel.item) { newItem in
                    viewModel.loadImage(for: newItem)
                }
                
                TextField("ルーム名", text: $viewModel.room_name)
                    .padding()
                    .font(.system(size: 20))
                    .padding(.horizontal)
                    .frame(height: 50)
                    .overlay(
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(Color.green)
                            .padding(.top, 45),
                        alignment: .bottomLeading
                    )
                    .padding(.horizontal, 20)
                
                Spacer()
                
                Button(action: {
                    viewModel.save()
                    dismiss()
                }) {
                    Text("Update Room")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .font(.title)
                        .background(Color.green)
                        .cornerRadius(25)
                        .padding(.horizontal)
                }
                .padding(.top)
                
                Spacer()
                
            }
            .navigationTitle("Edit Room")
            .toolbarBackground(Color.green, for: .navigationBar)
            .toolbarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark)
        }
        .onAppear {
            viewModel.setup(model: modelContext)
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

