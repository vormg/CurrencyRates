//
//  CurrenciesViewControllerTests.swift
//  CurrencyRatesTests
//
//  Created by Maksim on 04/05/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

import XCTest
@testable import CurrencyRates

final class CurrenciesViewControllerTests: XCTestCase {
  
  // MARK: - Private Properties
  
  private var viewController: CurrenciesViewController!
  private var interactor: CurrenciesBusinessLogicSpy!
  private var window: UIWindow!
  
  // MARK: - Lifecycle
  
  override func setUp() {
    super.setUp()
    
    let mainWindow = UIWindow()
    let bundle = Bundle.main
    let storyboard = UIStoryboard(name: "Main", bundle: bundle)
    
    let viewController = storyboard.instantiateViewController(
      identifier: "Currencies") as? CurrenciesViewController
    let interactor = CurrenciesBusinessLogicSpy()
    
    viewController?.interactor = interactor
    
    self.viewController = viewController
    self.interactor = interactor
    window = mainWindow
    
    window.addSubview(self.viewController.view)
    RunLoop.current.run(until: Date())
  }
  
    override func tearDown() {
        viewController = nil
        interactor = nil
        window = nil
        super.tearDown()
    }
  
    // MARK: - Public Methods
  
    func testViewDidLoad() {
        viewController.viewWillAppear(true)
        XCTAssert(interactor.isCalledFetchItem, "Not called interactor fetchItems()")
    }
  
    func testDisplayFetchedUsers() {
        let currencies = CurrencySymbols(success: true, currencies: [
            Currency(code: "USD", name: "United States dollar"),
            Currency(code: "EUR", name: "Euro")
        ])
        let displayCurrencies = currencies.currencies.map {
            CurrenciesDisplay(title: $0.code, subTitle: $0.name)
        }
        let viewModels = CurrenciesViewModel(displayCurrencies: displayCurrencies)
        viewController.presentDisplayCurrency(viewModel: viewModels)
        XCTAssertEqual(viewController?.tableView.numberOfRows(inSection: 0), currencies.currencies.count)
    }
}
