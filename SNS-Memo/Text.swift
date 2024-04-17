//
//  Text.swift
//  SNS-Memo
//
//  Created by 水原　樹 on 2024/04/18.
//

import SwiftUI

struct TextView: View {
    var body: some View {
        NavigationStack {
            VStack{
                Text("Hello, World!")
            }
            
                .navigationTitle("ホーム")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            print("アクション実行")
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
        }
    }
}

#Preview {
    TextView()
}
