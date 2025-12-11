//
//  EpisodeView.swift
//  Breaking-Bad-Quotes
//
//  Created by Guang on 2025/12/10.
//

import SwiftUI

struct EpisodeView: View {
  let episode: Episode

  var body: some View {
    VStack(alignment: .leading) {
      Text(episode.title)
        .font(.largeTitle)

      Text(episode.seasonEpisode)
        .font(.title2)

      AsyncImage(url: episode.image) { image in
        image
          .resizable()
          .scaledToFit()
          .clipShape(.rect(cornerRadius: 25))
      } placeholder: {
        ProgressView()
      }

      Text(episode.synopsis)
        .font(.title3)
        .minimumScaleFactor(0.5)
        .padding(.bottom)

      Text("Written by: \(episode.writtenBy)")
        .font(.subheadline)

      Text("Directed by: \(episode.directedBy)")
        .font(.subheadline)

      Text("Air Date: \(episode.airDate)")
        .font(.subheadline)

    }
    .padding()
    .foregroundStyle(.white)
    .background(Color.black.opacity(0.5))
    .cornerRadius(25)
    .padding(.horizontal)
  }
}

#Preview {
  EpisodeView(episode: ViewModel().episode)
}
