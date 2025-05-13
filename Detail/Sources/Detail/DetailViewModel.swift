//
//  DetailViewModel.swift
//  Detail
//
//  Created by Jassadakorn Ketkaew on 4/26/25.
//

import Core

public class DetailViewModel {
    
    var titleString: String
    private let navigate: NavigatorType
    
    public init(navigate: NavigatorType = Navigator(),
         titleString: String = "") {
        self.navigate = navigate
        self.titleString = titleString
    }

    func onTapClose() {
        self.navigate.back(.dismiss, animated: true) {
            
        }
    }
}
