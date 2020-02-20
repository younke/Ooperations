//
//  ImageFetchOperation.swift
//  UIOPS
//
//  Created by younke on 20.02.2020.
//  Copyright © 2020 funjahmental. All rights reserved.
//

import UIKit
import Ooperations

enum OpErr: Error {

    case cancel
    case noInput
    case noData
    case invalidURLString
    case errorDataForImage
}

// Composition

final class ImageFetchOp: AsyncResultOperation<UIImage> {

    let string: String

    init(string: String) {
        self.string = string
    }

    let internalQueue = OperationQueue()

    override func main() {
        let fakeOp = FakeDelayedURLOperation(string: string)
        let dataFetch = DataFetchOp()
        let imageOp = ImageFromDataOperation()
        dataFetch.addDependency(fakeOp)
        imageOp.addDependency(dataFetch)
        let finalOp = BlockOperation { [weak self, weak imageOp] in
            guard
                let `self` = self,
                let op = imageOp,
                case .success(let image) = op.result
                else {
                    return
            }

            self.setResult(success: image)
        }
        finalOp.addDependency(imageOp)
        internalQueue.addOperations([fakeOp,
                                     dataFetch,
                                     imageOp,
                                     finalOp], waitUntilFinished: false)
    }

    override func cancel() {
        super.cancel()

        internalQueue.cancelAllOperations()

        setResult(failure: OpErr.cancel)
    }
}

// MARK: - Sub Operations

final class FakeDelayedURLOperation: AsyncResultOperation<URL> {

    let string: String

    init(string: String) {
        self.string = string
    }

    override func main() {
        DispatchQueue.global(qos: .userInitiated)
            .asyncAfter(deadline: .now() + 2) { [weak self] in
                self?.afterDelay()
        }
    }

    func afterDelay() {
        guard !isCancelled else {
            setResult(failure: OpErr.cancel)
            return
        }
        guard let url = URL(string: string) else {
                setResult(failure: OpErr.invalidURLString)
                return
        }
        setResult(success: url)
    }
}

final class DataFetchOp: ChainedResultOperation<URL, Data> {

    override func main() {
        guard
            let input = input else {
                setResult(failure: OpErr.noInput)
                return
        }
        guard
            let data = try? Data(contentsOf: input) else {
                setResult(failure: OpErr.noData)
                return
        }
        if isCancelled {
            return
        }
        setResult(success: data)
    }
}

final class ImageFromDataOperation: ChainedResultOperation<Data, UIImage> {

    override func main() {
        guard
            let input = input else {
                setResult(failure: OpErr.noInput)
                return
        }
        guard
            let image = UIImage(data: input) else {
                setResult(failure: OpErr.errorDataForImage)
                return
        }
        setResult(success: image)
    }
}
