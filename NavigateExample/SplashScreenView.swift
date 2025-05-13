//
//  SplashScreenView.swift
//  NavigateExample
//
//  Created by Jassadakorn Ketkaew on 4/26/25.
//

import SwiftUI

struct SplashScreenView: View {
    
    var viewModel: SplashScreenViewModel
    
    init(viewModel: SplashScreenViewModel = SplashScreenViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("SplashScreen Loading..")
    }
}

#Preview {
    SplashScreenView()
}
