//
//  BaseImageVC.swift
//  UIOPS
//
//  Created by younke on 20.02.2020.
//  Copyright © 2020 funjahmental. All rights reserved.
//

import UIKit

class BaseImageVC: UIViewController {

    weak var tableView: UITableView!

    lazy private(set) var activity: UIActivityIndicatorView = .init()

    lazy private(set) var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        return imageView
    }()

    var isLoading: Bool = false {
        didSet {
            if isLoading {
                activity.startAnimating()
            } else {
                activity.stopAnimating()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(tableView)

        view.addSubview(activity)
        activity.hidesWhenStopped = true
        activity.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activity.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activity.heightAnchor.constraint(equalToConstant: 50),
            activity.widthAnchor.constraint(equalToConstant: 50),
        ])

        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        view.setNeedsLayout()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        activity.transform = .init(scaleX: 5, y: 5)
    }
}

extension BaseImageVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) ??
            UITableViewCell(style: .default, reuseIdentifier: cellID)
        cell.backgroundColor = UIColor.random
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
}
