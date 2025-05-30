//
//  CircularView.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/29/25.
//

import SwiftUI

struct CircularView: View{
  @Binding var playersAssignedCharacters: [Character]
  @Binding var playersIsAlive: [Bool]
  func backgroundColor(for team: String) -> Color {
    switch team {
    case "townsfolk": return .townsfolk
    case "outsider": return .outsider
    case "minion": return .minion
    case "demon": return .demon
    case "traveler": return .traveler
    default: return .black
    }
  }
  var body: some View{
    GeometryReader { geometry in
      let size = min(geometry.size.width, geometry.size.height)
      let radius = size / 2.5 // radius for layout
      let centerX = geometry.size.width / 2
      let centerY = geometry.size.height / 2
      
      ZStack {
        ForEach(playersAssignedCharacters.indices, id: \.self) { index in
          let angle = 2 * .pi / CGFloat(playersAssignedCharacters.count) * CGFloat(index)
          let x = centerX + radius * cos(angle)
          let y = centerY + radius * sin(angle)
          let x_text = centerX + radius * cos(angle) * 0.75
          let y_text = centerY + radius * sin(angle) * 0.75
          let team = playersAssignedCharacters[index].team
          let bgColor: Color = backgroundColor(for: team)
          let fgColor: Color = .goodTextBg
          Text("\(index + 1)")
            .font(.system(size: 15, design: .rounded))
            .fontWeight(.bold)
            .foregroundColor(fgColor)
            .frame(width: 25, height: 25)
            .background(bgColor)
            .clipShape(Circle())
            .scaleEffect(1.0 - Double(playersAssignedCharacters.count) * 0.0125) // scale down the view based on the number of characters
            .position(x: x_text, y: y_text)
            .opacity(playersIsAlive[index] ? 1.0 : 0.3) // adjust opacity based on player status
          
          CachedImageView(urlString: playersAssignedCharacters[index].imageURL)
            .frame(width: 45, height: 45)
            .scaleEffect(1.0 - Double(playersAssignedCharacters.count) * 0.0125) // scale down the view based on the number of characters
            .position(x: x, y: y)
            .opacity(playersIsAlive[index] ? 1.0 : 0.5) // adjust opacity based on player status
        }
      }
      .frame(width: geometry.size.width, height: geometry.size.height)
      .animation(.easeInOut(duration: 0.3), value: playersAssignedCharacters)
    }
  }
}
