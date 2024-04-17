//
//  SNS_MemoApp.swift
//  SNS-Memo
//
//  Created by 水原　樹 on 2024/03/21.
//

import SwiftUI
import SwiftData

@main
struct SNS_MemoApp: App {
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .modelContainer(for: [Room.self,Memo.self])
        }
    }
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
