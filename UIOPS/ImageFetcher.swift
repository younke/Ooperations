//
//  ImageFetcher.swift
//  UIOPS
//
//  Created by younke on 20.02.2020.
//  Copyright © 2020 funjahmental. All rights reserved.
//

import UIKit

final class ImageFetcher {

    let imageURL: URL?

    init(string: String) {
        self.imageURL = URL(string: string)
    }

    init(imageURL: URL?) {
        self.imageURL = imageURL
    }

    func fetchSync() -> UIImage? {
        guard
            let imageURL = imageURL,
            let data = try? Data(contentsOf: imageURL),
            let image = UIImage(data: data) else {
                return nil
        }
        return image
    }

    func fetchAsynchronously(completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            var result: UIImage?
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            guard
                let imageURL = self.imageURL,
                let data = try? Data(contentsOf: imageURL),
                let image = UIImage(data: data) else {
                    return
            }
            result = image
        }
    }
}
