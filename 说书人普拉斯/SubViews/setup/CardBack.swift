//
//  CardBack.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 6/30/25.
//

import SwiftUI

struct CardBack: View {
  let cardColor: Color
  var body: some View {
    Image("cardBack")
      .renderingMode(.template)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(width: 200, height: 300)
      .scaleEffect(1.0)
      .foregroundColor(.goodTextBg)
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

#Preview {
  ZStack{
    Color.mainbg
    CardBack(cardColor: .townsfolk)
  }
  
}
