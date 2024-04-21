//
//  ContentView.swift
//  SNS-Memo
//
//  Created by 水原　樹 on 2024/03/21.
//

import SwiftUI
import SwiftData
import PhotosUI

struct ContentView: View {
    @Environment (\.modelContext) var model
    @State private var searchText = ""
    @Query (animation: .snappy) var rooms: [Room]
    
    // 検索機能
    var filteredRooms: [Room] {
        if searchText.isEmpty {
            return rooms
        } else {
            return rooms.filter { $0.room_name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                
                // ここはもう少しデザインをカスタマイズ
                
                // ここをfor文で回して表示
                VStack{
                    if rooms.isEmpty{
                        NavigationLink(destination: CreateView()) {
                            Text("ルームを作成しよう")
                        }
                    } else {
                        
                        List{
                            Section{
                                ForEach(filteredRooms) { room in
                                    NavigationLink(destination: MemoView(viewModel: MemoViewModel(memo: room))) {
                                        HStack {
                                            if let imageData = room.room_image, let uiImage = UIImage(data: imageData) {
                                                Image(uiImage: uiImage)
                                                    .resizable()
                                                    .clipShape(Circle())
                                                    .frame(width: 60, height: 60)
                                            } else {
                                                Image(systemName: "photo.fill") // 画像がない場合の代替画像
                                                    .resizable()
                                                    .clipShape(Circle())
                                                    .frame(width: 60, height: 60)
                                                    .foregroundColor(.secondary)
                                            }
                                            
                                            VStack {
                                                Text(room.room_name)
                                                    .font(.headline)
                                                    .foregroundColor(.primary)
                                            }
                                            Spacer()
                                        }
                                    }
                                }
                                
                                // 削除機能
                                .onDelete{ IndexSet in
                                    IndexSet.forEach{ index in
                                        let room = rooms[index]
                                        model.delete(room)
                                    }
                                }
                            } header: {
                                Text("ルーム")
                            }
                        }// List
                        .listStyle(.grouped)
                        // Listの背景色を消す
                        .scrollContentBackground(.hidden)
                        .background(Color.white)
                    }
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    NavigationLink(destination: CreateView()) {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.orange)
                            .clipShape(Circle())
                    }
                    .padding() // 必要に応じてパディングを調整
                }
            }
            .navigationTitle("ホーム")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .toolbarBackground(Color.orange, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarTitleDisplayMode(.inlineLarge)
            // これで白色
            .toolbarColorScheme(.dark)
            
        } // NavigationStack
        
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Room.self,Memo.self])
}
