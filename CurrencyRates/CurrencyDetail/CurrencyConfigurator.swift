//
//  CurrencyConfigurator.swift
//  CurrencyRates
//
//  Created by Maksim on 14/05/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

struct CurrencyConfigurator {
    
    // MARK: - Configuratore
    static func configure(viewController: CurrencyDetailViewController) {
        let interactor = CurrencyDetailInteractor()
        let presenter = CurrencyDetailPresenter()
        let router = CurrencyDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.dataStore = interactor
    }
    
}
