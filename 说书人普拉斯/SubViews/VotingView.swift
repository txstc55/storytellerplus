//
//  VotingView.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/23/25.
//


import SwiftUI
import Flow
struct VotingView: View{
  @State private var votingPhase: Int = 0
  @State private var executionPlayerIndex: [Int] = []
  @State private var executionVoteCount: [[Int]] = []
  @State private var nominatorIndex: Int = -1
  @State private var nominatedIndex: Int = -1
  @State private var nominationVotes: [Int] = []
  @State private var aliveCountAtVote: [Int] = []
  @State private var playerCountAtVote: [Int] = []
  @State private var nominationPhase: Int = 0
  @Binding var playersAssignedCharacters: [Character]
  @Binding var playerCount: Int
  @Binding var aliveCount: Int
  @Binding var playersIsAlive: [Bool]
  @Binding var playersHasDeathVote: [Bool]
  @Binding var allLogs: [GameLogEntry]
  
  func getBgColorBasedOnTeam(team: String) -> Color {
    switch team {
    case "townsfolk":
      return Color.townsfolk
    case "outsider":
      return Color.outsider
    case "minion":
      return Color.minion
    case "demon":
      return Color.demon
    case "traveler":
      return Color.traveler
    default:
      return Color.mainbg
    }
  }
  func getFgColorBasedOnTeam(team: String) -> Color {
    switch team {
    case "townsfolk":
      return Color.goodTextBg
    case "outsider":
      return Color.goodTextBg
    case "minion":
      return Color.evilTextBg
    case "demon":
      return Color.evilTextBg
    case "traveler":
      return Color.goodTextBg
    default:
      return Color.black
    }
  }
  
  
  
