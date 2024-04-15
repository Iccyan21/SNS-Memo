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
                TextField("キーワード",text: $inputText,prompt: Text("キーワードを入力してください"))
                    .padding()
                // ここをfor文で回して表示
                VStack{
                    if rooms.isEmpty{
                        NavigationLink(destination: CreateView()) {
                            Text("アカウントを登録しよう")
                        }
                    } else {
                        ForEach(rooms){ room in
                            HStack{
                                Image(uiImage: UIImage(data: room.room_image!)!)
                                    .resizable()
                                    .clipShape(Circle())
                                    .frame(width: 75, height: 75)
                                
                                VStack{
                                    Text(room.room_name)
                                }
                            }
                        }
                        
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

