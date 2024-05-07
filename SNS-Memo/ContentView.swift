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
    @Environment(\.modelContext) var model
    @State private var searchText = ""
    @Query(animation: .snappy) var rooms: [Room]
    
    var filteredRooms: [Room] {
        if searchText.isEmpty {
            return rooms
        } else {
            return rooms.filter { $0.room_name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if rooms.isEmpty {
                    NavigationLink(destination: CreateView()) {
                        // ローカライズ対応
                        Text("RoomCreate")
                    }
                } else {
                    RoomListView(filteredRooms: filteredRooms, deleteRoom: deleteRoom)
                }
                
                Spacer()
                createButton
                // バナー広告
                AdMobBannerView()
                    .frame(height: 60)
            } // VStack
            .navigationTitle("Home Heder")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .toolbarBackground(Color.orange, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarTitleDisplayMode(.inlineLarge)
            // これで白色
            .toolbarColorScheme(.dark)
        } // navigationStack
    }
    
    var createButton: some View {
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
            .padding()
        }
    }
    
    func deleteRoom(at offsets: IndexSet) {
        offsets.forEach { index in
            let room = rooms[index]
            model.delete(room)
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: [Room.self,Memo.self])
}

struct RoomListView: View {
    let filteredRooms: [Room]
    var deleteRoom: (IndexSet) -> Void
    
    var body: some View {
        List {
            Section {
                ForEach(filteredRooms) { room in
                    NavigationLink(destination: MemoView(viewModel: MemoViewModel(memo: room))) {
                        RoomRow(room: room)
                    }
                }
                .onDelete(perform: deleteRoom)
            } header: {
                Text("フレンド: \(filteredRooms.count)")
            }
        }
        .listStyle(.grouped)
        .scrollContentBackground(.hidden)
        .background(Color.white)
    }
}

struct RoomRow: View {
    let room: Room
    
    var body: some View {
        HStack {
            if let imageData = room.room_image, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 60, height: 60)
            } else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 60, height: 60)
                    .foregroundColor(.secondary)
            }
            
            VStack(alignment: .leading) {
                HStack{
                    Text(room.room_name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    if let lastMemo = room.memo.sorted(by: { $0.sendTime > $1.sendTime }).first {
                        
                        
                        Spacer()
                        
                        Text(lastMemo.sendTime, style: .time)
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                    }
                }
                .padding(.bottom, 10)
    
                if let lastMemo = room.memo.sorted(by: { $0.sendTime > $1.sendTime }).first {
                    Text(lastMemo.text)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
        }
    }
}
