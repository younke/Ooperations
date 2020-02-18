//
//  OoperationsTests.swift
//  OoperationsTests
//
//  Created by younke on 18.02.2020.
//  Copyright © 2020 funjahmental. All rights reserved.
//

import XCTest
@testable import Ooperations

class OoperationsTests: XCTestCase {

    var queue: OperationQueue!

    override func setUp() {
        queue = OperationQueue()
    }

    override func tearDown() {
        queue.cancelAllOperations()
        queue = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
