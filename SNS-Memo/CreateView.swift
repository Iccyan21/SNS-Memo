//
//  CreateView.swift
//  SNS-Memo
//
//  Created by 水原　樹 on 2024/03/24.
//

import SwiftUI
import PhotosUI
import SwiftData

struct CreateView: View {
    @Environment(\.modelContext) var model
    @Environment(\.dismiss) var dismiss
    
    @State private var room_name: String = ""
    
    @State private var item: PhotosPickerItem?
    @State private var room_image: Data?
    
    var body: some View {
        VStack{
            ZStack{
                Color.orange.edgesIgnoringSafeArea(.all)
                Text("作成")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .padding()
            }.frame(height: 50)
            
            Spacer()
            
            PhotosPicker(selection: self.$item, matching: .images,label: {
                if let data = self.room_image, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 60, height: 60)
                } else {
                    Image(systemName: "photo.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundStyle(.secondary)
                }
            })
            .onChange(of: item) { newItem in
                guard let newItem = newItem else { return }
                
                newItem.loadTransferable(type: Data.self) { result in
                    switch result {
                    case .success(let data):
                        self.room_image = data
                    case .failure(let error):
                        print("Error loading image: \(error)")
                    }
                }
            }
            
            TextField( "ルーム名", text: self.$room_name)
                .padding()
            Spacer()
            
            // 送信ボタン
            Button(action: {
                addData()
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
            
        }
        Spacer()
        
        
    }
    func addData() {
        let new = Room(room_name: self.room_name,room_image: self.room_image)
        self.model.insert(new)
        try! self.model.save()
        
        dismiss()
    }
}

#Preview {
    CreateView()
}
