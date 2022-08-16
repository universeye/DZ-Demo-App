//
//  JoesChatModel.swift
//  LogoDemo
//
//  Created by Terry Kuo on 2021/11/11.
//

import Foundation

struct Res: Codable {
    let status: Bool
    let orderName: String
    let chatRoomLogItems: [ChatRoomLogItem]

    enum CodingKeys: String, CodingKey {
        case status
        case orderName = "order_name"
        case chatRoomLogItems = "chat_room_log_items"
    }
}

struct ChatRoomLogItem: Codable {
    let chatText, time, name, empID: String

    enum CodingKeys: String, CodingKey {
        case chatText = "text"
        case time, name
        case empID = "emp_id"
    }
}


extension Res {
    static let dummyData: Res = Res(status: true, orderName: "板橋區-陳旭東", chatRoomLogItems: [
        ChatRoomLogItem(chatText: "message 1", time: "2021/08/09 10:49:11", name: "Pei Yu Lin", empID: "454563535553"),
        ChatRoomLogItem(chatText: "message 2423432432453", time: "2021/08/09 10:48:11", name: "Terry Kuo", empID: "30394985849"),
        ChatRoomLogItem(chatText: "message 352353252352353253253253252525", time: "2021/08/09 10:47:11", name: "James Lin", empID: "3335644985849"),
        ChatRoomLogItem(chatText: "message 45325325", time: "2021/08/09 10:46:11", name: "James Lin", empID: "3335644985849"),
        ChatRoomLogItem(chatText: "message 5", time: "2021/08/09 10:44:11", name: "Terry Kuo", empID: "30394985849"),
        ChatRoomLogItem(chatText: "message 6", time: "2021/08/09 10:44:12", name: "Terry Kuo", empID: "30394985849"),
        ChatRoomLogItem(chatText: "message 7", time: "2021/08/09 10:44:13", name: "Terry Kuo", empID: "30394985849")
    ])
    
}
