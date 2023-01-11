//
//  ImageService.swift
//  NewsApp
//
//  Created by Isagulov urmat on 6/1/23.
//

import Foundation

class ImageService {
    
    static let shared = ImageService()
    
    func createRequest(urlString: String, completion: ((Data) -> Void )?){
        let url = URL(string: urlString)
        if let url = url{
            let session = URLSession(configuration: .default)
            let task  = session.dataTask(with: url) { data, response, error in
                if let data = data{
                    completion!(data)
                }
            }
            task.resume()
        }
        
    }
}
