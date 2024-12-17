//
//  ThumbnailView.swift
//  Africa
//
//  Created by Jayden Leung on 9/19/24.
//

import SwiftUI

struct ThumbnailView: View {
    var id = UUID()
    @ViewBuilder var content: any View
    
    var body: some View {
        ZStack {
            AnyView(content)
        }
    }
}
