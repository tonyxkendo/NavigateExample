//
//  NavigateExampleAppViewModel.swift
//  NavigateExample
//
//  Created by Jassadakorn Ketkaew on 4/27/25.
//

import SwiftUI
import Core
import Combine

enum GoRouteError: Error {
    case notFound
    case urlNotValid
}

class NavigateExampleAppViewModel {
    
    private var anyCancellable: Set<AnyCancellable> = .init()
    
    func startObserveRoute() {
        InternalRouteManager.shared.openRoute
            .flatMap { response -> AnyPublisher<Void, Error> in
                if let goByName = response as? RouteByname {
                    return self.goByName(goByName: goByName)
                }
                return Fail(error: GoRouteError.notFound).eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    // display Error here
                    break
                }
        } receiveValue: { transitionResponse in
            
        }.store(in: &anyCancellable)
    }
    
    private func goByName(goByName: RouteByname) -> AnyPublisher<Void, Error> {
        if let goRoute = Router.routes.first(where: { $0.name == goByName.name }) {
            let viewController = goRoute.pageBuilder(goByName.param)
            let coordinator: SceneCoordinatorType = SceneCoordinator()
            return coordinator
                .transition(type: goByName.transitionType, target: viewController)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: GoRouteError.notFound).eraseToAnyPublisher()
        }
    }
}
