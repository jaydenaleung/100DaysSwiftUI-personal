//
//  ExpandableView.swift
//  Africa
//
//  Created by Jayden Leung on 9/19/24.
//

import SwiftUI

struct ExpandableView: View {
    @Namespace private var namespace
    @State private var show = false
    
    var thumbnail: ThumbnailView
    var expanded: ExpandedView
    
    var body: some View {
        ZStack {
            if !show {
                thumbnailView()
            } else {
                expandedView()
            }
        }
        .onTapGesture {
            if !show {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) { show.toggle() }
            }
        }
        
    }
    
    @ViewBuilder
    private func thumbnailView() -> some View {
        ZStack {
            thumbnail
                .matchedGeometryEffect(id: "view", in: namespace)
        }
        .background(Color.gray.matchedGeometryEffect(id: "background", in: namespace))
        .mask {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .matchedGeometryEffect(id: "mask", in: namespace)
        }
    }
    
    private func expandedView() -> some View {
        ZStack {
            expanded
                .matchedGeometryEffect(id: "view", in: namespace)
                .background(Color.gray.matchedGeometryEffect(id: "background", in: namespace))
                .mask {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .matchedGeometryEffect(id: "mask", in: namespace)
                }
            
            Button (action: {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) { show.toggle() }
            }, label: {
                Image(systemName: "xmark")
                    .foregroundStyle(.white)
            })
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .matchedGeometryEffect(id: "mask", in: namespace)
        }
    }
    
}
