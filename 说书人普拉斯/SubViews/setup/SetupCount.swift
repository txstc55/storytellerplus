//
//  SetupCount.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 7/3/25.
//

import SwiftUI

struct SetupCount: View {
  @Binding var playerCount: Int
  @Binding var selectionState: Int
  @Binding var selectedTeamCounts: [Int]
  let teamNames = ["恶魔", "爪牙", "外来者", "镇民"]
  let teamNameEnglish = ["demon", "minion", "outsider", "townsfolk"]
  let teamColors: [Color] = [.demon, .minion, .outsider, .townsfolk]
  var body: some View {
    VStack{
      let teamName: String = teamNames[selectionState / 3]
      let teamCount: [Int] = Array((teamCounts[playerCount] ?? [0, 0, 0, 0, 0]).reversed())
      Text("选择 \(teamName) 数量")
        .font(.system(size: 35, design: .rounded))
        .fontWeight(.bold)
      
      Text("(应有 \(teamCount[selectionState / 3 + 1]) 个 \(teamName))")
        .font(.system(size: 30, design: .rounded))
        .fontWeight(.bold)
        .padding(.top, 20)
      
      HStack{
        Button(action: {
          selectedTeamCounts[selectionState / 3] = max(selectedTeamCounts[selectionState / 3] - 1, 0)
        }){
          Text("-")
            .font(.system(size: 40, design: .rounded))
            .fontWeight(.bold)
            .foregroundColor(.black)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
        Text("\(selectedTeamCounts[selectionState / 3])")
          .font(.system(size: 40, design: .rounded))
          .fontWeight(.bold)
          .foregroundColor(.black)
          .padding(.horizontal, 20)
          .padding(.vertical, 10)
        Button(action: {
          selectedTeamCounts[selectionState / 3] += 1
        }){
          Text("+")
            .font(.system(size: 40, design: .rounded))
            .fontWeight(.bold)
            .foregroundColor(.black)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
      }

      
    }
  }
}
