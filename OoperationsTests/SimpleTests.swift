//
//  SimpleTests.swift
//  OoperationsTests
//
//  Created by younke on 20.02.2020.
//  Copyright © 2020 funjahmental. All rights reserved.
//

import XCTest
@testable import Ooperations

class SimpleTests: OperationTestCase {

    var emptyOp: Operation!

    override func setUp() {
        super.setUp()

        emptyOp = Operation()
    }

    override func tearDown() {
        super.tearDown()

        emptyOp = nil
    }

    // MARK: - Tests

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
        let blockOp = DelayOperation(delay: 0.2)
        XCTAssertFalse(blockOp.isExecuting)
        XCTAssertFalse(blockOp.isFinished)

        let exp = expectation(description: #file)
        blockOp.completionBlock = { exp.fulfill() }

        blockOp.start()
        XCTAssertTrue(blockOp.isExecuting)
        XCTAssertFalse(blockOp.isFinished)

        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertFalse(blockOp.isExecuting)
        XCTAssertTrue(blockOp.isFinished)
    }

    func test_dependency() {
        let exp1 = expectation(description: "first")
        let exp2 = expectation(description: "second")

        let op1 = BlockOperation { exp1.fulfill() }
        let op2 = BlockOperation { exp2.fulfill() }
        op2.addDependency(op1)

        queue.addOperations([op1, op2], waitUntilFinished: false)

        wait(for: [exp1], timeout: 0.1)
        wait(for: [exp2], timeout: 0.2)
    }
}
