//
//  CurrenciesInteractorTest.swift
//  CurrencyRatesTests
//
//  Created by Maksim on 03/05/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

import XCTest
@testable import CurrencyRates

final class CurrenciesInteractorTests: XCTestCase {
  
    // MARK: - Private Properties

    private var interactor: CurrenciesInteractor!
    private var worker: CurrenciesWorkerLogicSpy!
    private var presenter: CurrenciesPresentationLogicSpy!
  
    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()

        let interactor = CurrenciesInteractor()
        let worker = CurrenciesWorkerLogicSpy()
        let presenter = CurrenciesPresentationLogicSpy()

        interactor.worker = worker
        interactor.presenter = presenter

        self.interactor = interactor
        self.worker = worker
        self.presenter = presenter
    }
  
    override func tearDown() {
        interactor = nil
        worker = nil
        presenter = nil
        super.tearDown()
    }
  
    // MARK: - Public Methods

    func testFetchItems() {
        interactor.fetchItems()
        XCTAssertTrue(worker.isCalledFetchItems, "worker not called fetchItems")
        XCTAssertTrue(presenter.isCalledPresentFetchedItems, "presenter not called presentFetchResults")
        XCTAssertEqual(interactor.currencies.count, worker.currencies.currencies.count)
    }
}
