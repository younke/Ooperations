//
//  ImageViewController.swift
//  UIOPS
//
//  Created by younke on 20.02.2020.
//  Copyright © 2020 funjahmental. All rights reserved.
//

import UIKit

class JustImageVC: BaseImageVC {

    let queue = DispatchQueue.global(qos: .userInitiated)

    // MARK: - viewDidAppear

    let imageURLString = "https://imgsrc.hubblesite.org/hu/db/images/hs-2006-10-a-hires_jpg.jpg"

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        asyncLoadAfter(seconds: 2)
//        syncLoadAfter(seconds: 2)
    }

    // MARK: - SyncLoad

    func syncLoadAfter(seconds: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { [unowned self] in
            self.isLoading = true
            defer {
                self.isLoading = false
            }
            guard let image = ImageFetcher(string: self.imageURLString).fetchSync() else {
                return
            }
            self.imageView.image = image
            self.view.layoutIfNeeded()
        }
    }

    // MARK: - AsyncLoad

    func asyncLoadAfter(seconds: TimeInterval) {
        isLoading = true
        let fetcher = ImageFetcher(string: self.imageURLString)
        fetcher.fetchAsynchronously { image in
            self.isLoading = false
            self.imageView.image = image
            self.view.layoutIfNeeded()
        }
    }
}
