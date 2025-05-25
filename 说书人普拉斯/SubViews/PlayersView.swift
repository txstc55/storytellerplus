//
//  PlayersView.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/22/25.
//
import SwiftUI
import Flow

//struct PlayerStatusCard: View{
//  var body: some View{
//
//  }
//}


struct PlayerCard: View {
  let index: Int
  @Binding var playersAssignedCharacters: [Character]
  @Binding var reminders: [Reminder]
  let characters: [Character]
  let gameState: Int
  
  @Binding var currentSelectedPlayerID: Int
  @Binding var selectNewCharacter: Bool
  @Binding var currentSelectedPlayerIDForReminder: Int
  @Binding var selectNewReminder: Bool
  @Binding var selectedReminderIndex: Int
  @Binding var playersIsAlive: [Bool]
  @Binding var playersHasDeathVote: [Bool]
  @Binding var aliveCount: Int
  @Binding var allLogs: [GameLogEntry]
  var teamColorMain: Color {
    let character = playersAssignedCharacters[index]
    if character.team == "minion"{
      return Color.minion
    }else if character.team == "demon"{
      return Color.demon
    } else if character.team == "townsfolk"{
      return Color.townsfolk
    } else if character.team == "outsider"{
      return Color.outsider
    } else if character.team == "traveler"{
      return Color.traveler
    }
    return Color.mainbg
  }
  
  var teamColorSecondary: Color {
    let character = playersAssignedCharacters[index]
    if character.team == "minion"{
      return Color.evilTextBg
    }else if character.team == "demon"{
      return Color.evilTextBg
    }else if character.team == "townsfolk"{
      return Color.goodTextBg
    } else if character.team == "outsider"{
      return Color.goodTextBg
    } else if character.team == "traveler"{
      return Color.goodTextBg
    }
    return Color.black
  }
  
  
  var body: some View {
    let character = playersAssignedCharacters[index]
    VStack(spacing: 0){
      VStack {
        HStack {
          Text("\(index + 1)")
            .font(.system(size: 25, design: .rounded))
            .fontWeight(.black)
            .foregroundColor(teamColorMain)
            .frame(width: 50, height: 50, alignment: .center)
            .background(Circle()
              .fill(teamColorSecondary)
            )
            .overlay(
              Image(systemName: "xmark")
                .font(.system(size: 45, weight: .black))
                .foregroundColor(.demon)
                .opacity(index >= playersIsAlive.count ? 0.0 : (playersIsAlive[index] ? 0.0 : 1))
            )
            .onTapGesture {
              if gameState != 0 {
                withAnimation(.easeInOut(duration: 0.3)) {
                  playersIsAlive[index].toggle()
                }
                
                aliveCount += playersIsAlive[index] ? 1 : -1
                if playersIsAlive[index]{
                  allLogs.append(GameLogEntry(message: "", messager: index + 1, source: "说书人", type: 12, characterName: character.name))
                  playersHasDeathVote[index] = true
                }else{
                  allLogs.append(GameLogEntry(message: "", messager: index + 1, source: "说书人", type: 6, characterName: character.name))
                }
              }
            }
            .padding(.leading, 5)
          Text(character.name)
            .font(.system(size: 24, design: .rounded))
            .fontWeight(.bold)
            .foregroundColor(teamColorSecondary)
            .padding(.horizontal, 5)
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
          CachedImageView(urlString: character.imageURL)
            .frame(width: 50, height: 50)
            .background(Circle()
              .fill(teamColorSecondary)
            )
            .padding(.trailing, 5)
            .onTapGesture {
              currentSelectedPlayerID = index
              selectNewCharacter = true
            }
        }
        .padding(.top, 20)
        Text(character.ability)
          .font(.system(size: 20, design: .rounded))
          .fontWeight(.semibold)
          .foregroundColor(teamColorSecondary.opacity(1))
          .padding(.horizontal, 5)
          .frame(maxHeight: .infinity, alignment: .top)
          .padding(.top, 5)
          .padding(.bottom, 20)
      }// end of the character info view, the next is the reminder/status
      .background(teamColorMain)
      .clipShape(.rect(
        topLeadingRadius: 20,
        bottomLeadingRadius: 0,
        bottomTrailingRadius: 0,
        topTrailingRadius: 20
      )
      )
      .opacity(index >= playersIsAlive.count ? 0.0 : (playersIsAlive[index] ? 1.0 : 0.5))
      HFlow {
        ForEach(reminders.indices, id: \.self) { reminderIndex in
          let reminder = reminders[reminderIndex]
          HStack(spacing: 0) {
            let imageURL = getImageURL(name: reminder.from, characters: characters)
            if !imageURL.isEmpty {
              CachedImageView(urlString: imageURL)
                .frame(width: 35, height: 35)
                .padding(.leading, 5)
                .padding(.trailing, 3)
            }else{
              Color.clear
                .frame(width: 1, height: 35)
                .padding(.leading, 9)
            }
            Text(reminder.effect)
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.black)
              .padding(.trailing, 10)
            //              .padding(.leading, imageURL.isEmpty ? 9 : 0)
            //              .padding(.vertical, 5)
            //              .frame(minHeight: 35)
          }
          .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
          .onTapGesture(count: 2){
            // remove this reminder
            reminders.remove(at: reminderIndex)
            allLogs.append(GameLogEntry(message: "失去标记：\(reminder.effect)", messager: index + 1, source: reminder.from, type: 14, characterName: character.name))
          }
        }
        Button(action: {
          currentSelectedPlayerIDForReminder = index
          selectNewReminder = true
          selectedReminderIndex = -1
        }) {
          Image(systemName: "plus")
            .font(.system(size: 25, weight: .bold))
            .foregroundColor(.black)
            .frame(width: 35, height: 35)
            .overlay(Circle().stroke(Color.black, lineWidth: 3))
        }
      }
      .padding(.top, 10)
      .padding(.horizontal, 5)
      .padding(.bottom, 10)
      .frame(maxWidth: .infinity)
      .background(.mainbg)
      .clipShape(.rect(
        topLeadingRadius: 0,
        bottomLeadingRadius: 20,
        bottomTrailingRadius: 20,
        topTrailingRadius: 0
      )
      )
      .animation(.easeInOut(duration: 0.3), value: reminders.count)
    }
    .frame(maxWidth: .infinity)
  }
}



