//
//  CardFront.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 7/3/25.
//

import SwiftUI

struct CardFront: View {
  let character: Character
  let cardColor: Color
  var body: some View {
    VStack{
      CachedImageView(urlString: character.imageURL)
        .frame(width: 140, height: 140)
        .background(Circle()
          .fill(Color.goodTextBg)
        )
        .padding(.top, 20)
      VStack{
        Text(character.name)
          .font(.system(size: 35, design: .rounded))
          .foregroundStyle(.goodTextBg)
          .fontWeight(.bold)
          .multilineTextAlignment(.center)
      }
      .padding(.horizontal, 10)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    .frame(width: 200, height: 300)
    .background(cardColor)
    .overlay(
      RoundedRectangle(cornerRadius: 10)
        .stroke(cardColor, lineWidth: 14)
    )
    .overlay(
      RoundedRectangle(cornerRadius: 10)
        .stroke(.white, lineWidth: 4)
    )
  }
}

#Preview{
  CardFront(character: 末日预言者, cardColor: .outsider)
}
