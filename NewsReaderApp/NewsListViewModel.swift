//
//  NewsListViewModel.swift
//  NewsReaderApp
//
//  Created by Mukul on 26/09/24.
//

import Foundation
import Combine

class NewsListViewModel: ObservableObject {
    @Published var articles: [Article] = []
    private var cancellables = Set<AnyCancellable>()
    
    private let apiKey = "8345f57f64714a9ca3637d35c739c9ef"
    private let baseURL = "https://newsapi.org/v2/top-headlines"

    func loadNews() {
        self.fetchArticles(category: "business")
    }
    
    func fetchArticles(category: String) {
        guard let url = URL(string: "\(baseURL)?category=\(category)&apiKey=\(apiKey)") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: NewsResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching images: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.articles = response.articles
            })
            .store(in: &cancellables)
    }
}

