//
//  SurvivorInfo.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/21/25.
//

import SwiftUI

struct SurvivorInfo: View {
  @Binding var playerCount: Int
  @Binding var aliveCount: Int
  var body: some View {
    HStack{
      if (playerCount >= 5){
        HStack{
          Text("玩家: \(playerCount)")
            .font(.system(size: 15, design: .monospaced))
            .fontWeight(.semibold)
          Spacer()
          Text("存活: \(aliveCount)")
            .font(.system(size: 15, design: .monospaced))
            .fontWeight(.semibold)
        }
      }
    }
    .animation(.easeInOut(duration: 0.3), value: playerCount)
    .animation(.easeInOut(duration: 0.3), value: aliveCount)
  }
}

#Preview {
  SurvivorInfo(playerCount: .constant(10), aliveCount: .constant(10))
}
