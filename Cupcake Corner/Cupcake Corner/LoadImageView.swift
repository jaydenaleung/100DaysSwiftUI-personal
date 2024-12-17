////
////  LoadImageView.swift
////  Cupcake Corner
////
////  Created by Student on 11/5/24.
////
//
//import SwiftUI
//
//struct LoadImageView: View {
//    var body: some View {
//        AsyncImage(url: URL(string: "https://hws.dev/img/bad.png")) { phase in
//            if let image = phase.image {
//                image
//                    .resizable()
//                    .scaledToFit()
//            } else if phase.error != nil {
//                Text("There was an error loading the image.")
//            } else {
//                ProgressView()
//            }
//        } placeholder: {
//            Color.red
//            ProgressView()
//        }
//        .frame(width: 200, height: 300)
//    }
//}
//
//#Preview {
//    LoadImageView()
//}
