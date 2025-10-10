//
//  SaveConversation.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 7/17/25.
//
import SwiftUI
import Flow

struct ConversationLogViewFixed: View{
  let playersAssignedCharacters: [Character]
  let allLogs: [GameLogEntry]
  let start: Int
  let end: Int
  var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      ForEach(start...end, id: \.self) { index in
        let entry = allLogs[index]
        let type = entry.type
        if type == 0 {
          // MARK: 0 for character assignment
          HStack{
            // this is assigning character
            playerNumberCircle(playerNumber: entry.messager, playerTeam: entry.playerTeams[0])
            HStack(spacing: 2){
              Text("获得角色: ")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.black)
              playerCharacterBox(playerCharacter: entry.playerCharacters[0], playerTeam: entry.playerTeams[0])
            }
            .padding(.horizontal, 10)
            .frame(minHeight: 50)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.vertical, 3)
        }else if type == 1 {
          // MARK: 1 for tag assignment
          HStack{
            playerNumberCircle(playerNumber: entry.messager, playerTeam: entry.playerTeams[0])
            playerCharacterBox(playerCharacter: entry.playerCharacters[0], playerTeam: entry.playerTeams[0])
            HStack(spacing: 2){
              Text("获得标签: ")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.black)
              +
              Text("\(entry.message)")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(teamid2Color(entry.playerTeams[1]))
              +
              Text("，来源为：")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.black)
              if (entry.playerNumbers.count > 0 && entry.playerNumbers[0] >= 0){
                playerNumberCircle(playerNumber: entry.playerNumbers[0] + 1, playerTeam: entry.playerTeams[1])
              }
              playerCharacterBox(playerCharacter: entry.playerCharacters[1], playerTeam: entry.playerTeams[1])
            }
            .padding(.horizontal, 10)
            .frame(minHeight: 50)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.vertical, 3)
        }else if type == 2{
          // MARK: 2 for character wake up
          if entry.messager < 0 {
            HStack(spacing: 4){
              playerCharacterBox(playerCharacter: entry.characterName, playerTeam: entry.playerTeams[0])
              Text("被唤醒了")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.horizontal, 5)
                .padding(.vertical, 5)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .border(width: 2, edges: [.top, .bottom], color: .black)
            .padding(.vertical, 5)
          }else{
            HStack(spacing: 4){
              playerNumberCircle(playerNumber: entry.messager, playerTeam: entry.playerTeams[0])
              playerCharacterBox(playerCharacter: entry.characterName, playerTeam: entry.playerTeams[0])
              Text("被唤醒了")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.horizontal, 5)
                .padding(.vertical, 5)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .border(width: 2, edges: [.top, .bottom], color: .black)
            .padding(.vertical, 10)
          }
        }else if type == 3{
          // MARK: 3 for player message
          let isPlayer = (entry.messager) < playersAssignedCharacters.count
          if isPlayer{
            HStack{
              playerNumberCircle(playerNumber: entry.messager, playerTeam: entry.playerTeams[0])
              playerCharacterBox(playerCharacter: entry.playerCharacters[0], playerTeam: entry.playerTeams[0])
              Text(entry.message)
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding(.horizontal, 10)
                .frame(minHeight: 50)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 3)
          }else{
            HStack{
              Text(entry.message)
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding(.horizontal, 10)
                .frame(minHeight: 50)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
              playerNumberCircle(playerNumber: 21, playerTeam: 5) // 说书人
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.vertical, 3)
          }
          
        }else if type == 4{
          // MARK: 4 for nomination
          HFlow(itemSpacing: 2){
            let isPlayer = (entry.messager) < 21
            if isPlayer{
              playerNumberCircle(playerNumber: entry.messager, playerTeam: entry.playerTeams[0])
              Text("号玩家")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.horizontal, 5)
                .padding(.vertical, 5)
            }
            playerCharacterBox(playerCharacter: entry.characterName, playerTeam: entry.playerTeams[0])
            Text("提名了")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.black)
              .padding(.horizontal, 5)
              .padding(.vertical, 5)
            if entry.playerTeams[1] != 5{
              playerNumberCircle(playerNumber: entry.playerNumbers[1], playerTeam: entry.playerTeams[1])
              Text("号玩家")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.horizontal, 5)
                .padding(.vertical, 5)
            }
            playerCharacterBox(playerCharacter: entry.playerCharacters[1], playerTeam: entry.playerTeams[1])
          }
          .padding()
          .frame(maxWidth: .infinity)
          .border(width: 2, edges: [.top, .bottom], color: .black)
          .padding(.vertical, 5)
        }else if type == 5{
          // MARK: 5 for voting
          HFlow(itemSpacing: 2){
            Text("投票结果: ")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.black)
              .padding(.horizontal, 5)
              .padding(.vertical, 5)
            ForEach(entry.playerNumbers.indices, id: \.self) { i in
              let playerNumber = entry.playerNumbers[i]
              let playerCharacter = entry.playerCharacters[i]
              let playerTeam = entry.playerTeams[i]
              if playerNumber < 21 {
                playerNumberCircle(playerNumber: playerNumber, playerTeam: playerTeam)
                playerCharacterBox(playerCharacter: playerCharacter, playerTeam: playerTeam)
              }else{
                playerCharacterBox(playerCharacter: playerCharacter, playerTeam: playerTeam)
              }
              if i < entry.playerNumbers.count - 1 {
                Text(", ")
                  .font(.system(size: 20, design: .rounded))
                  .fontWeight(.bold)
                  .foregroundColor(.black)
                  .padding(.horizontal, 5)
                  .padding(.vertical, 5)
              }
            }
          }
          .padding()
          .frame(maxWidth: .infinity)
          .border(width: 2, edges: [.top, .bottom], color: .black)
          .padding(.vertical, 5)
        }else if type == 6{
          // MARK: 6 for death
          HStack{
            playerNumberCircle(playerNumber: entry.playerNumbers[0], playerTeam: entry.playerTeams[0])
            playerCharacterBox(playerCharacter: entry.playerCharacters[0], playerTeam: entry.playerTeams[0])
            Text("死亡")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.red)
              .padding(.horizontal, 5)
              .padding(.vertical, 5)
          }
          .padding()
          .frame(maxWidth: .infinity)
          .border(width: 2, edges: [.top, .bottom], color: .black)
          .padding(.vertical, 5)
        }else if type == 7{
          // MARK: 7 for player enter game
          HStack{
            Text("\(entry.playerNumbers[0])")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.semibold)
              .foregroundColor(.black)
              .frame(width: 40, height: 40)
              .overlay(Circle().stroke(Color.black, lineWidth: 2))
              .padding(.horizontal, 2)
            HStack(spacing: 2){
              Text("进入游戏")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.horizontal, 10)
                .frame(minHeight: 40)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
            }
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.vertical, 5)
        }else if type == 8{
          HStack{
            Text("游戏开始")
              .font(.system(size: 30, design: .rounded))
              .fontWeight(.black)
              .foregroundColor(.black)
              .padding(.horizontal, 2)
              .padding(.vertical, 10)
          }
          .frame(maxWidth: .infinity)
          .border(width: 3, edges: [.top, .bottom], color: .black)
          .padding(.vertical, 15)
        }else if type == 9 {
          HStack{
            Text("进入第1个夜晚")
              .font(.system(size: 30, design: .rounded))
              .fontWeight(.black)
              .foregroundColor(.black)
              .padding(.horizontal, 2)
              .padding(.vertical, 10)
          }
          .frame(maxWidth: .infinity)
          .border(width: 3, edges: [.top, .bottom], color: .black)
          .padding(.vertical, 15)
        }else if type == 10 {
          HStack{
            let dayCount = allLogs.prefix(index + 1).filter { $0.type == 10 }.count
            Text("进入第\(dayCount)个白天")
              .font(.system(size: 30, design: .rounded))
              .fontWeight(.black)
              .foregroundColor(.black)
              .padding(.horizontal, 2)
              .padding(.vertical, 10)
          }
          .frame(maxWidth: .infinity)
          .border(width: 3, edges: [.top, .bottom], color: .black)
          .padding(.vertical, 15)
        }else if type == 11{
          HStack{
            let nightCount = allLogs.prefix(index + 1).filter { $0.type == 11 }.count
            Text("进入第\(nightCount+1)个夜晚")
              .font(.system(size: 30, design: .rounded))
              .fontWeight(.black)
              .foregroundColor(.black)
              .padding(.horizontal, 2)
              .padding(.vertical, 10)
          }
          .frame(maxWidth: .infinity)
          .border(width: 3, edges: [.top, .bottom], color: .black)
          .padding(.vertical, 15)
        }else if type == 12{
          // MARK: 12 for revival
          HStack{
            playerNumberCircle(playerNumber: entry.playerNumbers[0], playerTeam: entry.playerTeams[0])
            playerCharacterBox(playerCharacter: entry.playerCharacters[0], playerTeam: entry.playerTeams[0])
            Text("复活")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.green)
              .padding(.horizontal, 5)
              .padding(.vertical, 5)
          }
          .padding()
          .frame(maxWidth: .infinity)
          .border(width: 2, edges: [.top, .bottom], color: .black)
          .padding(.vertical, 5)
        }else if type == 13{
          // MARK: 13 for cover for demon
          HStack(spacing: 2){
            Text("恶魔得知伪装: ")
              .font(.system(size: 25, design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.black)
              .padding(.horizontal, 2)
              .padding(.vertical, 10)
            playerCharacterBox(playerCharacter: entry.playerCharacters[0], playerTeam: entry.playerTeams[0])
          }
          .frame(maxWidth: .infinity)
          .border(width: 3, edges: [.top, .bottom], color: .black)
          .padding(.vertical, 10)
        }else if type == 14{
          // MARK: 14 for removing tags
          HStack{
            playerNumberCircle(playerNumber: entry.messager, playerTeam: entry.playerTeams[0])
            playerCharacterBox(playerCharacter: entry.playerCharacters[0], playerTeam: entry.playerTeams[0])
            HStack(spacing: 2){
              Text("失去标签: ")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.black)
              +
              Text("\(entry.message)")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(teamid2Color(entry.playerTeams[1]))
              +
              Text("，来源为：")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.black)
              playerCharacterBox(playerCharacter: entry.playerCharacters[1], playerTeam: entry.playerTeams[1])
            }
            .padding(.horizontal, 10)
            .frame(minHeight: 50)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.vertical, 3)
        }else if type == 15{
          // MARK: 15 for inversing tags
          HStack{
            playerNumberCircle(playerNumber: entry.messager, playerTeam: entry.playerTeams[0])
            playerCharacterBox(playerCharacter: entry.playerCharacters[0], playerTeam: entry.playerTeams[0])
            HStack(spacing: 2){
              Text("倒置标签: ")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.black)
              +
              Text("\(entry.message)")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(teamid2Color(entry.playerTeams[1]))
              +
              Text("，来源为：")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.black)
              playerCharacterBox(playerCharacter: entry.playerCharacters[1], playerTeam: entry.playerTeams[1])
            }
            .padding(.horizontal, 10)
            .frame(minHeight: 50)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.vertical, 3)
        }
      }
    }
    .background(Color.mainbg)
    .padding(.vertical, 20)
  }
}


@MainActor func exportGameLog(width: CGFloat, playersAssignedCharacters: [Character], allLogs: [GameLogEntry]){
  for start in stride(from: 0, to: allLogs.count, by: 40) {
    let end = min(start + 40, allLogs.count) - 1
    
    // Now you can pass start & end into your view
    let captureView = ConversationLogViewFixed(
      playersAssignedCharacters: playersAssignedCharacters,
      allLogs: allLogs,
      start: start,
      end: end
    )
      .frame(width: width)
    
    let renderer = ImageRenderer(content: captureView)
    renderer.scale = UIScreen.main.scale
    
    if let image = renderer.uiImage {
      UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
      print("✅ Saved logs \(start)...\(end)")
    } else {
      print("❌ Failed to render logs \(start)...\(end)")
    }
  }
}
