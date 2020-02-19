//
//  ViewController.swift
//  UIOPS
//
//  Created by younke on 20.02.2020.
//  Copyright © 2020 funjahmental. All rights reserved.
//

import UIKit
import Ooperations

final class NavigationVC: UINavigationController {

    @objc func dismissAll() {
        if presentedViewController != nil {
            dismiss(animated: true, completion: nil)
        } else {
            popToRootViewController(animated: true)
        }
    }
}

final class RootVC: UIViewController {

    let serialQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        definesPresentationContext = true
    }

    @IBAction func presentAction(_ sender: UIButton, forEvent event: UIEvent) {
        serialQueue.isSuspended = true
        for _ in (1...5) {
            let op = PresentOperation(viewController: SecondVC.instantiateFromStoryboard, presenter: self)
            serialQueue.addOperation(op)
        }
        serialQueue.isSuspended = false
    }

    @IBAction func pushAction(_ sender: Any) {
        guard let navigationVC = navigationController else {
            return
        }
        serialQueue.isSuspended = true
        for _ in (1...5) {
            let pushed = SecondVC.instantiateFromStoryboard
            let op = PushOperation(navigationVC: navigationVC, pushed: pushed)
            serialQueue.addOperation(op)
        }
        serialQueue.isSuspended = false

    }
}

final class SecondVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.random
    }

    @IBAction func dismissAction(_ sender: UIButton, forEvent event: UIEvent) {
        UIApplication.shared.sendAction(#selector(NavigationVC.dismissAll), to: nil, from: sender, for: event)
    }

    static var instantiateFromStoryboard: UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self))
    }
}

// MARK: - Operation

final class PresentOperation: AsyncOperation {

    private let viewController: UIViewController
    weak var presenter: UIViewController?

    init(viewController: UIViewController, presenter: UIViewController) {
        self.viewController = viewController
        self.presenter = presenter

        super.init()
    }

    override func main() {
        guard let presenter = presenter else {
            finish()
            return
        }

        DispatchQueue.main.async {
            presenter.top.present(self.viewController, animated: true) { [unowned self] in
                self.finish()
            }
        }
    }
}

final class PushOperation: AsyncOperation {

    private let viewController: UIViewController
    private let navigationVC: UINavigationController

    init(navigationVC: UINavigationController, pushed: UIViewController) {
        self.navigationVC = navigationVC
        self.viewController = pushed

        super.init()
    }

    override func main() {
        DispatchQueue.main.async {
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                self.finish()
            }
            self.navigationVC.pushViewController(self.viewController, animated: true)
            CATransaction.commit()
        }
    }
}

// MARK: - Helpers

private extension UIViewController {

    var top: UIViewController {
        if let presentedVC = presentedViewController {
            return presentedVC.top
        }
        return self
    }
}

private extension UIColor {

    static var random: UIColor {
        let rand = { CGFloat.random(in: 0...1) }
        return UIColor(red: rand(), green: rand(), blue: rand(), alpha: 1.0)
    }
}
