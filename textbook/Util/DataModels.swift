//
//  bookData.swift
//  textbook
//
//  Created by Zuhao Hua on 11/27/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import Foundation
import MessageKit

enum SellType{
    case sell
    case exchange
}

struct RecentlyAdded: Codable{
    
    var success: Bool
    var data:[Book]
}


struct Book: Codable,Equatable{
    static func == (lhs: Book, rhs: Book) -> Bool {
        if lhs.id == rhs.id{
            return true
        }
        else{
            return false
        }
    }
    
    var id: Int
    var image: [BookImage]
    var title: String
    var author: String
    var courseName: String
    var isbn: String
    var edition: String
    var price: String
    var available: Bool
    var createdAt: String
    var updatedAt: String?
    var sellerId: Int
    var condition: String
    
    func toDict() -> [String: Any]{
        return [
            "id": id,
            "title": title,
            "author": author,
            "courseName": courseName,
            "isbn": isbn,
            "edition": edition,
            "price": price,
            "available": available,
            "condition": condition
        ]
    }
    
    
}

struct BookImage: Codable{
    
    var bookId: Int
    var url:String
    var createdAt: String
    
}

struct uploadBookBackEndNoImageStruct: Codable{
    
    var title: String
    var price: Double
    var sellerId: Int
    var image: String
    var author: String
    var courseName: String
    var isbn: String
    var edition: String
    var condition: String
    
}

struct uploadBookBackEndResponse: Codable{
    var success: Bool
    var data:uploadBookBackEndResponseStruct
}

struct uploadBookBackEndResponseStruct: Codable{
    var id: Int
    var image: [BookImage]
    var title: String
    var author: String
    var courseName: String
    var isbn: String
    var edition: String
    var price: String
    var available: Bool
    var createdAt: String
    var updatedAt: String?
    var sellerId: Int
}

struct addCartStruct:Codable{
    var bookId:Int
}

struct userInfoResponse:Codable{
    var success: Bool
    var data:userInfoResponseDataStruct
}

struct userInfoResponseDataStruct:Codable{
    var id:Int
    var email:String
    var name:String
    var selling:[Book]
    var cart:[Book]
}

class User: Codable {
    var session_token: String
    var session_expiration: String
    var update_token: String
    var id:Int
    
    init(session_token: String, session_expiration: String, update_token: String, userId:Int) {
        self.session_token = session_token
        self.session_expiration = session_expiration
        self.update_token = update_token
        self.id = userId
    }
}

struct accountDetails: Codable {
    var session_token: String
    var session_expiration: String
    var update_token: String
    var id:Int
}

struct accountError: Codable {
    var error: String
}

struct UserInfo: Codable {
    var id: Int
    var email: String
    var name: String
    
    func toDict() -> [String: Any]{
        return ["id": id,
                "email": email,
                "name": name]
    }
    
    static func fromDB(data: [String: Any]) -> UserInfo{
        return UserInfo(id: data["id"] as! Int, email: data["email"] as! String, name: data["name"] as! String)
    }
}

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

struct BookInfo{
    var id: Int
    var title: String
    var author: String
    var courseName: String
    var isbn: String
    var edition: String
    var price: String
    var available: Bool
    var condition: String
    
    static func fromDB(data: [String: Any]) -> BookInfo{
        let id = data["id"] as! Int
        let title = data["title"] as! String
        let author = data["author"] as! String
        let courseName = data["courseName"] as! String
        let isbn = data["isbn"] as! String
        let edition = data["edition"] as! String
        let price = data["price"] as! String
        let available = data["available"] as! Bool
        let condition = data["condition"] as! String
        
        return BookInfo(id: id, title: title, author: author, courseName: courseName, isbn: isbn, edition: edition, price: price, available: available, condition: condition)
    }
}

struct ChatInfo {
    var id: String
    var updated: Date
    var buyer: UserInfo
    var seller: UserInfo
    var bookInfo: BookInfo
    var userIds: [Int]
}
