//
//  Currencies.swift
//  CurrencyRates
//
//  Created by Maksim on 27/04/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

import Foundation

// MARK:- Typealiases
typealias SymbolParameters = [String : String]

struct Currency {
    let code: String
    let name: String
}

struct CurrencySymbols: Mappable {

    let success: Bool
    let currencies: [Currency]
    
    private enum CodingKeys: String, CodingKey {
        case success, symbols
    }
    
    init(success: Bool, currencies: [Currency]) {
        self.success = success
        self.currencies = currencies
    }
    
    // MARK: - Decodable
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        guard let symbols = try values.decodeIfPresent(SymbolParameters.self, forKey: .symbols) else {
            throw DataProviderError.noDisplayData
        }
        currencies = symbols.map{Currency(code: $0, name: $1)}
        success = try values.decodeIfPresent(Bool.self, forKey: .success) ?? false
    }
}
