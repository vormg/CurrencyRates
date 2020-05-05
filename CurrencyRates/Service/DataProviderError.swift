//
//  DataProviderError.swift
//  CurrencyRates
//
//  Created by Maksim on 01/05/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

enum DataProviderError: Error {
    
    case badRequestURL
    case responseData
    case noDisplayData
    case unknown
    
    func errorMessage() -> String {
        switch self {
        case .badRequestURL:
            return "Bad Request URL"
        case .responseData:
            return "Response data error"
        case .noDisplayData:
            return "No display data"
        case .unknown:
            return "Unknown error"
        }
    }
}
