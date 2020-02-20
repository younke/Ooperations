//
//  OoperationsTests.swift
//  OoperationsTests
//
//  Created by younke on 18.02.2020.
//  Copyright © 2020 funjahmental. All rights reserved.
//

import XCTest

class OperationTestCase: XCTestCase {

    var queue: OperationQueue!

    override func setUp() {
        queue = OperationQueue()
    }

    override func tearDown() {
        queue.cancelAllOperations()
        queue = nil
    }
}
