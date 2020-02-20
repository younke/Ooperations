//
//  ChainedResultOperation.swift
//  Ooperations
//
//  Created by younke on 18.02.2020.
//  Copyright © 2020 funjahmental. All rights reserved.
//

import Foundation

public enum ChainedResultOperationError: Error {

    case updateInputError
}

open class ChainedResultOperation<Input, Success>: ResultOperation<Success> {

    open var input: Input?

    open override func start() {
        updateInputFromDependencies()
        super.start()
    }

    private func updateInputFromDependencies() {
        guard input == nil else { return }

        input = dependencies.compactMap { dependency in
            return try? (dependency as? ResultOperation<Input>)?.result?.get()
        }.first
    }
}

open class ChainedAsyncResultOperation<Input, Success>: AsyncResultOperation<Success> {

    open var input: Input?

    open override func start() {
        updateInputFromDependencies()
        super.start()
    }

    private func updateInputFromDependencies() {
        guard input == nil else { return }

        input = dependencies.compactMap { dependency in
            return try? (dependency as? ResultOperation<Input>)?.result?.get()
        }.first
    }
}
