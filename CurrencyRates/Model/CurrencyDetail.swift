//
//  CurrencyDetail.swift
//  CurrencyRates
//
//  Created by Maksim on 29/04/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

import Foundation

// MARK:- Typealiases
typealias RatesParameters = [String : Double]

struct CurrencyRate {
    let code: String
    let rate: Double
}

struct CurrencyDetail: Mappable {
    
    let success: Bool
    let base: String
    let date: String
    let currencyRate: CurrencyRate
 
    private enum CodingKeys: String, CodingKey {
        case success, rates, base, date
    }
    
    // MARK: - Decodable
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        guard let rate = try values.decodeIfPresent(RatesParameters.self, forKey: .rates)?.first else {
            throw DataProviderError.noDisplayData
        }
        success = try values.decodeIfPresent(Bool.self, forKey: .success) ?? false
        base = try values.decodeIfPresent(String.self, forKey: .base) ?? ""
        date = try values.decodeIfPresent(String.self, forKey: .date) ?? ""
        currencyRate = CurrencyRate(code: rate.key, rate: rate.value)
    }
}
