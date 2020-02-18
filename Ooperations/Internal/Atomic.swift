//
//  Atomic.swift
//  Ooperations
//
//  Created by younke on 18.02.2020.
//  Copyright © 2020 funjahmental. All rights reserved.
//

import Foundation

struct Atomic<A> {
    let queue = DispatchQueue(label: "Atomic.LockQueue",
                              attributes: .concurrent)

    private var _value: A

    init(_ value: A) {
        self._value = value
    }

    var value: A {
        get {
            return queue.sync {
                return self._value
            }
        }
        set {
            queue.sync(flags: .barrier) {
                _value = newValue
            }
        }
    }
}
