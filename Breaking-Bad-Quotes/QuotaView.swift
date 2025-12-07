//
//  QuotaView.swift
//  Breaking-Bad-Quotes
//
//  Created by Guang on 2025/12/5.
//

import SwiftUI

struct QuotaView: View {
  let viewModel: ViewModel = ViewModel()
  let show: String

  var body: some View {
    GeometryReader { geometry in
      ZStack {
        Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
          .resizable()
          .scaledToFill()
          .clipped()
        VStack {
          Text("\"\(viewModel.quote.quote)\"")
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .padding()
            .background(Color.gray.opacity(0.7))
            .cornerRadius(25)
            .padding(.horizontal, 30)
            .padding(.top, 80)

          Spacer()
            .frame(height: 5)

          ZStack(alignment: .bottom) {
            AsyncImage(url: viewModel.character.images.first!) { image in
              image
                .resizable()
                .scaledToFill()
                .brightness(0.15)
                .contrast(1.1)
            } placeholder: {
              ProgressView()
            }
            .frame(width: geometry.size.width * 0.80, height: geometry.size.height * 0.6)
            .clipped()

            Text(viewModel.character.name)
              .foregroundColor(.white)
              .padding()
              .frame(maxWidth: .infinity)
              .background(.ultraThinMaterial)
          }
          .frame(width: geometry.size.width * 0.80, height: geometry.size.height * 0.6)
          .clipShape(.rect(cornerRadius: 25))

          Spacer()
        }
        .frame(width: geometry.size.width, height: geometry.size.height)
      }
      .frame(width: geometry.size.width, height: geometry.size.height)
    }
  }
}

#Preview {
  QuotaView(show: "Breaking Bad")
}