  var body: some View{
    VStack{
      if votingPhase == 0{
        ScrollView{
          Text(nominationPhase == 0 ? "选择提名者": "选择被提名者")
            .font(.system(size: 25, design: .monospaced))
            .fontWeight(.bold)
            .padding(.top, 10)
          let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 5)
          LazyVGrid(columns: columns, spacing: 20){
            ForEach(0...playerCount, id: \.self) { index in
              Group{
                if index < playerCount{
                  let playerBg = getBgColorBasedOnTeam(team: playersAssignedCharacters[index].team)
                  let playerFg = getFgColorBasedOnTeam(team: playersAssignedCharacters[index].team)
                  Text("\(index + 1)")
                    .frame(width: 40, height: 40)
                    .background(playerBg)
                    .foregroundColor(playerFg)
                    .clipShape(Circle())
                    .opacity(playersIsAlive[index] ? 1 : 0.5)
                }else{
                  Text("说")
                    .frame(width: 40, height: 40)
                    .overlay(Circle().stroke(Color.black, lineWidth: 2))
                }
              }
              .font(.system(size: 20, design: .monospaced))
              .fontWeight(.bold)
              .scaleEffect(index < playerCount ? (index == (nominationPhase == 0 ? nominatorIndex : nominatedIndex) ? 1.2 : 1) : ((nominationPhase == 0 ? nominatorIndex : nominatedIndex) == 21 ? 1.2 : 1))
              .frame(maxWidth: .infinity)
              .onTapGesture{
                if index < playerCount{
                  if nominationPhase == 0{
                    nominatorIndex = index
                  }else{
                    nominatedIndex = index
                  }
                }else{
                  if nominationPhase == 0{
                    nominatorIndex = 21 // lets do 21 for storyteller
                  }else{
                    nominatedIndex = 21
                  }
                }
              }
            }
          }
          .padding(.horizontal, 5)
        }
        Spacer()
        HStack{
          if nominationPhase == 0{
            Button(action: {
              if nominatorIndex != -1{
                nominationPhase = 1
              }
            }){
              Text("确认")
                .font(.system(size: 20, design: .monospaced))
                .fontWeight(.bold)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .foregroundColor(.black)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
            }
          }else{
            Button(action: {
              nominationPhase = 0
            }){
              Text("返回")
                .font(.system(size: 20, design: .monospaced))
                .fontWeight(.bold)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .foregroundColor(.black)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
            }
            .frame(maxWidth: .infinity)
            Button(action: {
              nominationPhase = 0
              if nominatedIndex != -1{
                votingPhase = 1
              }
            }){
              Text("确认")
                .font(.system(size: 20, design: .monospaced))
                .fontWeight(.bold)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .foregroundColor(.black)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
            }
            .frame(maxWidth: .infinity)
          }
        }
        .padding(.bottom, 10)
        .animation(.easeInOut(duration: 0.3), value: nominationPhase)
        .animation(.easeInOut(duration: 0.3), value: votingPhase)
        .animation(.easeInOut(duration: 0.3), value: nominatorIndex)
        .animation(.easeInOut(duration: 0.3), value: nominatedIndex)
      }else if votingPhase == 1{
        ScrollView{
          let trueNominatorText = nominatorIndex < playerCount ? "\(nominatorIndex + 1)" : "说"
          let trueNominatedText = nominatedIndex < playerCount ? "\(nominatedIndex + 1)" : "说"
          let neededVotes: Int = Int(ceil(Double(aliveCount) / 2.0))
          Text("\(trueNominatorText)提\(trueNominatedText)，\(neededVotes)票过半")
            .font(.system(size: 25, design: .monospaced))
            .fontWeight(.bold)
            .padding(.top, 10)
          let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 5)
          HStack{
            Rectangle()
              .fill(Color.black)
              .frame(height: 2)
            Text("存活")
              .font(.system(size: 20, design: .monospaced))
              .fontWeight(.bold)
            Rectangle()
              .fill(Color.black)
              .frame(height: 2)
          }
          LazyVGrid(columns: columns, spacing: 20){
            ForEach(0..<playerCount, id: \.self) { index in
              if (playersIsAlive[index]){
                let trueIndex = index < playerCount ? index : (21 + index - playerCount)
                let name = "\(index + 1)"
                let playerBg = getBgColorBasedOnTeam(team: playersAssignedCharacters[index].team)
                let playerFg = getFgColorBasedOnTeam(team: playersAssignedCharacters[index].team)
                Text(name)
                  .font(.system(size: 20, design: .monospaced))
                  .fontWeight(.bold)
                  .foregroundColor(playerFg)
                  .frame(width: 40, height: 40)
                  .background(playerBg)
                  .clipShape(Circle())
                  .scaleEffect(nominationVotes.contains(trueIndex) ? 1.2 : 1)
                  .frame(maxWidth: .infinity)
                  .opacity(nominationVotes.contains(trueIndex) ? 1 : 0.5)
                  .onTapGesture{
                    //                  let trueIndex = index < playerCount ? index : 21
                    if nominationVotes.contains(trueIndex){
                      nominationVotes.removeAll(where: {$0 == trueIndex})
                    }else{
                      nominationVotes.append(trueIndex)
                    }
                  }
              }
            }
          }
          .padding(.horizontal, 5)
          
          HStack{
            Rectangle()
              .fill(Color.black)
              .frame(height: 2)
            Text("死亡")
              .font(.system(size: 20, design: .monospaced))
              .fontWeight(.bold)
            Rectangle()
              .fill(Color.black)
              .frame(height: 2)
          }
          LazyVGrid(columns: columns, spacing: 20){
            ForEach(0..<playerCount, id: \.self) { index in
              if (!playersIsAlive[index] && playersHasDeathVote[index]){
                let trueIndex = index
                let name = "\(index + 1)"
                let playerBg = getBgColorBasedOnTeam(team: playersAssignedCharacters[index].team)
                let playerFg = getFgColorBasedOnTeam(team: playersAssignedCharacters[index].team)
                Text(name)
                  .font(.system(size: 20, design: .monospaced))
                  .fontWeight(.bold)
                  .foregroundColor(playerFg)
                  .frame(width: 40, height: 40)
                  .background(playerBg)
                  .clipShape(Circle())
                  .scaleEffect(nominationVotes.contains(trueIndex) ? 1.2 : 1)
                  .frame(maxWidth: .infinity)
                  .opacity(nominationVotes.contains(trueIndex) ? 1 : 0.5)
                  .onTapGesture{
                    //                  let trueIndex = index < playerCount ? index : 21
                    if nominationVotes.contains(trueIndex){
                      nominationVotes.removeAll(where: {$0 == trueIndex})
                    }else{
                      nominationVotes.append(trueIndex)
                    }
                  }
              }
            }
          }
          .padding(.horizontal, 5)
          HStack{
            Rectangle()
              .fill(Color.black)
              .frame(height: 2)
            Text("无票")
              .font(.system(size: 20, design: .monospaced))
              .fontWeight(.bold)
            Rectangle()
              .fill(Color.black)
              .frame(height: 2)
          }
          LazyVGrid(columns: columns, spacing: 20){
            ForEach(0..<playerCount, id: \.self) { index in
              if (!playersIsAlive[index] && !playersHasDeathVote[index]){
                let trueIndex = index
                let name = "\(index + 1)"
                let playerBg = getBgColorBasedOnTeam(team: playersAssignedCharacters[index].team)
                let playerFg = getFgColorBasedOnTeam(team: playersAssignedCharacters[index].team)
                Text(name)
                  .font(.system(size: 20, design: .monospaced))
                  .fontWeight(.bold)
                  .foregroundColor(playerFg)
                  .frame(width: 40, height: 40)
                  .background(playerBg)
                  .clipShape(Circle())
                  .scaleEffect(nominationVotes.contains(trueIndex) ? 1.2 : 1)
                  .frame(maxWidth: .infinity)
                  .opacity(nominationVotes.contains(trueIndex) ? 1 : 0.5)
                  .onTapGesture{
                    //                  let trueIndex = index < playerCount ? index : 21
                    if nominationVotes.contains(trueIndex){
                      nominationVotes.removeAll(where: {$0 == trueIndex})
                    }else{
                      nominationVotes.append(trueIndex)
                    }
                  }
              }
            }
          }
          .padding(.horizontal, 5)
          HStack{
            Rectangle()
              .fill(Color.black)
              .frame(height: 2)
            Text("特殊")
              .font(.system(size: 20, design: .monospaced))
              .fontWeight(.bold)
            Rectangle()
              .fill(Color.black)
              .frame(height: 2)
          }
          LazyVGrid(columns: columns, spacing: 20){
            ForEach(0..<6, id: \.self) { index in
              let trueIndex = 21 + index
              let name = trueIndex == 21 ? "说" : (trueIndex < 25 ? "票" : "负")
              Text(name)
                .font(.system(size: 20, design: .monospaced))
                .fontWeight(.bold)
                .frame(width: 40, height: 40)
                .overlay(Circle().stroke(Color.black, lineWidth: 2))
                .scaleEffect(nominationVotes.contains(trueIndex) ? 1.2 : 1)
                .frame(maxWidth: .infinity)
                .opacity(nominationVotes.contains(trueIndex) ? 1 : 0.5)
                .onTapGesture{
                  //                  let trueIndex = index < playerCount ? index : 21
                  if nominationVotes.contains(trueIndex){
                    nominationVotes.removeAll(where: {$0 == trueIndex})
                  }else{
                    nominationVotes.append(trueIndex)
                  }
                }
            }
          }
          .padding(.horizontal, 5)
        }
        Spacer()
        HStack{
          Button(action: {
            let nominationVotesNames = nominationVotes.map { $0 < playerCount ? "\($0 + 1) 号玩家" : ($0 == 21 ? "说书人" : ($0 < 25 ? "额外票": "负票")) }
            let logMessage = "提名了\(nominatedIndex < playerCount ? " \(nominatedIndex + 1)号玩家 \(playersAssignedCharacters[nominatedIndex].name)" : "说书人")，投票玩家为：\(nominationVotesNames.joined(separator: " "))"
            executionPlayerIndex.append(nominatedIndex)
            executionVoteCount.append(nominationVotes)
            aliveCountAtVote.append(aliveCount)
            playerCountAtVote.append(playerCount)
            allLogs.append(GameLogEntry(message: logMessage, messager: nominatorIndex < playerCount ? (nominatorIndex + 1): 0, source: nominatorIndex < playerCount ? playersAssignedCharacters[nominatorIndex].name : "说书人", type: 4, characterName: nominatorIndex < playerCount ? playersAssignedCharacters[nominatorIndex].name : "说书人"))
            for vote in nominationVotes {
              if vote < playersIsAlive.count && !playersIsAlive[vote] {
                playersHasDeathVote[vote] = false
              }
            }
            nominatedIndex = -1
            nominatorIndex = -1
            nominationVotes = []
            votingPhase = 2
          }){
            Text("投票")
              .font(.system(size: 20, design: .monospaced))
              .fontWeight(.bold)
              .padding(.horizontal, 10)
              .padding(.vertical, 5)
              .foregroundColor(.black)
              .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
          }
        }
      }else{
        ScrollView{
          ForEach(executionPlayerIndex.indices, id: \.self) { index in
            let playerIndex = executionPlayerIndex[index]
            let voteCount = executionVoteCount[index]
            let aliveCount = aliveCountAtVote[index]
            let playerCount = playerCountAtVote[index]
            //            let imageURL = playerIndex < 20 ? playersAssignedCharacters[playerIndex].imageURL : ""
            VStack(alignment: .leading){
              HStack{
                let totalVotes = voteCount.filter({$0 < 25}).count - voteCount.filter({$0 >= 25}).count
                Text(playerIndex < 20 ? "\(playerIndex + 1)号玩家" : "说书人")
                  .font(.system(size: 20, design: .monospaced))
                  .fontWeight(.bold)
                Spacer()
                Text("\(totalVotes) / \(aliveCount) / \(playerCount)")
                  .font(.system(size: 15, design: .monospaced))
                  .fontWeight(.semibold)
              }
              
              HFlow(spacing: 5){
                ForEach(voteCount, id: \.self) { voter in
                  Text(voter < 20 ? "\(voter + 1)" : (voter == 21 ? "说" : (voter < 25 ? "票" : "负")))
                    .font(.system(size: 15, design: .monospaced))
                    .fontWeight(.semibold)
                    .frame(width: 30, height: 30)
                    .overlay(Circle().stroke(Color.black, lineWidth: 2))
                }
              }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 10)
            .padding(.horizontal, 5)
          }
          Spacer()
        }
      }
      
