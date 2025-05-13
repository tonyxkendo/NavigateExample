//
//  SceneTransitionType.swift
//  Core
//
//  Created by Jassadakorn Ketkaew on 4/26/25.
//

import UIKit
import Combine
import SwiftUI

public enum SceneTransitionType {
    case push(animated: Bool)
    case modal(animated: Bool,
               modalTransitionStyle: UIModalTransitionStyle = .coverVertical,
               modalPresentationStyle: UIModalPresentationStyle = .fullScreen)
    case pop(animated: Bool)
    case popToRoot(animated: Bool)
    case dismiss(animated: Bool)
}

public protocol SceneCoordinatorType {
    @discardableResult
    func transition(type: SceneTransitionType, target: UIViewController) -> AnyPublisher<Void, Never>
    func transition(type: SceneTransitionType, target: some View) -> AnyPublisher<Void, Never>
    var currentViewController: UIViewController { get }
}

public class SceneCoordinator: SceneCoordinatorType {
    private weak var window: UIWindow?

    public var currentViewController: UIViewController {
        return UIViewController.topViewController() ?? rootViewController
    }

    var rootViewController: UIViewController {
        return window?.rootViewController ?? topViewController
    }

    var topViewController: UIViewController {
        return UIApplication.topViewController() ?? UIViewController()
    }

    public init() {
        window = UIApplication.keyWindowScene()
    }

    public init(window: UIWindow?) {
        self.window = window
    }

    @discardableResult
    public func transition(type: SceneTransitionType, target: some View) -> AnyPublisher<Void, Never> {
        return transition(type: type, target: UIHostingController(rootView: target))
    }

    @discardableResult
    public func transition(type: SceneTransitionType, target: UIViewController) -> AnyPublisher<Void, Never> {
        return Future<Void, Never> { promise in
            switch type {
            case let .modal(animated, modalTransitionStyle, modalPresentationStyle):
                let targetViewController = target
                targetViewController.modalTransitionStyle = modalTransitionStyle
                targetViewController.modalPresentationStyle = modalPresentationStyle
                self.currentViewController.present(targetViewController, animated: animated, completion: {
                    promise(.success(()))
                })
            case let .push(animated):
                // Prevent crash from UINavigationController push to UINavigationController
                if let navigationController = target as? UINavigationController,
                   let viewController = navigationController.viewControllers.first {
                    self.currentViewController.navigationController?.pushViewController(viewController, animated: animated)
                } else {
                    self.currentViewController.navigationController?.pushViewController(target, animated: animated)
                }
            case .pop:
                self.currentViewController.navigationController?.popViewController(animated: true)
            case let .popToRoot(animated):
                self.currentViewController.navigationController?.popToRootViewController(animated: animated)
            case .dismiss:
                self.currentViewController.dismiss(animated: true) {
                    promise(.success(()))
                }
            }
        }.eraseToAnyPublisher()
    }
}

extension UIApplication {
    
    class func topViewController(base: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController
            if let top = moreNavigationController.topViewController, top.view.window != nil {
                return topViewController(base: top)
            } else if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
    
    class func keyWindowScene() -> UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .filter { $0.activationState == .foregroundActive }
            .first?.keyWindow
    }
}

extension UIViewController {
    class func topViewController() -> UIViewController? {
        let window: UIWindow? = UIApplication.keyWindowScene()
        return topViewControllerWithRootViewController(rootViewController: window?.rootViewController)
    }

    class func topViewControllerWithRootViewController(rootViewController: UIViewController?) -> UIViewController? {
        if rootViewController is UITabBarController {
            if let control = rootViewController as? UITabBarController {
                return topViewControllerWithRootViewController(rootViewController: control.selectedViewController)
            }
        } else if rootViewController is UINavigationController {
            let control = rootViewController as? UINavigationController
            return topViewControllerWithRootViewController(rootViewController: control?.visibleViewController)
        } else if let control = rootViewController?.presentedViewController {
            return topViewControllerWithRootViewController(rootViewController: control)
        } else if let control = rootViewController?.children.first {
            return topViewControllerWithRootViewController(rootViewController: control)
        }
        return rootViewController
    }
}
