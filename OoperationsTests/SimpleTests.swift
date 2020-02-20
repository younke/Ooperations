//
//  SimpleTests.swift
//  OoperationsTests
//
//  Created by younke on 20.02.2020.
//  Copyright © 2020 funjahmental. All rights reserved.
//

import XCTest

class SimpleTests: XCTestCase {

    var queue: OperationQueue!
    var emptyOp: Operation!

    override func setUp() {
        queue = OperationQueue()
        emptyOp = Operation()
    }

    override func tearDown() {
        queue.cancelAllOperations()
        queue = nil
    }

    func test_block_operation() {
        let blockOp = BlockOperation { }

        XCTAssertFalse(blockOp.isAsynchronous)
    }

    func test_block_op_behavior() {
        let blockOp = BlockOperation { }

        XCTAssertTrue(blockOp.isReady)

        blockOp.addDependency(emptyOp)

        XCTAssertFalse(blockOp.isReady)
    }

    func test_op_before_after() {


    }

    func test_dependency() {
        let exp = expectation(description: "first")
        let exp = expectation(description: "second")

        let op1 = BlockOperation { }
        let op2 =

    }
}
