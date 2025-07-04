//
//  SetupCount.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 7/3/25.
//

import SwiftUI
import Flow
struct SetupBlindPick: View {
  @Binding var playableCharacters: [Character]
  @Binding var selectedTeamCounts: [Int]
  @Binding var cardSelected: [Bool]
  @Binding var selectionState: Int
  @State private var selectedCount: Int = 0
  let teamNames = ["恶魔", "爪牙", "外来者", "镇民"]
  let teamNameEnglish = ["demon", "minion", "outsider", "townsfolk"]
  let teamColors: [Color] = [.demon, .minion, .outsider, .townsfolk]
  var body: some View {
    let teamIndex = Int(selectionState / 3)
    let teamName: String = teamNames[teamIndex]
    let teamNameEnglish: String = teamNameEnglish[teamIndex]
    //      let teamCharacters: [Character] = playableCharacters.filter { $0.team == teamNameEnglish }
    let teamColor: Color = teamColors[teamIndex]
    ScrollView{
      Text("请选择 \(selectedTeamCounts[teamIndex]) 张\(teamName)卡片\n（不需要点击确认）")
        .font(.system(size: 35, design: .rounded))
        .fontWeight(.bold)
        .padding(.vertical, 20)
      Text("已选择 \(selectedCount) 张\(teamName)卡片")
        .font(.system(size: 30, design: .rounded))
        .fontWeight(.bold)
        .padding(.bottom, 20)
      HFlow(horizontalAlignment: .center, verticalAlignment: .top){
        ForEach(playableCharacters.indices, id: \.self) { index in
          if playableCharacters[index].team == teamNameEnglish {
            CardBack(cardColor: teamColor)
              .scaleEffect(cardSelected[index] ? 1.1 : 1.0)
              .opacity(cardSelected[index] ? 1.0 : 0.7)
              .padding(.vertical, 40)
              .padding(.horizontal, 50)
              .onTapGesture {
                if !cardSelected[index] && selectedCount < selectedTeamCounts[teamIndex] {
                  cardSelected[index] = true
                  selectedCount += 1
                }else if cardSelected[index]{
                  cardSelected[index] = false
                  selectedCount -= 1
                }
              }
              .animation(.easeInOut(duration: 0.3), value: cardSelected[index])
          }
        }
      }
      Spacer()
      HStack(spacing: 60){
        Button(action: {
          selectionState -= 1
        }){
          Text("返回")
            .font(.system(size: 30, design: .rounded))
            .fontWeight(.bold)
            .foregroundColor(.black)
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .background(Color.mainbg)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 4))
            .contentShape(RoundedRectangle(cornerRadius: 10))
        }
        Button(action: {
          selectionState += 1
        }){
          Text("确认")
            .font(.system(size: 30, design: .rounded))
            .fontWeight(.bold)
            .foregroundColor(.black)
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .background(Color.mainbg)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 4))
            .contentShape(RoundedRectangle(cornerRadius: 10))
        }
      }
      .padding(.top, 40)
    }
    .onAppear{
      for index in 0..<playableCharacters.count {
        if playableCharacters[index].team == teamNameEnglish && cardSelected[index]{
          selectedCount += 1
        }
      }
    }
  }
}

