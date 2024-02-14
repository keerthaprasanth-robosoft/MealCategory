//
//  APIHandler.swift
//  RS_Assignment
//
//  Created by Keerthaprasanth Ravikumar on 11/02/24.
//
import Foundation
import Alamofire

enum APIError: Error {
    case decodingError
    case networkError(String)
}

// MARK: - APIHandler

class APIHandler {

    func fetchData<T: Decodable>(urlString: String, completion: @escaping (T?, APIError?) -> Void) {
        AF.request(urlString, method: .get, encoding: URLEncoding.default).response { response in
            switch response.result {
            case .success(let data):
                if let jsonData = try? JSONDecoder().decode(T.self, from: data!) {
                    completion(jsonData, nil)
                } else {
                    completion(nil, .decodingError)
                }
            case .failure(let error):
                completion(nil, .networkError(error.localizedDescription))
            }
        }
    }
}
