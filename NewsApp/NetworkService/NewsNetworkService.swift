//
//  NewsNetworkService.swift
//  NewsApp
//
//  Created by Isagulov urmat on 3/10/22.
//

import Foundation

protocol NewsNetworkDelegate{
    
    func fetchNews(news: NewsModelAPI)
    func errorFetchingNews(error: Error)
    
}

class NewsNetworkService{
    static let shared = NewsNetworkService()
    
    var newsDelegate: NewsNetworkDelegate?
    
    let mainUrl = "https://newsapi.org/v2/everything?apiKey=b509816f6d8449ee9b67cb8055781998&sortBy=popularity&pageSize=5"
    
    func getNews(keyWord: String, language: String){
        let urlString = "\(mainUrl)&q=\(keyWord)&language=\(language)"
        
        createRequest(urlString: urlString)
        
    }
    
    func createRequest(urlString: String){
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if let data = data {
                    if let news = self.parseJSON(data: data){
                        self.newsDelegate?.fetchNews(news: news)
                    }
                   
                }
            }
            task.resume()
            }
        }
    func parseJSON(data: Data) -> NewsModelAPI?{
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(NewsModelAPI.self, from: data)
            return decodedData
        }catch{
            newsDelegate?.errorFetchingNews(error: error)
            return nil
        }
    }
}

