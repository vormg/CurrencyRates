//
//  CurrencyDetailPresenter.swift
//  CurrencyRates
//
//  Created by Maksim on 29/04/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

import Foundation

// MARK: - Protocols
protocol CurrencyDetailPresentationLogic {
    func presentFetchResults(response: CurrencyDetailResponse)
    func presentError(error: DataProviderError)
}

final class CurrencyDetailPresenter: CurrencyDetailPresentationLogic {

    weak var viewController: CurrencyDetailDisplayLogic?
    
    // MARK: - CurrencyDetailPresentationLogic
    func presentFetchResults(response: CurrencyDetailResponse) {
        let currencyDetail = response.currencyDetail
        var models = [CurrencyDetailDisplay]()
        models.append(CurrencyDetailDisplay(title: "Дата:", subTitle: currencyDetail.date))
        models.append(CurrencyDetailDisplay(title: "Базовая валюта:", subTitle: currencyDetail.base))
        models.append(CurrencyDetailDisplay(title: "Валюта:", subTitle: currencyDetail.currencyRate.code))
        models.append(CurrencyDetailDisplay(title: "Курс:", subTitle: String(currencyDetail.currencyRate.rate)))
        let viewModels = CurrencyDetailViewModel(displayDetails: models)
        self.viewController?.presentDisplayDetails(viewModel: viewModels)
    }
    
    func presentError(error: DataProviderError) {
        self.viewController?.presentDisplayError(error: error.errorMessage())
    }
}
