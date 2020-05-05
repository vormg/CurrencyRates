//
//  CurrenciesModel.swift
//  CurrencyRates
//
//  Created by Maksim on 27/04/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

// MARK:- Typealiases
typealias CurrenciesDisplay = CurrenciesModel.Fetch.ViewModel.DisplayCurrency
typealias CurrenciesRequest = CurrenciesModel.Fetch.Request
typealias CurrenciesResponse = CurrenciesModel.Fetch.Response
typealias CurrenciesViewModel = CurrenciesModel.Fetch.ViewModel

struct CurrenciesModel {
    struct Fetch {
        struct Request {
            
        }
        
        struct Response {
            var currencies: CurrencySymbols
        }
        
        struct ViewModel
        {
            struct DisplayCurrency {
                let title: String
                let subTitle: String
            }
            var displayCurrencies: [DisplayCurrency]
        }
    }
}
