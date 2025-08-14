//
//  OrderView.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/22/25.
//

import SwiftUI

struct OrderView: View {
  @Binding var playersAssignedCharacters: [Character]
  @Binding var playableCharacters: [Character]
  @Binding var playersIsAlive: [Bool]
  @Binding var firstNightOrder: Bool
  @Binding var currentlyAwakePlayerIndex: Int
  @Binding var allLogs: [GameLogEntry]
  var body: some View {
    VStack{
      HStack(spacing: 0){
        Text("第一晚")
          .font(.system(size: 20, design: .rounded))
          .fontWeight(.bold)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 10)
          .opacity(firstNightOrder ? 1 : 0.5)
          .border(width: 3, edges: [.bottom], color: .black)
          .border(width: 1.5, edges: [.trailing], color: .black)
          .onTapGesture {
            currentlyAwakePlayerIndex = -666
            firstNightOrder = true
          }
        
        Text("其他晚")
          .font(.system(size: 20, design: .rounded))
          .fontWeight(.bold)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 10)
          .opacity(firstNightOrder ? 0.5 : 1)
          .border(width: 3, edges: [.bottom], color: .black)
          .border(width: 1.5, edges: [.leading], color: .black)
          .onTapGesture {
            currentlyAwakePlayerIndex = -666
            firstNightOrder = false
          }
      }

      
      let assignedNames = Set(playersAssignedCharacters.map { $0.name })
      let unassignedCharacters = playableCharacters.filter { !assignedNames.contains($0.name) && $0.team != "traveler" }
      let unassignedCharacterNames = Set(unassignedCharacters.map { $0.name })
      let combined = playersAssignedCharacters
        .enumerated()
        .filter { firstNightOrder ? ($0.element.firstNightOrder != 0) : ($0.element.otherNightOrder != 0) }
        .map {
          OrderInfo(
            order: firstNightOrder ? $0.element.firstNightOrder : $0.element.otherNightOrder,
            reminder: firstNightOrder ? $0.element.firstNightReminder : $0.element.otherNightReminder,
            playerID: $0.offset,
            imageURL: $0.element.imageURL,
            characterName: $0.element.name,
            team: $0.element.team
          )
        } + (firstNightOrder ? ([爪牙信息, 恶魔信息]) : []) + unassignedCharacters
        .enumerated()
        .filter { firstNightOrder ? ($0.element.firstNightOrder != 0) : ($0.element.otherNightOrder != 0) }
        .map {
          OrderInfo(
            order: firstNightOrder ? $0.element.firstNightOrder : $0.element.otherNightOrder,
            reminder: firstNightOrder ? $0.element.firstNightReminder : $0.element.otherNightReminder,
            playerID: -4 - $0.offset,
            imageURL: $0.element.imageURL,
            characterName: $0.element.name,
            team: $0.element.team
          )
        }
      