struct PlayersView: View {
  @Binding var playersAssignedCharacters: [Character]
  @Binding var playersStates: [[Reminder]]
  @Binding var characters: [Character]
  @Binding var currentSelectedPlayerID: Int
  @Binding var selectNewCharacter: Bool
  @Binding var currentSelectedPlayerIDForReminder: Int
  @Binding var selectNewReminder: Bool
  @Binding var selectedReminderIndex: Int
  @Binding var playersIsAlive: [Bool]
  @Binding var playersHasDeathVote: [Bool]
  
  @Binding var aliveCount: Int
  @Binding var gameState: Int
  @Binding var allLogs: [GameLogEntry]
  
  
  var body: some View {
    ForEach(0 ..< Int(ceil(Double(playersAssignedCharacters.count) / 3.0)), id: \.self) { rowIndex in
      HStack{
        ForEach(0 ..< 3, id: \.self) { colIndex in
          let index = rowIndex * 3 + colIndex
          if (index < playersAssignedCharacters.count &&
              index < playersStates.count &&
              index < playersIsAlive.count) {
            PlayerCard(
              index: index,
              playersAssignedCharacters: $playersAssignedCharacters,
              reminders: $playersStates[index],
              characters: characters,
              gameState: gameState,
              currentSelectedPlayerID: $currentSelectedPlayerID,
              selectNewCharacter: $selectNewCharacter,
              currentSelectedPlayerIDForReminder: $currentSelectedPlayerIDForReminder,
              selectNewReminder: $selectNewReminder,
              selectedReminderIndex: $selectedReminderIndex,
              playersIsAlive: $playersIsAlive,
              playersHasDeathVote: $playersHasDeathVote,
              aliveCount: $aliveCount,
              allLogs: $allLogs
            )
            
            .padding(.vertical, 15)
            .padding(.horizontal, 5)
            
          }else{
            Color.clear
              .frame(maxWidth: .infinity)
          }
          
        }
      }
    }
  }
}
