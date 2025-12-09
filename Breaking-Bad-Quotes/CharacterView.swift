//
//  CharacterView.swift
//  Breaking-Bad-Quotes
//
//  Created by Guang on 2025/12/8.
//

import SwiftUI

struct CharacterView: View {
  let character: Character
  let show: String

  var body: some View {
    GeometryReader { geometry in
      ScrollViewReader { proxy in
        ZStack(alignment: .top) {
          Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
            .resizable()
            .scaledToFit()

          ScrollView {
            TabView {
              ForEach(character.images, id: \.self) { imageURL in
                AsyncImage(url: imageURL) { image in
                  image
                    .resizable()
                    .scaledToFit()
                } placeholder: {
                  ProgressView()
                }
              }
            }
            .tabViewStyle(.page)
            .frame(width: geometry.size.width / 1.2, height: geometry.size.height / 1.7)
            .clipShape(.rect(cornerRadius: 25))
            .padding(.top, 60)

            VStack(alignment: .leading) {
              Text(character.name)
                .font(.largeTitle)

              Text("Portrayed by: \(character.portrayedBy)")
                .font(.subheadline)

              Divider()

              Text("\(character.name) Character Info:")
                .font(.title2)

              Text("Born: \(character.birthday)")

              Divider()

              Text("Occupations:")

              ForEach(character.occupations, id: \.self) { occupation in
                Text("• \(occupation)")
                  .font(.subheadline)
              }

              Divider()

              Text("Nicknames:")

              if character.aliases.count > 0 {
                ForEach(character.aliases, id: \.self) { alias in
                  Text("• \(alias)")
                    .font(.subheadline)
                }
              } else {
                Text("No nicknames")
                  .font(.subheadline)
              }
              Divider()

              DisclosureGroup("Status (spoiler alert!)") {
                VStack(alignment: .leading) {
                  Text(character.status)
                    .font(.title2)

                  // if the character is dead, show the death information
                  if let death = character.death {

                    AsyncImage(url: death.image) { image in
                      image
                        .resizable()
                        .scaledToFit()
                        .clipShape(.rect(cornerRadius: 15))
                        .onAppear {
                          withAnimation {
                            proxy.scrollTo(1, anchor: .bottom)
                          }
                        }
                    } placeholder: {
                      ProgressView()
                    }

                    Text("How: \(death.details)")
                      .font(.subheadline)
                      .padding(.bottom, 7)

                    Text("Last Words: \(death.lastWords)")
                      .font(.subheadline)

                  }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
              }
              .tint(.primary)

            }
            .id(1)
            .frame(width: geometry.size.width / 1.25, alignment: .leading)
            .padding(.bottom, 50)

          }
          .scrollIndicators(.hidden)
        }
      }
    }
    .ignoresSafeArea()
  }
}

#Preview {
  CharacterView(character: ViewModel().character, show: "Breaking Bad")
}
