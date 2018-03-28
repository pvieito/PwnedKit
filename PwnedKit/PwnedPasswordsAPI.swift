//
//  PwnedPasswordsAPI.swift
//  PwnedKit
//
//  Created by Christoffer Buusmann on 28/03/2018.
//

import Foundation

internal protocol API {
    func getResponse(forPrefix prefix: String, completion: @escaping (String, Error?) -> Void)
}

internal class PwnedPasswordsAPI: API {
    
    public enum ResponseError: LocalizedError {
        case noData
        
        public var errorDescription: String? {
            switch self {
            case .noData: return "No data available on API response."
            }
        }
    }
    
    let endpoint = "https://api.pwnedpasswords.com/range"
    
    /// Makes a 'GET' request to the PwnedPasswords API using the prefix (first 5 characters) of the sha1 hashed password.
    ///
    /// - Parameters:
    ///   - prefix: The prefix of the sha1 hashed password
    ///   - completion: The completion handler returning the response string or an error
    internal func getResponse(forPrefix prefix: String, completion: @escaping (String, Error?) -> Void) {
        
        guard let url = URL(string: "\(endpoint)/\(prefix)") else {
            completion("", ResponseError.noData)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, res, error in
            guard error == nil else {
                completion("", error)
                return
            }
            if let data = data, let string = String(bytes: data, encoding: String.Encoding.ascii) {
                completion(string, nil)
            } else {
                completion("", ResponseError.noData)
            }
        }
        
        task.resume()
    }
}

