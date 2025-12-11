//
//  FetchService.swift
//  Breaking-Bad-Quotes
//
//  Created by Guang on 2025/12/2.
//

import Foundation

struct FetchService {
  private enum FetchError: Error {
    case badResponse
  }

  private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!

  func fetchQuote(from show: String) async throws -> Quote {
    // Build fetch url
    let quoteURL = baseURL.appending(path: "quotes/random")
    let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])

    // Fetch data
    let (data, response) = try await URLSession.shared.data(from: fetchURL)

    // Handle response
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      throw FetchError.badResponse
    }

    // Decode data
    let quote = try JSONDecoder().decode(Quote.self, from: data)

    // Return quote
    return quote

  }

  func fetchCharacter(from name: String) async throws -> Character {
    // Build fetch url
    let characterURL = baseURL.appending(path: "characters")
    let fetchURL = characterURL.appending(queryItems: [URLQueryItem(name: "name", value: name)])

    // Fetch data
    let (data, response) = try await URLSession.shared.data(from: fetchURL)

    // Handle response
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      throw FetchError.badResponse
    }

    // Decode data
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    let characters = try decoder.decode([Character].self, from: data)

    // Return character
    return characters.first!

  }

  func fetchDeath(from character: String) async throws -> Death? {
    // Build fetch url
    let fetchURL = baseURL.appending(path: "deaths")

    // Fetch data
    let (data, response) = try await URLSession.shared.data(from: fetchURL)

    // Handle response
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      throw FetchError.badResponse
    }

    // Decode data
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    let deaths = try decoder.decode([Death].self, from: data)

    // Return death
    return deaths.first(where: { $0.character.lowercased() == character.lowercased() })
  }

  func fetchEpisode(from show: String) async throws -> Episode? {
    // Build fetch url
    let episodeURL = baseURL.appending(path: "episodes")
    let fetchURL = episodeURL.appending(queryItems: [URLQueryItem(name: "pruduction", value: show)])

    // Fetch data
    let (data, response) = try await URLSession.shared.data(from: fetchURL)

    // Handle response
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      throw FetchError.badResponse
    }

    // Decode data
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    let episodes = try decoder.decode([Episode].self, from: data)

    // Return character
    return episodes.randomElement()

  }
}
