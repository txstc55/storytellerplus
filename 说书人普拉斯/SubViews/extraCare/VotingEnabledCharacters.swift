//
//  VotingEnabledCharacters.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/26/25.
//

import SwiftUI
struct VotingEnabledCharacters: View {
  // we will display the characters that has ability related to nomination
  @Binding var playersAssignedCharacters: [Character]
  @Binding var playersIsAlive: [Bool]
  var body: some View{
    ScrollView(showsIndicators: false) {
      ForEach(playersAssignedCharacters.indices, id: \.self) { index in
        let character = playersAssignedCharacters[index]
        let needsCare = character.ability.contains("投票")
        if needsCare{
          HStack{
            CachedImageView(urlString: character.imageURL)
              .frame(width: 40, height: 40)
            VStack(alignment: .leading){
              HStack{
                Text("\(index + 1)号   \(character.name)")
                  .font(.system(size: 20, design: .rounded))
                  .fontWeight(.bold)
                  .foregroundColor(.black)
              }
              Text(character.ability)
                .font(.system(size: 15, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.black.opacity(0.8))
            }
            .padding(.top, 2)
            .frame(maxWidth: .infinity, alignment: .leading)
          }
          .padding(.vertical, 10)
          .padding(.horizontal, 5)
          .opacity(index >= playersIsAlive.count ? 0.5 : (playersIsAlive[index] ? 1 : 0.5))
        }
      }
    }
    .animation(.easeInOut(duration: 0.3), value: playersAssignedCharacters)
    .animation(.easeInOut(duration: 0.3), value: playersIsAlive)
  }
}
