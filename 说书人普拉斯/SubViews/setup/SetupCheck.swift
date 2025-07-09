//
//  SetupCheck.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 7/3/25.
//

import SwiftUI
import Flow
struct SetupCheck: View {
  @Binding var playableCharacters: [Character]
  @Binding var playableCharactersShuffled: [Character]
  @Binding var cardSelected: [Bool]
  @Binding var extraRepeatedCharacters: [Character]
  @Binding var extraRepeatedCardSelected: [Bool]
  @Binding var playerCount: Int
  @Binding var selectionState: Int
  @State private var showExtraCharacterSelection: Bool = false
  var body: some View {
    let teamCount: [Int] = Array((teamCounts[playerCount] ?? [0, 0, 0, 0, 0]).reversed())
    ZStack{
      if (showExtraCharacterSelection) {
        ExtraRepeatedCharacterSelectionView(playableCharacters: $playableCharacters, extraRepeatedCharacters: $extraRepeatedCharacters, extraRepeatedCardSelected: $extraRepeatedCardSelected, showExtraCharacterSelection: $showExtraCharacterSelection)
          .zIndex(10)
      }
      ScrollView{
        Text("请检查配置，已选 \(cardSelected.filter({$0}).count + extraRepeatedCardSelected.filter({$0}).count) 张")
          .font(.system(size: 50, design: .rounded))
          .fontWeight(.bold)
          .padding(.vertical, 20)
        VStack{
          HStack{
            Text("恶魔， 应选 \(teamCount[1]) 张")
              .font(.system(size: 40, design: .rounded))
              .fontWeight(.bold)
              .padding(.vertical, 15)
            Spacer()
          }
          HFlow{
            ForEach(playableCharactersShuffled.indices, id: \.self) { index in
              if playableCharactersShuffled[index].team == "demon" {
                CardFront(character: playableCharactersShuffled[index], cardColor: .demon)
                  .scaleEffect(cardSelected[index] ? 1.05 : 0.95)
                  .opacity(cardSelected[index] ? 1.0 : 0.7)
                  .padding(.vertical, 20)
                  .padding(.horizontal, 25)
                  .onTapGesture{
                    cardSelected[index].toggle()
                  }
                  .animation(.easeInOut(duration: 0.3), value: cardSelected[index])
              }
            }
          }
        }
        .padding(.bottom, 20)
        VStack{
          HStack{
            Text("爪牙，应选 \(teamCount[2]) 张")
              .font(.system(size: 40, design: .rounded))
              .fontWeight(.bold)
              .padding(.vertical, 15)
            Spacer()
          }
          HFlow{
            ForEach(playableCharactersShuffled.indices, id: \.self) { index in
              if playableCharactersShuffled[index].team == "minion" {
                CardFront(character: playableCharactersShuffled[index], cardColor: .minion)
                  .scaleEffect(cardSelected[index] ? 1.05 : 0.95)
                  .opacity(cardSelected[index] ? 1.0 : 0.7)
                  .padding(.vertical, 20)
                  .padding(.horizontal, 25)
                  .onTapGesture{
                    cardSelected[index].toggle()
                  }
                  .animation(.easeInOut(duration: 0.3), value: cardSelected[index])
              }
            }
          }
        }
        .padding(.bottom, 20)
        VStack{
          HStack{
            Text("外来者，应选 \(teamCount[3]) 张")
              .font(.system(size: 40, design: .rounded))
              .fontWeight(.bold)
              .padding(.vertical, 15)
            Spacer()
          }
          HFlow{
            ForEach(playableCharactersShuffled.indices, id: \.self) { index in
              if playableCharactersShuffled[index].team == "outsider" {
                CardFront(character: playableCharactersShuffled[index], cardColor: .outsider)
                  .scaleEffect(cardSelected[index] ? 1.05 : 0.95)
                  .opacity(cardSelected[index] ? 1.0 : 0.7)
                  .padding(.vertical, 20)
                  .padding(.horizontal, 25)
                  .onTapGesture{
                    cardSelected[index].toggle()
                  }
                  .animation(.easeInOut(duration: 0.3), value: cardSelected[index])
              }
            }
          }
        }
        .padding(.bottom, 20)
        VStack{
          HStack{
            Text("镇民，应选 \(teamCount[4]) 张")
              .font(.system(size: 40, design: .rounded))
              .fontWeight(.bold)
              .padding(.vertical, 15)
            Spacer()
          }
          HFlow{
            ForEach(playableCharactersShuffled.indices, id: \.self) { index in
              if playableCharactersShuffled[index].team == "townsfolk" {
                CardFront(character: playableCharactersShuffled[index], cardColor: .townsfolk)
                  .scaleEffect(cardSelected[index] ? 1.05 : 0.95)
                  .opacity(cardSelected[index] ? 1.0 : 0.7)
                  .padding(.vertical, 20)
                  .padding(.horizontal, 25)
                  .onTapGesture{
                    cardSelected[index].toggle()
                  }
                  .animation(.easeInOut(duration: 0.3), value: cardSelected[index])
              }
            }
          }
        }
        VStack{
          HStack{
            Text("添加重复角色")
              .font(.system(size: 40, design: .rounded))
              .fontWeight(.bold)
              .padding(.vertical, 15)
            Spacer()
          }
          HFlow{
            ForEach(extraRepeatedCharacters.indices, id: \.self) { index in
              let characterTeam = extraRepeatedCharacters[index].team
              let cardColor: Color = characterTeam == "demon" ? .demon :
                                      characterTeam == "minion" ? .minion :
                                      characterTeam == "outsider" ? .outsider :
                                      characterTeam == "townsfolk" ? .townsfolk : .black
              CardFront(character: extraRepeatedCharacters[index], cardColor: cardColor)
                .scaleEffect(extraRepeatedCardSelected[index] ? 1.05 : 0.95)
                .opacity(extraRepeatedCardSelected[index] ? 1.0 : 0.7)
                .padding(.vertical, 20)
                .padding(.horizontal, 25)
                .onTapGesture{
                  extraRepeatedCardSelected[index].toggle()
                }
                .animation(.easeInOut(duration: 0.3), value: extraRepeatedCardSelected[index])
            }
            Button(action:{
              showExtraCharacterSelection = true
            }){
              VStack{
                Image(systemName: "plus.circle.fill")
                  .font(.system(size: 100, design: .rounded))
                  .foregroundColor(.black)
              }
              .frame(width: 200, height: 300)
              .padding(.vertical, 20)
              .padding(.horizontal, 25)
            }
            .contentShape(Circle())
          }
        }
        .padding(.bottom, 20)
        HStack{
          Button(action: {selectionState = 12}){
            Text("玩家开抽")
              .font(.system(size: 20,  design: .rounded))
              .fontWeight(.bold)
              .padding()
              .foregroundColor(.black)
              .padding(.horizontal, 10)
              .padding(.vertical, 3)
              .frame(width: 150)
              .background(.mainbg)
              .cornerRadius(30)
              .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 3))
              .contentShape(RoundedRectangle(cornerRadius: 30))
          }
          .padding(.top, 30)
        }
        .frame(maxWidth: .infinity)
      }
      .padding(.horizontal, 10)
    }
    .animation(.easeInOut(duration: 0.3), value: showExtraCharacterSelection)
  }
}
