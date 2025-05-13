//
//  Navigator.swift
//  Core
//
//  Created by Jassadakorn Ketkaew on 4/26/25.
//

import Combine
import Foundation
import SwiftUI
import UIKit

public enum BackType {
    case pop
    case dismiss
}

public protocol NavigatorType {
    func by(name: RouteName, parameters: [String: Any], transitionType: SceneTransitionType)
    func back(_ type: BackType, animated: Bool, completion: (() -> Void)?)
}

public class Navigator: NavigatorType {
    private let coordinator: SceneCoordinatorType
    private let routeManager: InternalRouteManagerType
    private var anyCancellable: Set<AnyCancellable> = .init()
    
    public init(coordinator: SceneCoordinatorType = SceneCoordinator(),
                routeManager: InternalRouteManagerType = InternalRouteManager.shared) {
        self.coordinator = coordinator
        self.routeManager = routeManager
    }
    
    public func by(name: RouteName, parameters: [String : Any], transitionType: SceneTransitionType) {
        routeManager
            .openRoute
            .send(
                RouteByname(name: name,
                            param: parameters,
                            transitionType: transitionType)
            )
    }
    
    public func back(_ type: BackType, animated: Bool, completion: (() -> Void)?) {
        switch type {
        case .pop:
            coordinator
                .transition(type: .pop(animated: animated), target: UIViewController())
        case .dismiss:
            coordinator
                .transition(type: .dismiss(animated: animated), target: UIViewController())
                .sink {
                    completion?()
                }
                .store(in: &anyCancellable)
        }
    }
}
