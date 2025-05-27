//
//  ExtraCareView.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/26/25.
//

import SwiftUI

struct ExtraCareView: View {
  @Binding var jinxList: [Jinx]
  @Binding var playersAssignedCharacters: [Character]
  @Binding var playersIsAlive: [Bool]
  @Binding var votingPhase: Int
  @Binding var nominationPhase: Int
  @Binding var gameState: Int
  @State private var selectedView = 0 // 0 for jinx, 1 for nomination enabled, 2 for nominated enabled, 3 for voting enabled, 4 for execution enabled
  
  var body: some View{
    VStack{
      HStack(spacing: 0){
        Text("相克")
          .font(.system(size: 20, design: .monospaced))
          .fontWeight(.bold)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 10)
          .opacity(selectedView == 0 ? 1 : 0.5)
          .border(width: 3, edges: [.bottom], color: .black)
          .border(width: 1.5, edges: [.trailing], color: .black)
          .onTapGesture {
            selectedView = 0
          }
        Text("提名")
          .font(.system(size: 20, design: .monospaced))
          .fontWeight(.bold)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 10)
          .opacity(selectedView == 1 ? 1 : 0.5)
          .border(width: 3, edges: [.bottom], color: .black)
          .border(width: 1.5, edges: [.trailing, .leading], color: .black)
          .onTapGesture {
            selectedView = 1
          }
        Text("被提")
          .font(.system(size: 20, design: .monospaced))
          .fontWeight(.bold)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 10)
          .opacity(selectedView == 2 ? 1 : 0.5)
          .border(width: 3, edges: [.bottom], color: .black)
          .border(width: 1.5, edges: [.leading], color: .black)
          .onTapGesture {
            selectedView = 2
          }
      }
      Group{
        if (selectedView == 0){
          JinxView(jinxList: $jinxList)
        }else if (selectedView == 1){
          NominationEnabledCharacters(playersAssignedCharacters: $playersAssignedCharacters, playersIsAlive: $playersIsAlive)
        }else if (selectedView == 2){
          NominatedEnabledCharacters(playersAssignedCharacters: $playersAssignedCharacters, playersIsAlive: $playersIsAlive)
        }else if (selectedView == 3){
          VotingEnabledCharacters(playersAssignedCharacters: $playersAssignedCharacters, playersIsAlive: $playersIsAlive)
        }else if (selectedView == 4){
          ExecutionEnabledCharacters(playersAssignedCharacters: $playersAssignedCharacters, playersIsAlive: $playersIsAlive)
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .transition(.move(edge: .trailing))
      .animation(.easeInOut(duration: 0.3), value: selectedView)
      HStack(spacing: 0){
        Text("投票")
          .font(.system(size: 20, design: .monospaced))
          .fontWeight(.bold)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 10)
          .opacity(selectedView == 3 ? 1 : 0.5)
          .border(width: 3, edges: [.top], color: .black)
          .border(width: 1.5, edges: [.trailing], color: .black)
          .onTapGesture {
            selectedView = 3
          }
        Text("处决")
          .font(.system(size: 20, design: .monospaced))
          .fontWeight(.bold)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 10)
          .opacity(selectedView == 4 ? 1 : 0.5)
          .border(width: 3, edges: [.top], color: .black)
          .border(width: 1.5, edges: [.leading], color: .black)
          .onTapGesture {
            selectedView = 4
          }
      }
    }
    .background(Color.mainbg)
    .onChange(of: gameState){_, newValue in
      if gameState == 2{
        selectedView = 1
      }else{
        selectedView = 0
      }
    }
    .onChange(of: nominationPhase) {_, newValue in
      if newValue == 0{
        selectedView = 1
      }else{
        selectedView = 2
      }
    }
    .onChange(of: votingPhase) {_, newValue in
      if newValue == 1{
        selectedView = 3
      }else if (newValue == 2){
        selectedView = 4
      }else{
        if nominationPhase == 0{
          selectedView = 1
        }else{
          selectedView = 2
        }
      }
    }
    
  }
}
