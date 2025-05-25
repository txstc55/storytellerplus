//
//  TeamInfo.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/21/25.
//

import SwiftUI

struct TeamActualInfo: View {
  @Binding var playersAssignedCharacters: [Character]
  var body: some View {
    HStack{
      if (playersAssignedCharacters.count >= 5){
          let text1 = Text("\(playersAssignedCharacters.filter({$0.team == "townsfolk"}).count)")
            .font(.system(size: 15, design: .monospaced))
            .fontWeight(.bold)
          
          let text2 = Text(" 民 ")
            .font(.system(size: 15, design: .rounded))
            .fontWeight(.semibold)
            .foregroundColor(.townsfolk)
          
          let text3 = Text("\(playersAssignedCharacters.filter({$0.team == "outsider"}).count)")
            .font(.system(size: 15, design: .monospaced))
            .fontWeight(.bold)
          
          let text4 = Text(" 外 ")
            .font(.system(size: 15, design: .rounded))
            .fontWeight(.semibold)
            .foregroundColor(.outsider)
          let text5 = Text("\(playersAssignedCharacters.filter({$0.team == "minion"}).count)")
            .font(.system(size: 15, design: .monospaced))
            .fontWeight(.bold)
          
          let text6 = Text(" 爪 ")
            .font(.system(size: 15, design: .rounded))
            .fontWeight(.semibold)
            .foregroundColor(.minion)
          let text7 = Text("\(playersAssignedCharacters.filter({$0.team == "demon"}).count)")
            .font(.system(size: 15, design: .monospaced))
            .fontWeight(.bold)
          
          let travlerCount = playersAssignedCharacters.filter({$0.team == "traveler"}).count
        
          let text8 = Text(" 恶" + (travlerCount > 0 ? " " : ""))
            .font(.system(size: 15, design: .rounded))
            .fontWeight(.semibold)
            .foregroundColor(.demon)
          
          let text9 = Text(travlerCount > 0 ? "\(travlerCount)" : "")
            .font(.system(size: 15, design: .monospaced))
            .fontWeight(.bold)
          let text10 = Text(travlerCount > 0 ? " 旅" : "")
            .font(.system(size: 15, design: .rounded))
            .fontWeight(.semibold)
            .foregroundColor(.traveler)
          
          HStack {
            Text("实有： ")
              .font(.system(size: 15, design: .rounded))
              .fontWeight(.semibold)
            Spacer()
            (text1 + text2 + text3 + text4 + text5 + text6 + text7 + text8 + text9 + text10)
          }
          .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    .animation(.easeInOut(duration: 0.3), value: playersAssignedCharacters)
  }
}

#Preview {
  TeamActualInfo(playersAssignedCharacters: .constant([]))
}
