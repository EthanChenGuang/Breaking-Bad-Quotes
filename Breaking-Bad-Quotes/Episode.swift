//
//  Episode.swift
//  Breaking-Bad-Quotes
//
//  Created by Guang on 2025/12/10.
//

import Foundation

struct Episode: Decodable {
  let episode: Int
  let title: String
  let image: URL
  let synopsis: String
  let writtenBy: String
  let directedBy: String
  let airDate: String

  var seasonEpisode: String {
    var episodeString = String(episode)  // 101
    let season = episodeString.removeFirst()  // season = 1 episode = 01

    if episodeString.first! == "0" {
      episodeString.removeLast()  // episode = 1..9
    }
    return "Season \(season) Episode \(episodeString)"
  }
}
