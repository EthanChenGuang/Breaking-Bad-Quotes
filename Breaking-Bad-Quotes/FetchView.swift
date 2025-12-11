//
//  QuotaView.swift
//  Breaking-Bad-Quotes
//
//  Created by Guang on 2025/12/5.
//

import SwiftUI

struct FetchView: View {
  let viewModel: ViewModel = ViewModel()
  let show: String
  @State private var showCharacterView: Bool = false

  var body: some View {
    GeometryReader { geometry in
      ZStack {
        Image(show.removeCaseAndSpace())
          .resizable()
          .scaledToFill()
          .frame(width: geometry.size.width * 2.7, height: geometry.size.height * 1.2)

        VStack {
          VStack {

            Spacer(minLength: 60)

            switch viewModel.status {

            case .notStarted:
              EmptyView()

            case .fetching:
              ProgressView()

            case .successQuote:

              // Quote Text
              Text(
                "\"\(viewModel.quote.quote)\""
              )
              .minimumScaleFactor(0.5)
              .lineLimit(10)
              .truncationMode(.tail)
              .multilineTextAlignment(.leading)
              .foregroundColor(.white)
              .padding(.all, 20)
              .background(Color.gray.opacity(0.5))
              .cornerRadius(25)
              .padding(.horizontal)

              Spacer()
                .frame(height: 10)

              // Character Image and Name
              ZStack(alignment: .bottom) {

                // Character Image
                AsyncImage(url: viewModel.character.images.randomElement()) { image in
                  image
                    .resizable()
                    .scaledToFill()
                    .brightness(0.15)
                    .contrast(1.1)
                } placeholder: {
                  ProgressView()
                }
                .frame(width: geometry.size.width / 1.1, height: geometry.size.height / 1.8)
                .clipped()

                // Tap Icon Indicator
                VStack {
                  HStack {
                    Spacer()
                    Image(systemName: "info.circle.fill")
                      .font(.title)
                      .foregroundColor(.white)
                      .shadow(color: .black.opacity(0.5), radius: 3)
                      .padding()
                  }
                  Spacer()
                }

                // Character Name
                Text(viewModel.character.name)
                  .foregroundColor(.white)
                  .padding(.all, 12)
                  .frame(maxWidth: .infinity)
                  .background(.ultraThinMaterial)
              }
              .frame(width: geometry.size.width / 1.1, height: geometry.size.height / 1.8)
              .clipShape(.rect(cornerRadius: 25))
              .onTapGesture {
                showCharacterView.toggle()
              }

            case .successEpisode:

              EpisodeView(episode: viewModel.episode)

            case .successCharacter:

              // Character Image and Name
              ZStack(alignment: .bottom) {

                // Character Image
                AsyncImage(url: viewModel.character.images.randomElement()) { image in
                  image
                    .resizable()
                    .scaledToFill()
                    .brightness(0.15)
                    .contrast(1.1)
                } placeholder: {
                  ProgressView()
                }
                .frame(width: geometry.size.width / 1.1, height: geometry.size.height / 1.8)
                .clipped()

                // Tap Icon Indicator
                VStack {
                  HStack {
                    Spacer()
                    Image(systemName: "info.circle.fill")
                      .font(.title)
                      .foregroundColor(.white)
                      .shadow(color: .black.opacity(0.5), radius: 3)
                      .padding()
                  }
                  Spacer()
                }

                // Character Name
                Text(viewModel.character.name)
                  .foregroundColor(.white)
                  .padding(.all, 12)
                  .frame(maxWidth: .infinity)
                  .background(.ultraThinMaterial)
              }
              .frame(width: geometry.size.width / 1.1, height: geometry.size.height / 1.8)
              .clipShape(.rect(cornerRadius: 25))
              .onTapGesture {
                showCharacterView.toggle()
              }

            case .failed(let error):
              Text("Failed: \(error.localizedDescription)")

            }

            Spacer()

          }
          HStack(spacing: 8) {
            // Get Random Quote Button
            Button {
              Task {
                await viewModel.getQuoteData(for: show)
              }

            } label: {
              Text("Get Random Quote")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(Color("\(show.replacingOccurrences(of: " ", with: ""))Button"))
                .clipShape(.rect(cornerRadius: 7))
                .shadow(
                  color: Color("\(show.replacingOccurrences(of: " ", with: ""))Shadow"), radius: 2
                )
            }

            // Get Random Episode Button
            Button {
              Task {
                await viewModel.getEpisodeData(for: show)
              }
            } label: {
              Text("Get Random Episode")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(Color("\(show.replacingOccurrences(of: " ", with: ""))Button"))
                .clipShape(.rect(cornerRadius: 7))
                .shadow(
                  color: Color("\(show.replacingOccurrences(of: " ", with: ""))Shadow"), radius: 2
                )
            }

            // Get Random Character Button
            Button {
              Task {
                await viewModel.getCharacterData(for: show)
              }
            } label: {
              Text("Get Random Character")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(Color("\(show.replacingOccurrences(of: " ", with: ""))Button"))
                .clipShape(.rect(cornerRadius: 7))
                .shadow(
                  color: Color("\(show.replacingOccurrences(of: " ", with: ""))Shadow"), radius: 2)
            }
          }
          .padding(.horizontal, 40)

          Spacer(minLength: 95)

        }  //VStack
        .frame(width: geometry.size.width, height: geometry.size.height)
        .task {
          if viewModel.status == .notStarted {
            await viewModel.getQuoteData(for: show)
          }
        }

      }  //ZStack
      .frame(width: geometry.size.width, height: geometry.size.height)

    }  //GeometryReader
    .ignoresSafeArea()
    .sheet(isPresented: $showCharacterView) {
      CharacterView(character: viewModel.character, show: show)
    }

  }  //Body view

}  //QuotaView

#Preview {
  FetchView(show: "Breaking Bad")
}
