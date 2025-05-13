//
//  NavigateExampleApp.swift
//  NavigateExample
//
//  Created by Jassadakorn Ketkaew on 4/26/25.
//

import SwiftUI

@main
struct NavigateExampleApp: App {
    
    let viewModel: NavigateExampleAppViewModel = .init()
    
    var body: some Scene {
        WindowGroup {
            Router.root
                .onAppear {
                    viewModel.startObserveRoute()
                }
        }
    }
}