      let sortedNight = combined.sorted { $0.order < $1.order }
      let sortedNightOtherCharacters = playersAssignedCharacters
        .enumerated()
        .filter { firstNightOrder ? ($0.element.firstNightOrder == 0) : ($0.element.otherNightOrder == 0) }
        .map {
          OrderInfo(
            order: firstNightOrder ? $0.element.firstNightOrder : $0.element.otherNightOrder,
            reminder: $0.element.ability,
            playerID: $0.offset,
            imageURL: $0.element.imageURL,
            characterName: $0.element.name,
            team: $0.element.team
          )
        } + unassignedCharacters
        .enumerated()
        .filter { firstNightOrder ? ($0.element.firstNightOrder == 0) : ($0.element.otherNightOrder == 0) }
        .map {
          OrderInfo(
            order: firstNightOrder ? $0.element.firstNightOrder : $0.element.otherNightOrder,
            reminder: $0.element.ability,
            playerID: -4 - $0.offset,
            imageURL: $0.element.imageURL,
            characterName: $0.element.name,
            team: $0.element.team
          )
        }
      ScrollView{
        ForEach(sortedNight.indices, id: \.self) { index in
          let nightReminder = sortedNight[index]
          let characterIDText: String = {
            if nightReminder.playerID >= 0 {
              return "\(nightReminder.playerID + 1)号"
            } else if nightReminder.playerID <= -4 {
              return "不在场"
            } else {
              return ""
            }
          }()
          VStack{
            HStack{
              let isAlive = nightReminder.playerID >= 0 ? (nightReminder.playerID < playersIsAlive.count ? playersIsAlive[nightReminder.playerID] : false) : true
              CachedImageView(urlString: nightReminder.imageURL)
                .frame(width: 40, height: 40)
              VStack(alignment: .leading){
                Text("\(characterIDText)\(isAlive ? "" : "  已死亡")  \(nightReminder.characterName)")
                  .font(.system(size: 20, design: .rounded))
                  .fontWeight(.bold)
                Text(nightReminder.reminder)
                  .font(.system(size: 15, design: .rounded))
                  .fontWeight(.semibold)
              }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 5)
          }
          .opacity(nightReminder.playerID == currentlyAwakePlayerIndex ? 1 : (unassignedCharacterNames.contains(nightReminder.characterName) ? 0.3 : 0.65))
          .scaleEffect(nightReminder.playerID == currentlyAwakePlayerIndex ? 1 : 0.95)
          .onTapGesture(count: 2) {
            allLogs.append(GameLogEntry(message: nightReminder.reminder, messager: nightReminder.playerID + 1, source: "", type: 2, characterName: nightReminder.characterName, playerTeams: [team2Int(nightReminder.team)]))
            currentlyAwakePlayerIndex = nightReminder.playerID
          }
        }
        Rectangle().fill(Color.black)
          .frame(height: 3)
          .frame(maxWidth: .infinity)
          .padding(.horizontal, 10)
        Text("不需要唤醒")
          .font(.system(size: 20, design: .rounded))
          .fontWeight(.bold)
        Rectangle().fill(Color.black)
          .frame(height: 3)
          .frame(maxWidth: .infinity)
          .padding(.horizontal, 10)
        ForEach(sortedNightOtherCharacters.indices, id: \.self) { index in
          let nightReminder = sortedNightOtherCharacters[index]
          HStack{
            CachedImageView(urlString: nightReminder.imageURL)
              .frame(width: 40, height: 40)
            VStack(alignment: .leading){
              let isAlive = nightReminder.playerID >= 0 ? (nightReminder.playerID < playersIsAlive.count ? playersIsAlive[nightReminder.playerID] : false) : true
              Text("\(nightReminder.playerID >= 0 ? "\(nightReminder.playerID + 1)号\(isAlive ? "" : "  已死亡")": "不在场")  \(nightReminder.characterName)")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.bold)
              Text(nightReminder.reminder)
                .font(.system(size: 15, design: .rounded))
                .fontWeight(.semibold)
            }
            .opacity(nightReminder.playerID == currentlyAwakePlayerIndex ? 1 : 0.5)
            .scaleEffect(nightReminder.playerID == currentlyAwakePlayerIndex ? 1 : 0.95)
            .onTapGesture(count: 2) {
              allLogs.append(GameLogEntry(message: nightReminder.reminder, messager: nightReminder.playerID + 1, source: "", type: 2, characterName: nightReminder.characterName, playerTeams: [team2Int(nightReminder.team)]))
              currentlyAwakePlayerIndex = nightReminder.playerID
            }
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.vertical, 5)
        }
      }
      .padding(.bottom, 10)
      
    }
    .animation(.easeInOut(duration: 0.3), value: firstNightOrder)
    .animation(.easeInOut(duration: 0.3), value: playersAssignedCharacters)
    .animation(.easeInOut(duration: 0.3), value: currentlyAwakePlayerIndex)
    .animation(.easeInOut(duration: 0.3), value: playersIsAlive)
  }
}
