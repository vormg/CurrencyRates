//
//  URLSessionDataTaskMock.swift
//  CurrencyRatesTests
//
//  Created by Maksim on 14/05/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

import Foundation

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}
