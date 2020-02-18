//
//  ChainedResultOperation.swift
//  Ooperations
//
//  Created by younke on 18.02.2020.
//  Copyright © 2020 funjahmental. All rights reserved.
//

import Foundation

enum ChainedResultOperationError {

    case updateInputError
}

class ChainedResultOperation<Input, Success>: ResultOperation<Success> {

    var input: Input?

    override final func start() {
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

class ChainedAsyncResultOperation<Input, Success>: AsyncResultOperation<Success> {

    var input: Input?

    override final func start() {
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
