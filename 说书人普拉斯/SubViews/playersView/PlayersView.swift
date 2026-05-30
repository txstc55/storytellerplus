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
  
  @Binding var globalStates: [Reminder]
  
  let numCols: Int
  
  
  var body: some View {
    VStack{
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          VStack{
            Text("全局")
              .font(.system(size: 25, weight: .black, design: .monospaced))
              .padding(.bottom, -5)
            Text("标签")
              .font(.system(size: 25, weight: .black, design: .monospaced))

          }
          .padding(.trailing, 10)
          Color.black
            .frame(width: 4)
            .padding(.vertical, 0)
            .padding(.horizontal, 10)
          
          ForEach(globalStates.indices, id: \.self) { reminderIndex in
            let reminder = globalStates[reminderIndex]
            HStack(spacing: 0) {
              let imageURL = getImageURL(name: reminder.from, characters: characters)
              HStack(spacing: 0){
                if reminder.playerId >= 0 {
                  Text("\(reminder.playerId + 1)")
                    .font(.system(size: 25, design: .rounded))
                    .fontWeight(.black)
                    .foregroundColor(teamid2Color(reminder.team))
                    .frame(minWidth: 25)
                    .frame(height: 50)
//                      .background(Circle().fill(Color.goodTextBg).frame(width: 45, height: 45))
                }
                if !imageURL.isEmpty {
                  CachedImageView(urlString: imageURL)
                    .frame(width: 48, height: 48)
                    .background(Circle().fill(Color.goodTextBg))
                  
                }else{
                  Color.clear
                    .frame(width: 0, height: 48)
                }
              }
              .padding(.leading, (reminder.playerId >= 0) ? 3: 0)
              .background(RoundedRectangle(cornerRadius: 24).fill(Color.goodTextBg))
              .padding(.trailing, (reminder.playerId >= 0 || imageURL != "") ? 2: 0)
              Text(reminder.effect)
                .font(.system(size: 24, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.goodTextBg)
                .padding(.horizontal, 10)
            }
            .frame(minWidth: 50)
            .frame(height: 54)
            .padding(.horizontal, 3)
            .background(RoundedRectangle(cornerRadius: 27)
              .fill(teamid2Color(reminder.team)))
            .rotationEffect(reminder.isReversed ? .degrees(180) : .degrees(0))
            .onTapGesture(count: 2){
              // remove this reminder
              globalStates.remove(at: reminderIndex)
              allLogs.append(GameLogEntry(message: "\(reminder.effect)", messager: -10, source: reminder.from, type: 17, characterName: "全局", playerNumbers: [reminder.playerId], playerCharacters: [reminder.from], playerTeams: [reminder.team]))
            }
            .onLongPressGesture(minimumDuration: 1){
              withAnimation(.easeInOut(duration: 0.3)) {
                globalStates[reminderIndex].isReversed.toggle()
                allLogs.append(GameLogEntry(message: "\(reminder.effect)", messager: -10, source: reminder.from, type: 18, characterName: "全局", playerNumbers: [reminder.playerId], playerCharacters: [reminder.from], playerTeams: [reminder.team]))
              }
            }
          }
          
          Button(action: {
            currentSelectedPlayerIDForReminder = -2
            selectNewReminder = true
            selectedReminderIndex = -1
          }) {
            Image(systemName: "plus")
              .font(.system(size: 35, weight: .bold))
              .foregroundColor(.black)
              .frame(width: 50, height: 50)
              .overlay(Circle().stroke(Color.black, lineWidth: 3))
          }
          .contentShape(Circle())
        }
        .padding(
          .horizontal, 30
        )
        .padding(.vertical, 15)
      }
      .animation(.easeInOut(duration: 0.3), value: globalStates.count)
      .background(.mainbg)
      .overlay(RoundedRectangle(cornerRadius: 50)
        .stroke(Color.black, lineWidth: 8))
      .clipShape(RoundedRectangle(cornerRadius: 50))
      ForEach(0 ..< Int(ceil(Double(playersAssignedCharacters.count) / Double(numCols))), id: \.self) { rowIndex in
        HStack{
          ForEach(0 ..< numCols, id: \.self) { colIndex in
            let index = rowIndex * numCols + colIndex
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
    .animation(.easeInOut(duration: 0.3), value: playersAssignedCharacters.count)
  }
}
