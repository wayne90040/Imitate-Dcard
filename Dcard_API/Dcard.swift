//
//  Dcard.swift
//  Dcard_API
//
//  Created by Wei Lun Hsu on 2020/8/16.
//  Copyright © 2020 Wei Lun Hsu. All rights reserved.
//

import Foundation

// MARK: - API Model
struct Dcard: Codable{
    let id: Int
    let title: String
    let excerpt: String
    let gender: String
    let forumName: String
    var mediaMeta: [MediaMeta]
}

struct Content: Codable {
    let id: Int
    let title: String
    let forumName: String
    let school: String?
    let content: String
    let anonymousSchool: Bool
    let anonymousDepartment: Bool
    let gender: String
    let createdAt: String
    var mediaMeta: [MediaMeta]
    
    internal func getCreatedAt() -> String{
        var result = String()
        result = createdAt.replacingOccurrences(of: "T", with: " ")
        result = String(result.prefix(16))
        
        return result
    }
}

struct MediaMeta: Codable {
    var url: URL
}

struct Comment: Codable {
    var gender: String
    var createdAt: String
    var floor: Int
    var school: String?
    var content: String?
}


// MARK: - 看板

class DcardCatalogs{
    var catalogs = [DcardCatalog]()
    
    init() {
        addNewCatalog(name: "有趣", url: "forums/funny/posts", logoImg: "funny.jpeg")
        addNewCatalog(name: "心情", url: "forums/mood/posts", logoImg: "mood.jpeg")
        addNewCatalog(name: "寵物", url: "forums/pet/posts", logoImg: "pet.jpeg")
        addNewCatalog(name: "西斯", url: "forums/sex/posts", logoImg: "sex.jpeg")
        addNewCatalog(name: "電影", url: "forums/movie/posts", logoImg: "movie.jpeg")
        addNewCatalog(name: "軟體工程師", url: "forums/softwareengineer/posts", logoImg: "softwareengineer.jpeg")
    }
    
    internal func addNewCatalog(name: String, url: String, logoImg: String){
        let dcardCatalog = DcardCatalog()
        dcardCatalog.name = name
        dcardCatalog.url = url
        dcardCatalog.logoImg = logoImg
        
        self.catalogs.append(dcardCatalog)
    }
}

class DcardCatalog {
    var name = String()
    var url = String()
    var logoImg = String()
}
