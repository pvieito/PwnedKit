//
//  PwnedPasswords.swift
//  PwnedKit
//
//  Created by Christoffer Buusmann on 28/03/2018.
//

import Foundation
import FoundationKit

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

#if canImport(CryptoKit) && !NO_CRYPTOKIT
import CryptoKit
#elseif canImport(Crypto)
import Crypto
#endif

public class PwnedPasswords: NSObject {
    private static let endpointURL = URL(string: "https://api.pwnedpasswords.com/range")!

    public enum PwnedError: LocalizedError {
        case emptyPassword
        case responseMalformed
        
        public var errorDescription: String? {
            switch self {
            case .emptyPassword:
                return "The provided password is empty."
            case .responseMalformed:
                return "The API response is malformed and cannot be parsed."
            }
        }
    }
    
    public static let shared = PwnedPasswords()
    
    public static func check(_ input: String) throws -> Int {
        guard input.count > 0 else {
            throw PwnedError.emptyPassword
        }
        
        let inputData = Data(input.utf8)
        let hashData = Data(Insecure.SHA1.hash(data: inputData))
        let hashString = hashData.hexString.uppercased()
        let hashPrefix = hashString[offset: ..<5]
        let hashSuffix = hashString[offset: 5...]

        let requestURL = PwnedPasswords.endpointURL.appendingPathComponent(hashPrefix)
        let rawResponse = try String(contentsOf: requestURL)
        let parsedResponse = try self.parseResponse(rawResponse)
        let occurrences = parsedResponse[hashSuffix] ?? 0
        return occurrences
    }

    private static func parseResponse(_ string: String) throws -> Dictionary<String, Int> {
        let responseLines = string.components(separatedBy: .newlines)
        guard responseLines.count > 1 else {
            throw PwnedError.responseMalformed
        }
        
        var resultDictionary: Dictionary<String, Int> = [:]
        for responseString in responseLines {
            let responseResult = responseString.split(separator: ":")
            if responseResult.count != 2 { continue }
            let suffix = String(responseResult[0])
            let occurrences = Int(responseResult[1])
            resultDictionary[suffix] = occurrences
        }
        return resultDictionary
    }
}

