//
//  ResultOperation.swift
//  Ooperations
//
//  Created by younke on 18.02.2020.
//  Copyright © 2020 funjahmental. All rights reserved.
//

import Foundation

open class ResultOperation<Success>: Operation {

    open private(set) var result: Result<Success, AnyError>?

    open func setResult(_ result: Result<Success, AnyError>) {
        self.result = result
    }

    // MARK: - Sugar

    final public func setResult(failure: Error) {
        setResult(.failure(AnyError(failure)))
    }

    final public func setResult(success: Success) {
        setResult(.success(success))
    }
}

