//
//  DelayOperation.swift
//  Ooperations
//
//  Created by younke on 20.02.2020.
//  Copyright © 2020 funjahmental. All rights reserved.
//

import Foundation

open class DelayOperation: AsyncOperation {

    private let delay: TimeInterval
    private let dispatchQueue: DispatchQueue

    public init(delay: TimeInterval, dispatchQueue: DispatchQueue) {
        self.delay = delay
        self.dispatchQueue = dispatchQueue
    }

    open override func main() {
        dispatchQueue.asyncAfter(deadline: .now() + delay) {
            [weak self] in
            self?.finish()
        }
    }
}

public extension DelayOperation {

    convenience init(delay: TimeInterval) {
        let queue = DispatchQueue.global(qos: .default)
        self.init(delay: delay, dispatchQueue: queue)
    }
}
