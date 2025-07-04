//
//  SetupPlayerPick.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 7/3/25.
//

import SwiftUI
import Flow
struct SetupPlayerPick: View {
  @Binding var playableCharacters: [Character]
  @Binding var playersAssignedCharacters: [Character]
  @Binding var cardSelected: [Bool]
  @Binding var playerChoices: [Int] // which card did player choose
  @Binding var selectionState: Int
  @Binding var showSetup: Bool
  @State private var currentSelectingPlayerIndex: Int = -1
  @State private var cardRotation: [Double] = []
  @State private var selectedCardIndex: Int = -1
  @State private var selectedCardIndices: Set<Int> = []
  init(
    playableCharacters: Binding<[Character]>,
    playersAssignedCharacters: Binding<[Character]>,
    cardSelected: Binding<[Bool]>,
    playerChoices: Binding<[Int]>,
    selectionState: Binding<Int>,
    showSetup: Binding<Bool>
  ) {
    self._playableCharacters = playableCharacters
    self._playersAssignedCharacters = playersAssignedCharacters
    self._cardSelected = cardSelected
    self._playerChoices = playerChoices
    self._selectionState = selectionState
    self._showSetup = showSetup
    // Initialize cardRotation here
    self._cardRotation = State(initialValue: Array(repeating: 0.0, count: playableCharacters.wrappedValue.count))
  }
  var body: some View {
    HStack{
      ScrollView{
        HFlow(horizontalAlignment: .center, verticalAlignment: .top){
          ForEach(playableCharacters.indices, id: \.self) { index in
            if cardSelected[index] {
              let team = playableCharacters[index].team
              let cardColor = team == "demon" ? Color.demon : (team == "minion" ? Color.minion : (team == "outsider" ? Color.outsider : Color.townsfolk))
              ZStack{
                CardFront(character: playableCharacters[index], cardColor: cardColor)
                  .opacity(cardRotation[index] <= 90 || cardRotation[index] >= 270 ? 0 : 1)
                  .rotation3DEffect(
                    Angle.degrees(cardRotation[index] + 180.0),
                    axis: (x: 0, y: 1, z: 0) // rotate around Y axis
                  )
                CardBack(cardColor: .black)
                  .opacity(cardRotation[index] > 90 && cardRotation[index] < 270 ? 0 : 1)
                  .rotation3DEffect(
                    Angle.degrees(cardRotation[index]),
                    axis: (x: 0, y: 1, z: 0)
                  )
              }
              .opacity((cardRotation[index] == 0 && selectedCardIndices.contains(index)) ? 0.7 : 1.0)
              .padding(.vertical, 30)
              .padding(.horizontal, 10)
              .onLongPressGesture(minimumDuration: 1) {
                if (currentSelectingPlayerIndex != -1 && playerChoices[currentSelectingPlayerIndex] == -1 && !selectedCardIndices.contains(index)) {
                  playerChoices[currentSelectingPlayerIndex] = index
                  cardRotation[index] = 180 // flip the card
                  selectedCardIndices.insert(index)
                  playersAssignedCharacters[currentSelectingPlayerIndex] = playableCharacters[index]
                }
              }
              .animation(.easeInOut(duration: 0.3), value: cardRotation[index])
            }
          }
        }
        .padding(.horizontal, 10)
      }
      .onChange(of: currentSelectingPlayerIndex) {_, newValue in
        // show the old character if needed for player who doesnt know their character
        if newValue != -1 {
          let playerSelectedCardIndex = playerChoices[newValue]
          for i in 0..<cardRotation.count {
            if i == playerSelectedCardIndex {
              cardRotation[i] = 180 // flip the card for the selected player
            } else {
              cardRotation[i] = 0 // reset others
            }
          }
        }else{
          for i in 0..<cardRotation.count {
            cardRotation[i] = 0 // reset others
          }
        }
      }
      .frame(maxWidth: .infinity)
      .frame(maxHeight: .infinity)
      VStack{
        ScrollView{
          ForEach(playersAssignedCharacters.indices, id: \.self){ index in
            HStack{
              Text("\(index + 1)号")
                .font(.system(size: 35, design: .rounded))
                .fontWeight(.bold)
                .padding(.horizontal, 5)
                .padding(.vertical, 5)
              Spacer()
              Image(systemName:  playerChoices[index] == -1 ? "xmark" : "checkmark")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding(.vertical, 5)
                .padding(.horizontal, 5)
            }
            .overlay(Rectangle().stroke(Color.black, lineWidth: 4)
              .opacity(currentSelectingPlayerIndex == index ? 1 : 0))
            .scaleEffect(currentSelectingPlayerIndex == index ? 1.0 : 0.95)
            .contentShape(Rectangle())
            .onTapGesture(count: 2){
              if currentSelectingPlayerIndex == index {
                currentSelectingPlayerIndex = -1 // reset selection
              } else{
                currentSelectingPlayerIndex = index // select this player
              }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .animation(.easeInOut(duration: 0.3), value: currentSelectingPlayerIndex)
          }
        }
        
        HStack{
          Button(action: {
            selectionState = max(selectionState - 1, 0)
          }){
            Text("返回")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.black)
              .padding(.horizontal, 20)
              .padding(.vertical, 10)
              .background(Color.mainbg)
              .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 3))
              .contentShape(RoundedRectangle(cornerRadius: 10))
          }
          Spacer()
          Button(action: {
            showSetup = false
          }){
            Text("确认")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.black)
              .padding(.horizontal, 20)
              .padding(.vertical, 10)
              .background(Color.mainbg)
              .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 3))
              .contentShape(RoundedRectangle(cornerRadius: 10))
          }
          Spacer()
          Button(action: {
            showSetup = false
          }){
            Text("退出")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.black)
              .padding(.horizontal, 20)
              .padding(.vertical, 10)
              .background(Color.mainbg)
              .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 3))
              .contentShape(RoundedRectangle(cornerRadius: 10))
          }
        }
        .frame(maxWidth: .infinity)
      }
      .frame(width: 260)
    }
  }
}

