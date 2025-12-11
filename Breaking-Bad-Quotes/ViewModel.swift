//
//  ViewModel.swift
//  Breaking-Bad-Quotes
//
//  Created by Guang on 2025/12/2.
//

import Foundation

@Observable
class ViewModel {
  enum FetchStatus: Equatable {
    case notStarted
    case fetching
    case successQuote
    case successEpisode
    case successCharacter
    case failed(error: Error)

    static func == (lhs: FetchStatus, rhs: FetchStatus) -> Bool {
      switch (lhs, rhs) {
      case (.notStarted, .notStarted),
        (.fetching, .fetching),
        (.successQuote, .successQuote),
        (.successEpisode, .successEpisode),
        (.successCharacter, .successCharacter):
        return true
      case (.failed(let lhsError), .failed(let rhsError)):
        return lhsError.localizedDescription == rhsError.localizedDescription
      default:
        return false
      }
    }
  }

  private(set) var status: FetchStatus = .notStarted

  private let fetcher = FetchService()
  var quote: Quote
  var character: Character
  var episode: Episode

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

    let episodeData = try! Data(
      contentsOf: Bundle.main.url(forResource: "sampleepisode", withExtension: "json")!)
    self.episode = try! decoder.decode(Episode.self, from: episodeData)
  }

  func getQuoteData(for show: String) async {
    status = .fetching
    do {
      self.quote = try await fetcher.fetchQuote(from: show)
      self.character = try await fetcher.fetchCharacter(from: quote.character)
      self.character.death = try await fetcher.fetchDeath(from: character.name)
      self.status = .successQuote
    } catch {
      self.status = .failed(error: error)
    }

  }

  func getEpisodeData(for show: String) async {
    status = .fetching
    do {
      if let episode = try await fetcher.fetchEpisode(from: show) {
        self.episode = episode
        status = .successEpisode
      }
    } catch {
      status = .failed(error: error)
    }
  }

  func getCharacterData(for show: String) async {
    status = .fetching
    do {
      // Keep fetching until we find a character that appears in the current show
      var fetchedCharacter: Character
      repeat {
        fetchedCharacter = try await fetcher.fetchRandomCharacter()
      } while !fetchedCharacter.appearsIn(show: show)

      self.character = fetchedCharacter
      self.character.death = try await fetcher.fetchDeath(from: character.name)
      self.status = .successCharacter
    } catch {
      self.status = .failed(error: error)
    }
  }
}
