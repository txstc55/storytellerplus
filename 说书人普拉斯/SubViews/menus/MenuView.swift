//
//  MenuView.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/23/25.
//

import SwiftUI

struct MenuView: View {
  @Binding var firstNightOrder: Bool
  @Binding var showMenu: Bool
  @Binding var showNotepad: Bool
  @Binding var showConversation: Bool
  @Binding var showAllCharacterInfos: Bool
  @Binding var showExitConfirmation: Bool
  @Binding var currentView: Int
  @Binding var gameState: Int
  @Binding var allLogs: [GameLogEntry]
  @Binding var votingPhase: Int
  @Binding var nominationPhase: Int
  var body: some View {
    VStack{
      Button(action: {
        if gameState == 2{
          gameState = 3
          firstNightOrder = false
          allLogs.append(GameLogEntry(message: "夜晚", messager: 0, source: "说书人", type: 11, characterName: ""))
        }
      }){
        Image(systemName: (gameState == 1 || gameState == 3) ? "moon.fill" : "moon")
          .resizable()
          .scaledToFit()
          .frame(width: 30, height: 30)
          .foregroundColor(.black)
      }
      .padding(.top, 30)
      .padding(.horizontal, 20)
      .padding(.bottom, 35)
      Button(action: {
        if gameState == 1 || gameState == 3{
          gameState = 2
          firstNightOrder = false
          allLogs.append(GameLogEntry(message: "白天", messager: 0, source: "说书人", type: 10, characterName: ""))
          votingPhase = 0
          nominationPhase = 0
        }
      }){
        Image(systemName: (gameState == 2) ? "sun.min.fill" : "sun.min")
          .resizable()
          .scaledToFit()
          .frame(width: 30, height: 30)
          .foregroundColor(.black)
      }
      .padding(.horizontal, 20)
      
      Spacer()
      Button(action: {
        showAllCharacterInfos = true
      }){
        Image(systemName: "note.text")
          .resizable()
          .scaledToFit()
          .frame(width: 30, height: 30)
          .foregroundColor(.black)
      }
      .padding(.bottom, 35)
      .padding(.horizontal, 20)
      Button(action: {
        showConversation = true
      }){
        Image(systemName: "text.bubble")
          .resizable()
          .scaledToFit()
          .frame(width: 30, height: 30)
          .foregroundColor(.black)
      }
      .padding(.bottom, 35)
      .padding(.horizontal, 20)
      Button(action: {
        showNotepad = true
      }){
        Image(systemName: "pencil.line")
          .resizable()
          .scaledToFit()
          .frame(width: 30, height: 30)
          .foregroundColor(.black)
      }
      .padding(.bottom, 35)
      .padding(.horizontal, 20)
      Button(action: {
        withAnimation{
          showMenu.toggle()
        }
      }){
        Image(systemName: "gearshape")
          .resizable()
          .scaledToFit()
          .frame(width: 30, height: 30)
          .foregroundColor(.black)
      }
      .padding(.bottom, 35)
      .padding(.horizontal, 20)
      Button(action: {
        showExitConfirmation = true
      }){
        Image(systemName: "x.circle")
          .resizable()
          .scaledToFit()
          .frame(width: 30, height: 30)
          .foregroundColor(.red)
      }
      .padding(.bottom, 30)
      .padding(.horizontal, 20)
      
    } // end of the vstack for menu bar
  }
}
