//
//  DataProvider.swift
//  CurrencyRates
//
//  Created by Maksim on 29/04/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

import Foundation

// MARK:- Typealiases
typealias SymbolsCompletionHandler = (Result<CurrencySymbols, DataProviderError>) -> Void
typealias RateCompletionHandler = (Result<CurrencyDetail, DataProviderError>) -> Void

// MARK: - Protocols
protocol Mappable: Decodable {
    var success: Bool { get }
}

protocol SymbolsDataProvider {
    func fetchSymbols(completionHandler: @escaping SymbolsCompletionHandler)
}

protocol RateDataProvider {
    func fetchRates(base: String, symbol: String, completionHandler: @escaping RateCompletionHandler)
}

final class DataProvider {
    
    // MARK: - Private
    private func url(queryComponents: [URLQueryItem]?, path: String) -> URL? {
        guard var components = URLComponents(string: "http://data.fixer.io") else { return nil }
        components.path = "/api/"+path
        components.queryItems = [URLQueryItem(name: "access_key", value: "2603beec3d9a644f3f1e2d1f2b4aa019")]
        if let queryComponents = queryComponents {
            components.queryItems?.append(contentsOf: queryComponents)
        }
        return components.url
    }
    
    private func dataTask<T: Mappable>(url: URL, completionHandler: @escaping (Result<T, DataProviderError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if (error != nil) {
                    completionHandler(.failure(DataProviderError.responseData))
                    return
                }
                guard let data = data else {
                    completionHandler(.failure(DataProviderError.responseData))
                    return
                }
                do {
                    let decodeData = try JSONDecoder().decode(T.self, from: data)
                    if decodeData.success {
                        completionHandler(.success(decodeData))
                    } else {
                        completionHandler(.failure(DataProviderError.responseData))
                    }
                } catch {
                     completionHandler(.failure(DataProviderError.responseData))
                }
            }
        }.resume()
    }
}

// MARK: - SymbolsDataProvider
extension DataProvider: SymbolsDataProvider {
    func fetchSymbols(completionHandler: @escaping SymbolsCompletionHandler) {
        guard let url = url(queryComponents: nil, path: "symbols") else {
            completionHandler(.failure(DataProviderError.badRequestURL))
            return
        }
        dataTask(url: url, completionHandler: completionHandler)
    }
}

// MARK: - SymbolsDataProvider
extension DataProvider: RateDataProvider {
    func fetchRates(base: String, symbol: String, completionHandler: @escaping RateCompletionHandler) {
        let queryComponents = [URLQueryItem(name: "base", value: base), URLQueryItem(name: "symbols", value: symbol)]
        guard let url = url(queryComponents: queryComponents, path: "latest") else {
            completionHandler(.failure(DataProviderError.badRequestURL))
            return
        }
        dataTask(url: url, completionHandler: completionHandler)
    }
}
