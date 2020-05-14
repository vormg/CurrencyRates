//
//  URLSessionDataMock.swift
//  CurrencyRatesTests
//
//  Created by Maksim on 14/05/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

import Foundation

class URLSessionDataMock {
    
    static func symbolsDataMock() -> Data {
        let json =
        """
            {
              "success": true,
              "symbols": {
                "AED": "United Arab Emirates Dirham",
                "AFN": "Afghan Afghani",
                "ALL": "Albanian Lek",
                "AMD": "Armenian Dram"
                }
            }
        """
        guard let data = json.data(using: .utf8) else {
            fatalError("error")
        }
        return data
    }
    
    static func rateDataMock() -> Data {
        let json =
        """
            {
                "success": true,
                "historical": true,
                "date": "2013-12-24",
                "timestamp": 1387929599,
                "base": "GBP",
                "rates": {
                    "USD": 1.636492,
                    "EUR": 1.196476,
                    "CAD": 1.739516
                }
            }
        """
        guard let data = json.data(using: .utf8) else {
            fatalError("error")
        }
        return data
    }
    
}
