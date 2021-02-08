//
//  FirebaseService.swift
//  textbook
//
//  Created by Anya Ji on 2/7/21.
//  Copyright © 2021 Anya Ji. All rights reserved.
//

import Foundation
import Firebase

class FirebaseService{
    static let db = Firestore.firestore()
    
    static func toDate(t: Any?) -> Date{
        return (t as! Timestamp).dateValue()
    }
    
    static func createChat(buyer: UserInfo, seller: UserInfo, book: Book, completion: @escaping ()-> Void){
        db.collection("chats").addDocument(data: [
            "updated": Date(),
            "buyer": buyer.toDict(),
            "seller": seller.toDict(),
            "book": book.toDict(),
            "buyerId": buyer.id,
            "sellerId": seller.id,
            "bookId": book.id,
            "userIds": [buyer.id, seller.id]
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            }
            completion()
        }
    }
    
    static func getChat(buyer: UserInfo, seller: UserInfo, book: Book, completion: @escaping ([Message])-> Void){
        db.collection("chats")
            .whereField("buyerId", isEqualTo: buyer.id)
            .whereField("sellerId",isEqualTo: seller.id)
            .whereField("bookId", isEqualTo: book.id)
            .getDocuments { (snap, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else{
                    if snap?.documents == [] {
                        createChat(buyer: buyer, seller: seller, book: book) {
                            completion([])
                        }
                    }
                    else{
                        db.collection("chats").document((snap?.documents[0].documentID)!).collection("thread").getDocuments { (snap, err) in
                            if let err = err {
                                print("Error getting documents: \(err)")
                            } else{
                                var messages:[Message] = []
                                for document in snap!.documents {
                                    let data = document.data()
                                    let sender = Sender(senderId: data["senderEmail"] as! String, displayName: data["senderName"] as! String)
                                    let date = FirebaseService.toDate(t: data["created"])
                                    messages.append(Message(sender: sender, messageId: document.documentID, sentDate: date, kind: .text(data["body"] as! String)))
                                }
                                completion(messages)
                            }
                        }
                    }
                }
        }
    }
    
    static func getContacts(userId: Int, completion: @escaping ([ChatInfo])->Void){
        db.collection("chats").whereField("userIds", arrayContains: userId)
            .order(by: "updated", descending: true)
            .addSnapshotListener({ (snap, err) in
                if let err = err{
                    print("Error getting documents: \(err)")
                }
                else{
                    var contacts:[ChatInfo] = []
                    for document in snap!.documents {
                        let data = document.data()
                        let date = FirebaseService.toDate(t: data["updated"])
                        let buyer = UserInfo.fromDB(data: data["buyer"] as! [String : Any])
                        let seller = UserInfo.fromDB(data: data["seller"] as! [String : Any])
                        let bookInfo = BookInfo.fromDB(data: data["book"] as! [String : Any])
                        contacts.append(ChatInfo(id: document.documentID, updated: date, buyer: buyer, seller: seller, bookInfo: bookInfo, userIds: data["userIds"] as! [Int]))
                    }
                    completion(contacts)
                }
            })
    }
}
