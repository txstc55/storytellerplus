//
//  ExtraSetup.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/21/25.
//

import SwiftUI

struct ExtraSetup: View {
  @Binding var playableCharacters: [Character]
  @Binding var playersAssignedCharacters: [Character]
  
  private var assignedCharacterNames: [String] {
    playersAssignedCharacters.map { $0.name }
  }
  var body: some View {
    ScrollView(showsIndicators: false) {
      Text("设置调整")
        .font(.system(size: 25, design: .rounded))
        .fontWeight(.bold)
        .padding(.top, 10)
      VStack{
        ForEach($playableCharacters, id: \.id) { character in
          if (character.setup.wrappedValue){
            HStack{
              CachedImageView(urlString: character.imageURL.wrappedValue)
                .frame(width: 50, height: 50)
              VStack(alignment: .leading){
                Text(character.name.wrappedValue)
                  .font(.system(size: 20, design: .rounded))
                  .fontWeight(.bold)
                Text(character.ability.wrappedValue)
                  .font(.system(size: 15, design: .rounded))
                  .fontWeight(.semibold)
              }
              .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .opacity(assignedCharacterNames.contains(character.name.wrappedValue) ? 1 : 0.5)
          }
        }
      }
      .padding(.bottom, 20)
    }
  }
}

//#Preview {
//  ExtraSetup(playableCharacters: .constant([]))
//}
