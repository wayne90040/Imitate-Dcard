//
//  DcardController.swift
//  Dcard_API
//
//  Created by Wei Lun Hsu on 2020/8/16.
//  Copyright © 2020 Wei Lun Hsu. All rights reserved.
//

import Foundation
import UIKit

class DcardController {
    static let shared = DcardController()
    let baseURL = "https://dcard.tw/_api/"
    
    func fetchItems(type: String, limit: Int, completion: @escaping ([Dcard]?) -> Void){
        
        let url = URL(string: baseURL + type + "?limit=" + limit.description)!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let items = try? jsonDecoder.decode([Dcard].self, from: data) {
                    completion(items)
                } else {
                    completion(nil)
                }
            }
        task.resume()
    }
    
    func fetchContent(id: Int, completion: @escaping (Content?) -> Void){
        let url = URL(string: baseURL + "posts/" + id.description)!
        let task = URLSession.shared.dataTask(with: url){(data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let items = try? jsonDecoder.decode(Content.self, from: data){
                completion(items)
                
            }else{
                completion(nil)
                
            }
        }
        task.resume()
    }
    
    func fetchComment(id: Int, completion: @escaping ([Comment]?) -> Void){
        let url = URL(string: baseURL + "posts/" + id.description + "/comments")!
        print(url)
        
        let task = URLSession.shared.dataTask(with: url){(data, response, error) in
            let json = JSONDecoder()
            if let data = data, let items = try? json.decode([Comment].self, from: data){
                print(data)
                completion(items)
            }else{
                completion(nil)
            }
        }
        task.resume()
    }
    
}
