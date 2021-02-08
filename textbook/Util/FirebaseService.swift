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
    
    static func createChat(buyer: UserInfo, seller: UserInfo, book: Book, completion: @escaping ()-> Void){
        db.collection("chats").addDocument(data: [
            "updated": Date(),
            "buyer": buyer.toDict(),
            "seller": seller.toDict(),
            "book": book.toDict(),
            "buyerId": buyer.id,
            "sellerId": seller.id,
            "bookId": book.id
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
                                    messages.append(Message(sender: sender, messageId: document.documentID, sentDate: data["created"] as! Date, kind: .text(data["body"] as! String)))
                                }
                                completion(messages)
                            }
                        }
                    }
                }
        }
    }
}
