//
//  SplashScreenViewModel.swift
//  NavigateExample
//
//  Created by Jassadakorn Ketkaew on 4/26/25.
//

import Foundation
import Core

class SplashScreenViewModel: ObservableObject {
    
    let navigate: NavigatorType
    
    init(navigate: NavigatorType = Navigator()) {
        self.navigate = navigate
        self.fetchConfig()
    }
    
    
    func fetchConfig() {
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.navigate.by(
                name: .homeFeed,
                parameters: [:],
                transitionType: .modal(animated: false,
                                       modalTransitionStyle: .coverVertical,
                                       modalPresentationStyle: .fullScreen))
        }
    }
}