      HStack(spacing: 0){
        Text("提名")
          .font(.system(size: 20, design: .monospaced))
          .fontWeight(.bold)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 10)
          .opacity(votingPhase == 0 ? 1 : 0.5)
          .border(width: 3, edges: [.top], color: .black)
          .border(width: 1.5, edges: [.trailing], color: .black)
          .onTapGesture {
            votingPhase = 0
            //            nominatorIndex = -1
            //            nominatedIndex = -1
            //            nominationVotes = []
          }
        Text("投票")
          .font(.system(size: 20, design: .monospaced))
          .fontWeight(.bold)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 10)
          .opacity(votingPhase == 1 ? 1 : 0.5)
          .border(width: 3, edges: [.top], color: .black)
          .border(width: 1.5, edges: [.trailing, .leading], color: .black)
        
        //          .onTapGesture {
        //            votingPhase = 1
        //          }
        Text("处决台")
          .font(.system(size: 20, design: .monospaced))
          .fontWeight(.bold)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 10)
          .opacity(votingPhase == 2 ? 1 : 0.5)
          .border(width: 3, edges: [.top], color: .black)
          .border(width: 1.5, edges: [.leading], color: .black)
          .onTapGesture {
            votingPhase = 2
          }
      }
    }
    .animation(.easeInOut(duration: 0.3), value: votingPhase)
    .animation(.easeInOut(duration: 0.3), value: executionPlayerIndex)
    .animation(.easeInOut(duration: 0.3), value: executionVoteCount)
    .animation(.easeInOut(duration: 0.3), value: nominatorIndex)
    .animation(.easeInOut(duration: 0.3), value: nominatedIndex)
    .animation(.easeInOut(duration: 0.3), value: nominationVotes)
  }
}
