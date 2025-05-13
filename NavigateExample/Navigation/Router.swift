//
//  Router.swift
//  NavigateExample
//
//  Created by Jassadakorn Ketkaew on 4/26/25.
//

import UIKit
import Core
import SwiftUI
import HomeFeed
import Detail

struct Route {
    var name: RouteName
    var pageBuilder: (_ param: [String: Any]) -> UIViewController
}

enum Router {
    static var root: some View {
        SplashScreenView()
    }
    
    static var routes: [Route] = [
        Route(name: .homeFeed,
              pageBuilder: { _ in
                  UINavigationController(rootViewController: UIHostingController(rootView: HomeFeedView()))
              }),
        
        Route(name: .detail,
              pageBuilder: { param in
                  let viewModel: DetailViewModel = .init(titleString: param["title"] as! String)
                  return DetailViewController(viewModel: viewModel)
              })
    ]
}
