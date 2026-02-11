//
//  FakeCover.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/22/25.
//
import SwiftUI
struct FakeCover: View {
  @Binding var playersAssignedCharacters: [Character]
  @Binding var notPresentedGoodCharacters: [Character]
  @Binding var selectNewCharacter: Bool
  @Binding var currentSelectedPlayerID: Int
  private var assignedCharacterNames: [String]{
    return playersAssignedCharacters.map { $0.name }
  }
  
  var body: some View {
    VStack{
      Text("恶魔伪装")
        .font(.system(size: 20, design: .rounded))
        .fontWeight(.bold)
        .foregroundColor(.black)
      ForEach(0...2, id: \.self) { index in
        let character = index < notPresentedGoodCharacters.count ? notPresentedGoodCharacters[index] : defaultCharacter
        VStack(spacing: 0){
          CachedImageView(urlString: character.imageURL)
            .frame(width: 50, height: 50)
            .onTapGesture{
              selectNewCharacter = true
              currentSelectedPlayerID = index + 21
            }
          Text(character.name)
            .font(.system(size: 14, design: .rounded))
            .fontWeight(.bold)
            .foregroundColor(.black)
            .lineLimit(1)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 5)
        .frame(maxWidth: .infinity)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.warningRed, lineWidth: assignedCharacterNames.contains(character.name) ? 3 : 0))
        .padding(.horizontal, 5)
      }
    }
//    .padding(.horizontal, 2)
  }
}
