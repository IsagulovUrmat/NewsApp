//
//  NewsModelAPI.swift
//  NewsApp
//
//  Created by Isagulov urmat on 2/12/22.
//

import Foundation


struct NewsModelAPI: Decodable{
    
    let articles: [Article]
    
}

struct Article: Decodable{
    let source: Source
    let author: String?
    let title: String
    let description: String
    let content: String
    let urlToImage: String?
}

struct Source: Decodable{
    let name: String
}
