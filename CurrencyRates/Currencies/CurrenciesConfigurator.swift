//
//  CurrenciesConfigurator.swift
//  CurrencyRates
//
//  Created by Maksim on 14/05/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

struct CurrenciesConfigurator {
    
    // MARK: - Configuratore
    static func configure(viewController: CurrenciesViewController) {
        let interactor = CurrenciesInteractor()
        let presenter = CurrenciesPresenter()
        let router = CurrenciesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
}
