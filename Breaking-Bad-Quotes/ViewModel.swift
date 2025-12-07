//
//  ViewModel.swift
//  Breaking-Bad-Quotes
//
//  Created by Guang on 2025/12/2.
//

import Foundation

@Observable
class ViewModel {
  enum FetchStatus {
    case notStarted
    case fetching
    case success
    case failed(error: Error)
  }

  private(set) var status: FetchStatus = .notStarted

  private let fetcher = FetchService()
  var quote: Quote
  var character: Character

  func fetchQuote(from show: String) async {
    do {
      quote = try await fetcher.fetchQuote(from: show)
    } catch {
      print("Error fetching quote: \(error)")
    }
  }

  init() {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    let quoteData = try! Data(
      contentsOf: Bundle.main.url(forResource: "samplequote", withExtension: "json")!)
    self.quote = try! decoder.decode(Quote.self, from: quoteData)

    let characterData = try! Data(
      contentsOf: Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!)
    self.character = try! decoder.decode(Character.self, from: characterData)

  }

  func getData(for show: String) async {
    status = .fetching
    do {
      quote = try await fetcher.fetchQuote(from: show)
      character = try await fetcher.fetchCharacter(from: quote.character)
      character.death = try await fetcher.fetchDeath(from: character.name)
      status = .success
    } catch {
      status = .failed(error: error)
    }

  }

}
