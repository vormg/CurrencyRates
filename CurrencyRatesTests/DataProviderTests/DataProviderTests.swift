//
//  DataProviderTests.swift
//  CurrencyRatesTests
//
//  Created by Maksim on 14/05/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

import XCTest
@testable import CurrencyRates

class DataProviderTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSymbolsSuccessfulResponse() {
        let session = URLSessionMock()
        session.data = URLSessionDataMock.symbolsDataMock()
        let provider: SymbolsDataProvider = DataProvider(session: session)
        provider.fetchSymbols(completionHandler: { fetchResult in
            switch fetchResult {
            case let .success(item):
                XCTAssertNotNil(item,"item must be not nil")
                XCTAssertTrue((item as Any) is CurrencySymbols, "item must be CurrencySymbols")
                XCTAssertTrue(item.success,"item.success must be true")
            case .failure:
                XCTFail()
            }
        })
    }
    
    func testSymbolsFailureResponse() {
        let session = URLSessionMock()
        let provider: SymbolsDataProvider = DataProvider(session: session)
        provider.fetchSymbols(completionHandler: { fetchResult in
            switch fetchResult {
            case .success:
                XCTFail()
            case let .failure(error):
                XCTAssertNotNil(error,"error must be not nil")
            }
        })
    }
    
    func testRateSuccessfulResponse() {
        let session = URLSessionMock()
        session.data = URLSessionDataMock.rateDataMock()
        let provider: RateDataProvider = DataProvider(session: session)
        provider.fetchRates(base: "EUR", symbol: "RUR", completionHandler: { fetchResult in
            switch fetchResult {
            case let .success(item):
                XCTAssertNotNil(item,"item must be not nil")
                XCTAssertTrue((item as Any) is CurrencyDetail, "item must be CurrencyDetail")
                XCTAssertTrue(item.success,"item.success must be true")
            case .failure:
                XCTFail()
            }
        })
    }
    
    func testRateFailureResponse() {
        let session = URLSessionMock()
        let provider: RateDataProvider = DataProvider(session: session)
        provider.fetchRates(base: "EUR", symbol: "RUR", completionHandler: { fetchResult in
            switch fetchResult {
            case .success:
                XCTFail()
            case let .failure(error):
                XCTAssertNotNil(error,"error must be not nil")
            }
        })
    }

}
