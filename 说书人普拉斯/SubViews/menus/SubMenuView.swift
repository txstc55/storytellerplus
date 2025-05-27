//
//  SubMenuView.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/22/25.
//
import SwiftUI
struct SubMenuView: View {
  @Binding var playersAssignedCharacters: [Character]
  @Binding var playersStates: [[Reminder]]
  @Binding var playersIsAlive: [Bool]
  @Binding var playersHasDeathVote: [Bool]
  @Binding var playerCount: Int
  @Binding var aliveCount: Int
  @Binding var playableCharacters: [Character]
  @Binding var notPresentedGoodCharacters: [Character]
  @Binding var showMenu: Bool
  @Binding var gameState: Int
  @Binding var allLogs: [GameLogEntry]
  
  func selectCharacters(team: Int) -> [Character] {
    var teamName: String
    let teamCount: [Int] = teamCounts[playerCount] ?? [0, 0, 0, 0, 0]
    if team == 0{
      teamName = "townsfolk"
    }else if team == 1{
      teamName = "outsider"
    }else if team == 2{
      teamName = "minion"
    }else if team == 3{
      teamName = "demon"
    }else{
      teamName = "traveler"
    }
    
    let filteredCharacter = playableCharacters.filter { $0.team == teamName }
    var selected: [Character]
    if filteredCharacter.isEmpty {
      selected = Array(repeating: defaultCharacter, count: teamCount[team])
    } else if filteredCharacter.count >= teamCount[team] {
      selected = Array(filteredCharacter.shuffled().prefix(teamCount[team]))
    } else {
      selected = (0..<teamCount[team]).map { _ in filteredCharacter.randomElement()! }
    }
    return selected
  }
  
  func removeLastPlayer(){
    if gameState == 0 {
      if (playerCount > 0){
        aliveCount -= 1
        playersAssignedCharacters.removeLast()
        playersStates.removeLast()
        playersIsAlive.removeLast()
        playersHasDeathVote.removeLast()
        print("Players assigned characters count: \(playersAssignedCharacters.count)")
        print("Players states count: \(playersStates.count)")
        print("Players is alive count: \(playersIsAlive.count)")
      }
      playerCount = max(playerCount - 1, 0)
    }
  }
  
  var body: some View {
    ZStack{
      Color.mainbg.opacity(0.4).ignoresSafeArea(.all)
        .onTapGesture {
          withAnimation(.easeInOut(duration: 0.3)) {
            showMenu = false
          }
        }
      HStack{
        VStack{
          Spacer()
          Button(action: {
            if (playerCount < 20){
              aliveCount += 1
              playersAssignedCharacters.append(defaultCharacter)
              playersStates.append([Reminder]())
              playersIsAlive.append(true)
              playersHasDeathVote.append(true)
              if (gameState != 0){
                allLogs.append(GameLogEntry(message: "\(playerCount + 1)号玩家加入游戏", messager: playerCount + 1, source: "说书人", type: 7))
              }
            }
            playerCount = min(playerCount + 1, 20)
            
          }){
            Text("增加玩家")
              .font(.system(size: 20,  design: .rounded))
              .fontWeight(.black)
              .foregroundColor(.white)
              .padding(.horizontal, 15)
              .padding(.vertical, 10)
              .background(Color.cyan)
              .cornerRadius(10)
          }
          Button(action: {
            removeLastPlayer()
          }){
            Text("减少玩家")
              .font(.system(size: 20,  design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.white)
              .padding(.horizontal, 15)
              .padding(.vertical, 10)
              .background(.red)
              .cornerRadius(10)
          }
          Button(action: {
            // ok now we need to do a selection
            // we first check the characters
            // first we get the setting, the number of player on each team
            if playerCount >= 5{
              //                var teamCount = [0, 0, 0, 0, 0]
              var selectedCharacters: [Character] = []
              selectedCharacters.append(contentsOf: selectCharacters(team: 0))
              selectedCharacters.append(contentsOf: selectCharacters(team: 1))
              selectedCharacters.append(contentsOf: selectCharacters(team: 2))
              selectedCharacters.append(contentsOf: selectCharacters(team: 3))
              selectedCharacters.append(contentsOf: selectCharacters(team: 4))
              // now we have the selected characters
              playersAssignedCharacters = selectedCharacters.shuffled()
              //                print("Selected characters: \(selectedCharacters)")
              let filteredGoodCharacters = playableCharacters.filter { $0.team == "townsfolk" || $0.team == "outsider"}
              // select 3 characters that are not in assigned characters
              let assignedNames = Set(playersAssignedCharacters.map { $0.name })
              let unassignedGoodCharacters = filteredGoodCharacters.filter { !assignedNames.contains($0.name) }
              let selected = Array(unassignedGoodCharacters.shuffled().prefix(3))
              notPresentedGoodCharacters = selected
            }
          }){
            Text("随机分配")
              .font(.system(size: 20,  design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.white)
              .padding(.horizontal, 15)
              .padding(.vertical, 10)
              .background(.orange)
              .cornerRadius(10)
              .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.orange, lineWidth: 2))
          }
          Button(action: {
            if playersAssignedCharacters.count < 5 {
              return
            }
            for (index, character) in playersAssignedCharacters.enumerated() {
              allLogs.append(GameLogEntry(message: "获得角色：\(character.name)", messager: index + 1, source: "说书人", type: 0))
              for reminder in playersStates[index] {
                allLogs.append(GameLogEntry(message: "获得状态：\(reminder.effect)", messager: index + 1, source: reminder.from, type: 1, characterName: character.name))
              }
            }
            for index in 0..<notPresentedGoodCharacters.count{
              allLogs.append(GameLogEntry(message: "\(notPresentedGoodCharacters[index].name)", messager: 0, source: "说书人", type: 13))
            }
            allLogs.append(GameLogEntry(message: "游戏开始", messager: 0, source: "说书人", type: 8, characterName: ""))
            allLogs.append(GameLogEntry(message: "第一夜", messager: 0, source: "说书人", type: 9, characterName: ""))
            if gameState == 0{
              gameState = 1
            }
            showMenu = false
          }){
            Text("开始游戏")
              .font(.system(size: 20,  design: .rounded))
              .fontWeight(.semibold)
              .foregroundColor(.white)
              .padding(.horizontal, 15)
              .padding(.vertical, 10)
              .background(.green)
              .cornerRadius(10)
              .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 2))
          }
        } // end of vstack for menu
        .transition(
          AnyTransition.scale(scale: 0.1, anchor: .bottomLeading)
            .combined(with: .opacity)
        )
        
        Spacer()
      }
    }
  }
}
