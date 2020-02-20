//
//  BetterImageVC.swift
//  UIOPS
//
//  Created by younke on 20.02.2020.
//  Copyright © 2020 funjahmental. All rights reserved.
//

import Foundation

final class BetterImageVC: BaseImageVC {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let string = "https://imgsrc.hubblesite.org/hu/db/images/hs-2006-10-a-hires_jpg.jpg"
        let firstOp = BlockOperation { [unowned self] in
            self.isLoading = true
        }
        let imageOp = ImageFetchOp(string: string)
        let finalOp = BlockOperation { [unowned self, unowned imageOp] in
            defer { self.isLoading = false }
            guard case .success(let image) = imageOp.result else {
                return
            }
            self.imageView.image = image
        }
        imageOp.addDependency(firstOp)
        finalOp.addDependency(imageOp)
        OperationQueue.main.addOperations([firstOp, imageOp, finalOp],
                                          waitUntilFinished: false)
    }

}
