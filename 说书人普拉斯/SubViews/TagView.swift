//
//  TagView.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/22/25.
//

import SwiftUI
import Flow

struct TagView: View{
  @Binding var allReminders: [Reminder]
  @Binding var playersAssignedCharacters: [Character]
  @Binding var playersStates: [[Reminder]]
  @Binding var currentSelectedPlayerIDForReminder: Int
  @Binding var selectNewReminder: Bool
  @Binding var selectedReminderIndex: Int
  @Binding var characters: [Character]
  @Binding var gameState: Int
  @Binding var allLogs: [GameLogEntry]
  @Binding var selectedFabledCharacters: [Character]
  @State private var showTagEditor: Bool = false
  @State private var newTagName: String = ""
  @State private var remindersWithSource: [Reminder] = []
  @State private var newTagSource: Int = 0
  private var allUserIDs: [Int] {
    (0..<(playersAssignedCharacters.count + 1)).map { $0 }
  }
  private var currentSpeaker: String {
    if newTagSource >= 0 && newTagSource < playersAssignedCharacters.count {
      return "\(newTagSource + 1)号 \(playersAssignedCharacters[newTagSource].name)"
    } else {
      return "说书人"
    }
  }
//  var selectedCharacterNames: [String] {
//    playersAssignedCharacters.map { $0.name }
//  }
  var body: some View{
    ZStack{
      Color.mainbg.opacity(0.3)
        .edgesIgnoringSafeArea(.all)
        .zIndex(1)
        .onTapGesture(count: 2){
          withAnimation(.easeInOut(duration: 0.3)) {
            selectNewReminder = false
          }
        }
      if showTagEditor{
        ZStack{
          Color.mainbg.opacity(0.5)
            .edgesIgnoringSafeArea(.all)
          VStack{
            Spacer()
            HStack{
              Text("标签名字： ")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.bold)
              TextField("输入标签名字", text: $newTagName)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(.clear)
                .frame(maxWidth: .infinity)
            }
            HStack{
              Text("标签来源： ")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.bold)
              Picker(selection: $newTagSource, label: Text(currentSpeaker).font(.system(size: 20, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .lineLimit(1)               // <-- Restrict to 1 line
                .truncationMode(.tail)     // <-- Show "..." if needed
              ) {
                ForEach(allUserIDs, id: \.self) { item in
                  Text(item < playersAssignedCharacters.count
                       ? "\(item + 1)号 \(playersAssignedCharacters[item].name)"
                       : "说书人")
                  .font(.system(size: 20, design: .rounded))
                  .fontWeight(.bold)
                  .foregroundColor(.black) // <-- this makes each option black
                  .tag(item)
                }
              }
              .pickerStyle(.menu)
              .frame(maxWidth: .infinity)
            }
            
            Spacer()
            HStack{
              Button(action: {
                if newTagName != ""{
                  let tagSourcePlayerId = (newTagSource >= 0 && newTagSource < playersAssignedCharacters.count) ? newTagSource : -2
                  let tagSourcePlayerName = (newTagSource >= 0 && newTagSource < playersAssignedCharacters.count) ? playersAssignedCharacters[newTagSource].name : "说书人"
                  let tagSourceTeam = (newTagSource >= 0 && newTagSource < playersAssignedCharacters.count) ? team2Int(playersAssignedCharacters[newTagSource].team) : 5
                  let isGlobal = (newTagSource >= playersAssignedCharacters.count)
                  allReminders.append(Reminder(from: tagSourcePlayerName, effect: newTagName, team: tagSourceTeam, isGlobal: isGlobal, playerId: tagSourcePlayerId))
                  remindersWithSource.append(Reminder(from: tagSourcePlayerName, effect: newTagName, team: tagSourceTeam, isGlobal: isGlobal, playerId: tagSourcePlayerId))
                  showTagEditor = false
                  newTagName = ""
                  newTagSource = playersAssignedCharacters.count
                  selectedReminderIndex = remindersWithSource.count - 1
                }
              }){
                Text("确认")
                  .font(.system(size: 15, design: .rounded))
                  .fontWeight(.bold)
                  .foregroundColor(.black)
                  .padding(.horizontal, 20)
                  .padding(.vertical, 8)
                  .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 2))
              }
              Button(action: {
                showTagEditor = false
              }){
                Text("取消")
                  .font(.system(size: 15, design: .rounded))
                  .fontWeight(.bold)
                  .foregroundColor(.black)
                  .padding(.horizontal, 20)
                  .padding(.vertical, 8)
                  .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 2))
              }
              
            }
            .padding(.bottom, 10)
          }
          .padding(.horizontal, 20)
          .frame(width: 300, height: 300)
          .background(.goodTextBg)
          .cornerRadius(20)
          .overlay(
            RoundedRectangle(cornerRadius: 20)
              .stroke(Color.black, lineWidth: 3)
          )
        }
        .zIndex(3)
      }
      
      VStack{
        ScrollView{
          HStack{
            Text("为\(currentSelectedPlayerIDForReminder + 1)号玩家选择标记")
              .font(.system(size: 25, design: .rounded))
              .fontWeight(.bold)
          }
          .padding(.top, 25)
          .frame(maxWidth: .infinity)
          HFlow(itemSpacing: 15){
//            let selectedCharacterNames = playersAssignedCharacters.map { $0.name } // compute once
//            let selectedFabledCharacterNames = selectedFabledCharacters.map { $0.name }
            ForEach(remindersWithSource.indices, id: \.self){index in
              let reminder = remindersWithSource[index]
              HStack(spacing: 0){
                let imageURL = getImageURL(name: reminder.from, characters: characters)
                HStack(spacing: 0){
                  if reminder.playerId >= 0 {
                    Text("\(reminder.playerId + 1)")
                      .font(.system(size: 18, design: .rounded))
                      .fontWeight(.black)
                      .foregroundColor(teamid2Color(reminder.team))
                      .frame(minWidth: 30)
                      .frame(height: 45)
//                      .background(Circle().fill(Color.goodTextBg).frame(width: 45, height: 45))
                  }
                  if (imageURL != ""){
                    CachedImageView(urlString: getImageURL(name: reminder.from, characters: characters))
                      .frame(width: 43, height: 43)
                      .background(Circle().fill(Color.goodTextBg))
                  }else{
                    Color.clear
                      .frame(width: 0, height: 45)
                  }
                }
                .padding(.leading, (reminder.playerId >= 0) ? 5: 0)
                .background(RoundedRectangle(cornerRadius: 30).fill(Color.goodTextBg))
                .padding(.trailing, (reminder.playerId >= 0 || imageURL != "") ? 10: 0)
                
                //                .padding(.vertical, 5)
                Text(reminder.effect)
                  .font(.system(size: 18, design: .rounded))
                  .fontWeight(.bold)
                  .foregroundColor(.goodTextBg)
                  .padding(.vertical, 5)
                  .padding(.horizontal, 5)
              }
              .frame(minWidth: 70)
              .frame(height: 55)
              .padding(.horizontal, 5)
              .background(RoundedRectangle(cornerRadius: 40)
                .fill(teamid2Color(reminder.team)))
              .onTapGesture {
                selectedReminderIndex = index
              }
              .scaleEffect(selectedReminderIndex == index ? 1.05 : 0.93)
              .animation(.easeInOut(duration: 0.3), value: selectedReminderIndex)
            }
            Button(action: {
              showTagEditor = true
            }){
              Image(systemName: "plus")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundColor(.black)
                .frame(width: 50, height: 50) // This defines the container size
                .overlay(
                  Circle()
                    .stroke(Color.black, lineWidth: 3)
                )
            }
            .scaleEffect(0.9)
            .contentShape(Circle())
            
          }
//          .animation(.easeInOut(duration: 0.3), value: selectedCharacterNames)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal, 20)
          //      .frame(maxWidth: .infinity)
          
        }
        Spacer()
        HStack{
          Button(action: {
            selectNewReminder = false
            if selectedReminderIndex >= 0 {
              let selectedReminder = remindersWithSource[selectedReminderIndex]
              playersStates[currentSelectedPlayerIDForReminder].append(selectedReminder)
              if gameState != 0 {
                let selectedCharacter = playersAssignedCharacters[currentSelectedPlayerIDForReminder]
                allLogs.append(GameLogEntry(message: "\(selectedReminder.effect)", messager: currentSelectedPlayerIDForReminder + 1, source: selectedReminder.from, type: 1, characterName: selectedCharacter.name, playerNumbers: [selectedReminder.playerId], playerCharacters: [selectedCharacter.name, selectedReminder.from], playerTeams: [team2Int(selectedCharacter.team), selectedReminder.team]))
              }
            }
          }) {
            Text("确认")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.black)
              .padding(.horizontal, 20)
              .padding(.vertical, 8)
              .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 2))
          }
          .padding(.horizontal, 30)
          .padding(.vertical, 20)
          
          Button(action: {
            selectNewReminder = false
          }) {
            Text("返回")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.black)
              .padding(.horizontal, 20)
              .padding(.vertical, 8)
              .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 2))
          }
          .padding(.horizontal, 30)
          .padding(.vertical, 20)
        }
      } // end of vstack
      .zIndex(2)
      .background(Color.mainbg)
      .cornerRadius(20)
      .frame(width: 600)
      .overlay(
        RoundedRectangle(cornerRadius: 20)
          .stroke(Color.black, lineWidth: 3)
      )
      .padding(.vertical, 50)
    } // end of zstack
    .animation(.easeInOut(duration: 0.3), value: showTagEditor)
    .onAppear(){
      newTagSource = playersAssignedCharacters.count
      // we compute the actual reminders with source
      let selectedFabledCharacterNames = selectedFabledCharacters.map { $0.name }
  //    let selectedCharacterNames = playersAssignedCharacters.map { $0.name } // compute once
      for i in 0..<allReminders.count {
        let reminder = allReminders[i]
        if (reminder.isGlobal){
          remindersWithSource.append(reminder)
        }else if (reminder.playerId == -2 && selectedFabledCharacterNames.contains(reminder.from)){
          remindersWithSource.append(reminder)
        }else{
          // search the players assigned characters
          // if there are multiple same characters, add the tag with different source
          if (reminder.playerId == -1){
            // we gotta check who's the correct one
            for j in 0..<playersAssignedCharacters.count {
              if reminder.from == playersAssignedCharacters[j].name{
                // create a new copy of reminder with source
                let newReminder = Reminder(from: reminder.from, effect: reminder.effect, team: reminder.team, isGlobal: reminder.isGlobal, playerId: j)
                remindersWithSource.append(newReminder)
              }
            }
          }else if (reminder.playerId >= 0){
            // else we just add the reminder with the correct source
            remindersWithSource.append(reminder)
            for j in 0..<playersAssignedCharacters.count {
              if (reminder.from == playersAssignedCharacters[j].name && j != reminder.playerId) {
                // create a new copy of reminder with source
                let newReminder = Reminder(from: reminder.from, effect: reminder.effect, team: reminder.team, isGlobal: reminder.isGlobal, playerId: j)
                remindersWithSource.append(newReminder)
              }
            }
          }
        }
      }
    }
  }
}

//#Preview{
//  TagView(allReminders: .constant([]), playersAssignedCharacters: .constant([]), playersStates: .constant([[]]), currentSelectedPlayerIDForReminder: .constant(0), selectNewReminder: .constant(true), selectedReminderIndex: .constant(0), characters: .constant([]))
//
//}

