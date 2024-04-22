//
//  Model.swift
//  SNS-Memo
//
//  Created by 水原　樹 on 2024/04/12.
//

import SwiftData
import Foundation

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
final class Memo {
    var text: String
    var image: Data?
    var sendTime: Date
    var flag: Bool  // この行を追加してBool型のflagを含むようにする
    
    @Relationship var room: [Room]
    init(text: String, image: Data? = nil, sendTime: Date, flag: Bool = true) {
        self.text = text
        self.sendTime = sendTime
        self.image = image
        self.flag = flag  
        self.room = []
    }
}

