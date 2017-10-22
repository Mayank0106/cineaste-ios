//
//  MovieClient.swift
//  Cineaste
//
//  Created by Christian Braun on 20.10.17.
//  Copyright © 2017 notimeforthat.org. All rights reserved.
//

import UIKit

class MovieClient: NSObject {
    static let baseUrl = "https://api.themoviedb.org/3"
    fileprivate static let apiKey = ApiKeyStore.theMovieDbKey()
    static var staticQuery:String {
        get {
            return "?language=de&api_key=\(apiKey)"
        }
    }
    
    func search(query: String, completion: @escaping ([Movie]?, Error?) ->()) {
        guard let escapedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            return
        }
        let urlAsString = "\(MovieClient.baseUrl)/search/movie\(MovieClient.staticQuery)&query=\(escapedQuery)"
        guard let url = URL(string:urlAsString) else {
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler:{ data, response, error in
            guard error == nil, let data = data else {
                completion(nil, error)
                return
            }
            let dataAsString = String(data: data, encoding: .utf8)
            
            do {
                let pagedMovies = try JSONDecoder().decode(PagedMovieResult.self, from: data)
                completion(pagedMovies.results, nil)
            } catch let error {
                print(error)
            }
        }).resume()
    }
}
