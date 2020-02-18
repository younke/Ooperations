//
//  OperationObserver.swift
//  Ooperations
//
//  Created by younke on 18.02.2020.
//  Copyright © 2020 funjahmental. All rights reserved.
//

import Foundation

final class OperationObserver: NSObject {

    func observe(operation: Operation) {
        _ = operation.observe(\.isReady, options: [.old, .new]) { op, change in
            print("Operation \(op) changed isReady from \(change.oldValue!) to \(change.newValue!)")
        }
        _ = operation.observe(\.isExecuting, options: [.old, .new]) { op, change in
            print("Operation \(op) changed isReady from \(change.oldValue!) to \(change.newValue!)")
        }
        _ = operation.observe(\.isFinished, options: [.old, .new]) { op, change in
            print("Operation \(op) changed isReady from \(change.oldValue!) to \(change.newValue!)")
        }
        _ = operation.observe(\.isCancelled, options: [.old, .new]) { op, change in
            print("Operation \(op) changed isReady from \(change.oldValue!) to \(change.newValue!)")
        }
    }
}
