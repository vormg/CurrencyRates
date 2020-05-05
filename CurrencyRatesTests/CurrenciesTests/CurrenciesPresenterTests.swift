//
//  CurrenciesPresenterTests.swift
//  CurrencyRatesTests
//
//  Created by Maksim on 04/05/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

import XCTest
@testable import CurrencyRates

final class CurrenciesPresenterTests: XCTestCase {
  
    // MARK: - Private Properties

    private var presenter: CurrenciesPresenter!
    private var viewController: CurrenciesDisplayLogicSpy!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()

        let presenter = CurrenciesPresenter()
        let viewController = CurrenciesDisplayLogicSpy()

        presenter.viewController = viewController

        self.presenter = presenter
        self.viewController = viewController
    }

    override func tearDown() {
        presenter = nil
        viewController = nil
        super.tearDown()
    }

    // MARK: - Public Methods

    func testPresentFetchResults() {
        let currencies = CurrencySymbols(success: true, currencies: [
            Currency(code: "USD", name: "United States dollar")
        ])
        presenter.presentFetchResults(response: CurrenciesResponse(currencies: currencies))
        XCTAssertTrue(viewController.isCalledDisplayFetchedItems, "viewController not called presentDisplayCurrency")
        XCTAssertEqual(viewController.displayCurrencies.first?.title, currencies.currencies.first?.code)
        XCTAssertEqual(viewController.displayCurrencies.first?.subTitle, currencies.currencies.first?.name)
    }
    
    func testPresentError() {
        presenter.presentError(error: DataProviderError.unknown)
        XCTAssertTrue(viewController.isCalledDisplayFetchedError, "viewController not called presentDisplayError")
        XCTAssertEqual(viewController.displayCurrencies.count, 0)
    }
}
