//
//  HomeFeedView.swift
//  HomeFeed
//
//  Created by Jassadakorn Ketkaew on 4/26/25.
//

import SwiftUI

public struct HomeFeedView: View {
    
    let viewModel: HomeFeedViewModel = HomeFeedViewModel()
    
    public init() {
        
    }
    
    public var body: some View {
        Text("HomeFeedView")
        Button {
            viewModel.openDetail()
        } label: {
            Text("Open Detail")
        }
    }
}

#Preview {
    HomeFeedView()
}
