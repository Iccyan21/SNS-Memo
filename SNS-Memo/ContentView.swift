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
    
    @State var inputText = ""
    @Query (animation: .snappy) var rooms: [Room]
    var body: some View {
        NavigationStack{
            VStack {
                ZStack{
                    Color.orange.edgesIgnoringSafeArea(.all)
                    Text("ホーム")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .background(Color.orange)
                        .padding()
                }.frame(height: 50)
                // ここはもう少しデザインをカスタマイズ
                TextField("キーワード",text: $inputText,prompt: Text("ルーム名で検索してください"))
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                // ここをfor文で回して表示
                VStack{
                    if rooms.isEmpty{
                        NavigationLink(destination: CreateView()) {
                            Text("ルームを作成しよう")
                        }
                    } else {
                        List{
                            ForEach(rooms){ room in
                                NavigationLink (destination: MemoView(viewModel: MemoViewModel(memo: room))){
                                    HStack{
                                        Image(uiImage: UIImage(data: room.room_image!)!)
                                            .resizable()
                                            .clipShape(Circle())
                                            .frame(width: 60, height: 60)
                                        
                                        VStack{
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
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Room.self,Memo.self])
}
