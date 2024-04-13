//
//  Model.swift
//  SNS-Memo
//
//  Created by 水原　樹 on 2024/04/12.
//

import SwiftData
import SwiftUI

// ルームモデル
@Model
final class Room {
    var room_name: String
    var room_image: Data?
    
    @Relationship var memo: [Memo]
    init(room_name: String, room_image: Data? = nil) {
        self.room_name = room_name
        self.room_image = room_image
        self.memo = []
    }
}

// メモモデル
@Model
class Memo {
    var text: String
    var sendTime: Date
    
    @Relationship var room: [Room]
    init(text: String, sendTime: Date) {
        self.text = text
        self.sendTime = sendTime
        self.room = []
    }
}
