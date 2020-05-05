//
//  CurrencyDetailModel.swift
//  CurrencyRates
//
//  Created by Maksim on 29/04/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

// MARK:- Typealiases
typealias CurrencyDetailDisplay = CurrencyDetailModel.Fetch.ViewModel.DisplayDetail
typealias CurrencyDetailRequest = CurrencyDetailModel.Fetch.Request
typealias CurrencyDetailResponse = CurrencyDetailModel.Fetch.Response
typealias CurrencyDetailViewModel = CurrencyDetailModel.Fetch.ViewModel

struct CurrencyDetailModel {
    struct Fetch {
        struct Request {
            let symbol: String
            let base = "EUR"
        }
        
        struct Response {
            var currencyDetail: CurrencyDetail
        }
        
        struct ViewModel {
            struct DisplayDetail {
                let title: String
                let subTitle: String
            }
            var displayDetails: [DisplayDetail]
        }
    }
}
