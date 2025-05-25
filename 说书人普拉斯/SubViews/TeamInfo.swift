//
//  TeamInfo.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/21/25.
//

import SwiftUI

struct TeamInfo: View {
  @Binding var playerCount: Int
  var body: some View {
    HStack{
      if (playerCount < 5){
        Text("人数太少，当前有\(playerCount)名玩家")
          .font(.system(size: 15, design: .monospaced))
          .fontWeight(.semibold)
          .frame(maxWidth: .infinity, alignment: .trailing)
      }else{
        if (playerCount <= 20){
          let teamCount = teamCounts[playerCount] ?? [0, 0, 0, 0]
          let text1 = Text("\(teamCount[0])")
            .font(.system(size: 15, design: .monospaced))
            .fontWeight(.bold)
          
          let text2 = Text(" 民 ")
            .font(.system(size: 15, design: .rounded))
            .fontWeight(.semibold)
            .foregroundColor(.townsfolk)
          
          let text3 = Text("\(teamCount[1])")
            .font(.system(size: 15, design: .monospaced))
            .fontWeight(.bold)
          
          let text4 = Text(" 外 ")
            .font(.system(size: 15, design: .rounded))
            .fontWeight(.semibold)
            .foregroundColor(.outsider)
          let text5 = Text("\(teamCount[2])")
            .font(.system(size: 15, design: .monospaced))
            .fontWeight(.bold)
          
          let text6 = Text(" 爪 ")
            .font(.system(size: 15, design: .rounded))
            .fontWeight(.semibold)
            .foregroundColor(.minion)
          let text7 = Text("\(teamCount[3])")
            .font(.system(size: 15, design: .monospaced))
            .fontWeight(.bold)
          
          let text8 = Text(" 恶" + (teamCount[4] > 0 ? " " : ""))
            .font(.system(size: 15, design: .rounded))
            .fontWeight(.semibold)
            .foregroundColor(.demon)
          
          let text9 = Text(teamCount[4] > 0 ? "\(teamCount[4])" : "")
            .font(.system(size: 15, design: .monospaced))
            .fontWeight(.bold)
          let text10 = Text(teamCount[4] > 0 ? " 旅" : "")
            .font(.system(size: 15, design: .rounded))
            .fontWeight(.semibold)
            .foregroundColor(.traveler)
          
          HStack {
            Text("应有： ")
              .font(.system(size: 15, design: .rounded))
              .fontWeight(.semibold)
            Spacer()
            (text1 + text2 + text3 + text4 + text5 + text6 + text7 + text8 + text9 + text10)
          }
          .frame(maxWidth: .infinity, alignment: .trailing)
        }
      }
    }
    .animation(.easeInOut(duration: 0.3), value: playerCount)
  }
}

#Preview {
  TeamInfo(playerCount: .constant(10))
}
