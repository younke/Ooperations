//
//  AsyncResultOperation.swift
//  Ooperations
//
//  Created by younke on 18.02.2020.
//  Copyright © 2020 funjahmental. All rights reserved.
//

import Foundation

open class AsyncResultOperation<Success>: ResultOperation<Success> {

    override open var isAsynchronous: Bool {
        return true
    }

    private var _isExecuting: Atomic<Bool> = .init(false)
    open override private(set) var isExecuting: Bool {
        get {
            _isExecuting.value
        }
        set {
            willChangeValue(forKey: "isExecuting")
            _isExecuting.value = newValue
            didChangeValue(forKey: "isExecuting")
        }
    }

    private var _isFinished: Atomic<Bool> = .init(false)
    open override private(set) var isFinished: Bool {
        get { _isFinished.value }
        set {
            willChangeValue(forKey: "isFinished")
            _isFinished.value = newValue
            didChangeValue(forKey: "isFinished")
        }
    }

    open override func start() {
        print("Starting")
        guard !isCancelled else {
            finish()
            return
        }

        isFinished = false
        isExecuting = true
        main()
    }

    open override func main() {
        fatalError("Subclasses must implement `main` without overriding super.")
    }

    final func finish() {
        isExecuting = false
        isFinished = true
    }

    // setResult

    open override func setResult(_ result: Result<Success, AnyError>) {
        super.setResult(result)

        finish()
    }
}
