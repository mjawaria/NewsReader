//
//  NewsListView.swift
//  NewsReaderApp
//
//  Created by Mukul on 26/09/24.
//

import SwiftUI

struct NewsListView: View {
    @StateObject private var viewModel = NewsListViewModel()

    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationView {

            ScrollView {
                
                LazyVGrid(columns: columns, spacing: 20) {
                    
                    ForEach(viewModel.articles) { item in
                        NavigationLink(destination: NewsDetailView(article: item)) {
                            VStack {
                                AsyncImage(url: URL(string: item.urlToImage ?? "")) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 150)
                                } placeholder: {
                                    ProgressView()
                                }
                                Text(item.title)
                                    .font(.caption)
                                    .lineLimit(2)
                                    .padding(.top, 5)
                            }
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("News")
        }
        .onAppear {
            viewModel.loadNews()
        }
    }
}

#Preview {
    NewsListView()
}
