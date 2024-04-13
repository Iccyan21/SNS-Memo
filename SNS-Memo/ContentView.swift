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
    @Environment (\.modelContext) var moc
    
    @Query (animation: .snappy) var rooms: [Room]
    var body: some View {
        NavigationStack{
            Form{
                ForEach(rooms){ room in
                    Text(room.room_name)
                }
            }
        }
        Text("Hello")
    }
}

#Preview {
    ContentView()
}
#imageLiteral(resourceName: "スクリーンショット 2024-04-13 13.25.29.png")
