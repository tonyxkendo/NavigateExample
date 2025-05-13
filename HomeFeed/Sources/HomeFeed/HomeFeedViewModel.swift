//
//  HomeFeedViewModel.swift
//  HomeFeed
//
//  Created by Jassadakorn Ketkaew on 4/26/25.
//
import Core

public class HomeFeedViewModel {
    
    let navigate: NavigatorType
    
    init(navigate: NavigatorType = Navigator()) {
        self.navigate = navigate
    }
    
    func openDetail() {
        navigate.by(name: .detail,
                    parameters: ["title": "Hello Title"],
                    transitionType: .modal(animated: true))
    }
    
}
