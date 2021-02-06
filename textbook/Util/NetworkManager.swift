//
//  NetworkManager.swift
//  textbook
//
//  Created by Zuhao Hua on 12/5/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//
import Foundation
import Alamofire

class NetworkManager {
    
    static var currentUser: User!
    
    //    private static let host = "https://hackathonbooksmart.herokuapp.com"
    
    private static let host = "http://0.0.0.0:5000"
    
    static func getAll(completion: @escaping ([Book]) -> Void) {
        let endpoint = "\(host)/api/books/all/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let recentlyAddedResponse = try? jsonDecoder.decode(RecentlyAdded.self, from: data) {
                    // Instructions: Use completion to handle response
                    let receivedData = recentlyAddedResponse.data
                    completion(receivedData)
                }
                else{
                    print("could not decode data at getting all books")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func searchBooks(name:String, completion: @escaping ([Book]) -> Void) {
        let param:[String:Any] = [
            "text": name
        ]
        let endpoint = "\(host)/api/books/search/"
        AF.request(endpoint, method: .post, parameters: param, encoding: JSONEncoding.default).validate().responseData { response in
            
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let recentlyAddedResponse = try? jsonDecoder.decode(RecentlyAdded.self, from: data) {
                    let receivedData = recentlyAddedResponse.data
                    completion(receivedData)
                }
                else{
                    print("could not decode data at searching books")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    static func postBook(newBookData:uploadBookBackEndNoImageStruct,completion:@escaping (uploadBookBackEndResponseStruct)->Void){
        
        let parameters: [String:Any] = [
            "title":newBookData.title,
            "price":newBookData.price,
            "sellerId":newBookData.sellerId,
            "image":"data:image/jpeg;base64,"+newBookData.image,
            "author":newBookData.author,
            "courseName":newBookData.courseName,
            "isbn":newBookData.isbn,
            "edition":newBookData.edition,
            "condition":newBookData.condition
        ]
        
        
        
        let endpoint = "\(host)/api/books/sell/"
        
        AF.request(endpoint,method: .post,parameters: parameters,encoding: JSONEncoding.default).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                
                let jsonDecoder = JSONDecoder()
                if let responseFromBackEnd = try? jsonDecoder.decode(uploadBookBackEndResponse.self, from: data) {
                    // Instructions: Use completion to handle response
                    let receivedData = responseFromBackEnd.data
                    
                    completion(receivedData)
                }
                else{
                    print("decode error at posting a new book")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    static func addToCart(book:addCartStruct,currentUserId:Int,updateToken:String, completion:@escaping ([Book])->Void) {
        
        let parameters:[String:Any] = [
            "bookId":book.bookId
        ]
        
        let headers:HTTPHeaders = [
            "Authorization": "Bearer \(updateToken)",
            "Accept": "text/html",
            "Content-Type": "text/html" ]
        //        "Accept": "application/json",
        //        "Content-Type": "application/json" ]
        
        let endpoint = "\(host)/api/users/\(currentUserId)/cart/add/"
        AF.request(endpoint,method:.post,parameters:parameters,encoding: JSONEncoding.default,headers: headers).validate().response{ (response) in
            switch response.result{
            case.success(let data):
                
                let jsonDecoder = JSONDecoder()
                if data == nil {
                    print("no return data")
                }
                
                if let responseFromBackEnd = try? jsonDecoder.decode(userInfoResponse.self, from: data!) {
                    
                    completion(responseFromBackEnd.data.cart)
                }
                
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func deleteOneBookFromCart(currentUserId:Int,bookId:Int,updateToken:String,completion:@escaping ([Book])->Void) {
        
        let parameters:[String:Any] = [
            "bookId":bookId
        ]
        
        let headers:HTTPHeaders = [
            "Authorization": "Bearer \(updateToken)",
            "Accept": "text/html",
            "Content-Type": "text/html" ]
        
        let endpoint = "\(host)/api/users/\(currentUserId)/cart/remove/"
        AF.request(endpoint,method:.delete,parameters:parameters,encoding: JSONEncoding.default,headers: headers).validate().response{ (response) in
            switch response.result{
            case.success(let data):
                let jsonDecoder = JSONDecoder()
                if data == nil {
                    print("no return data")
                }
                
                if let responseFromBackEnd = try? jsonDecoder.decode(userInfoResponse.self, from: data!) {
                    completion(responseFromBackEnd.data.cart)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    static func getUserCart(currentUserId:Int,completion:@escaping ([Book])->Void){
        
        let endpoint = "\(host)/api/users/\(currentUserId)/"
        
        AF.request(endpoint,method: .get,encoding: JSONEncoding.default).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let responseFromBackEnd = try? jsonDecoder.decode(userInfoResponse.self, from: data) {
                    completion(responseFromBackEnd.data.cart)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    static func getUserInfo(currentUserId:Int,completion:@escaping (userInfoResponseDataStruct)->Void){
        
        let endpoint = "\(host)/api/users/\(currentUserId)/"
        
        AF.request(endpoint,method: .get,encoding: JSONEncoding.default).validate().responseData { (response) in
            switch response.result {
            case .success( let data):
                let jsonDecoder = JSONDecoder()
                if let responseFromBackEnd = try? jsonDecoder.decode(userInfoResponse.self, from: data) {
                    completion(responseFromBackEnd.data)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func registerUser(email: String, name: String, password: String, completion: @escaping (accountDetails) -> Void, errorCompletion: @escaping (String) -> Void) {
        
        let parameters: [String: Any] = [
            "email":email,
            "name": name,
            "password": password
        ]
        
        let endpoint = "\(host)/api/register/"
        
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let registerResponse = try? JSONDecoder().decode(accountDetails.self, from: data) {
                    let registerDetails = registerResponse
                    completion(registerDetails)
                } else {
                    if let errorResponse = try? JSONDecoder().decode(accountError.self, from: data) {
                        let errorMessage = errorResponse.error
                        errorCompletion(errorMessage)
                    } else {
                        print("Register Error")
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func loginUser(email: String, password: String, completion: @escaping (accountDetails) -> Void, errorCompletion: @escaping (String) -> Void) {
        
        let parameters: [String: Any] = [
            "email":email,
            "password": password
        ]
        
        let endpoint = "\(host)/api/login/"
        
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let loginResponse = try? JSONDecoder().decode(accountDetails.self, from: data) {
                    let loginDetails = loginResponse
                    completion(loginDetails)
                } else {
                    if let errorResponse = try? JSONDecoder().decode(accountError.self, from: data) {
                        let errorMessage = errorResponse.error
                        errorCompletion(errorMessage)
                    } else {
                        print("Error")
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
    
    
}
