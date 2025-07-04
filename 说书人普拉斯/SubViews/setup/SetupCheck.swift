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
  @Binding var cardSelected: [Bool]
  @Binding var playerCount: Int
  var body: some View {
    let teamCount: [Int] = Array((teamCounts[playerCount] ?? [0, 0, 0, 0, 0]).reversed())
    ScrollView{
      Text("请检查配置")
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
          ForEach(playableCharacters.indices, id: \.self) { index in
            if playableCharacters[index].team == "demon" {
              CardFront(character: playableCharacters[index], cardColor: .demon)
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
          ForEach(playableCharacters.indices, id: \.self) { index in
            if playableCharacters[index].team == "minion" {
              CardFront(character: playableCharacters[index], cardColor: .minion)
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
          ForEach(playableCharacters.indices, id: \.self) { index in
            if playableCharacters[index].team == "outsider" {
              CardFront(character: playableCharacters[index], cardColor: .outsider)
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
          ForEach(playableCharacters.indices, id: \.self) { index in
            if playableCharacters[index].team == "townsfolk" {
              CardFront(character: playableCharacters[index], cardColor: .townsfolk)
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
    }
    .padding(.horizontal, 10)
  }
}
