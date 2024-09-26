//
//  NewsDetailView.swift
//  NewsReaderApp
//
//  Created by Mukul on 26/09/24.
//

import SwiftUI

struct NewsDetailView: View {
    let article: Article
    
    @State private var currentScale: CGFloat = 1.0
    @State private var finalScale: CGFloat = 1.0
    
    var body: some View {
        ScrollView { 
            VStack {
                Text(article.title)
                    .font(.headline)
                    .padding()
                Spacer()
                
                AsyncImage(url: URL(string: article.urlToImage ?? "" )) { image in
                    image
                        .resizable()
                        .frame(height: 300)
                    
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(currentScale * finalScale) // Apply the scaling
                        .gesture(
                            MagnificationGesture()
                                .onChanged { value in
                                    currentScale = value
                                }
                                .onEnded { value in
                                    finalScale *= currentScale
                                    currentScale = 1.0 // Reset current scale for next gesture
                                }
                        )
                        .gesture(
                            TapGesture(count: 2) // Double tap gesture
                                .onEnded {
                                    withAnimation {
                                        if finalScale > 1.0 {
                                            // Reset to original scale
                                            finalScale = 1.0
                                        } else {
                                            // Zoom in on double tap
                                            finalScale = 2.0
                                        }
                                    }
                                }
                        )
                        .animation(.easeInOut, value: finalScale)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } placeholder: {
                    ProgressView()
                }
            }
            
            Text(article.description ?? "")
                .font(.headline)
                .padding()
            
            Spacer()
        }
        .navigationBarTitle("News", displayMode: .inline)
    }
}
