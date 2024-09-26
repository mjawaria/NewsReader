//
//  NewsModel.swift
//  NewsReaderApp
//
//  Created by Mukul on 26/09/24.
//

import Foundation

struct NewsResponse: Codable {
    let articles: [Article]
    let status: String
    let totalResults: Int
}

// MARK: - Article
struct Article: Codable, Identifiable {
    let id = UUID() 
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    //let publishedAt: Date
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}
