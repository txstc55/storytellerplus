//
//  SpecialCare.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 11/1/25.
//
// this is for players who need to have special care
// for example for new players we can pre assign some characters

import SwiftUI
import Flow

struct SpecialCareCharacterCard: View{
  let character: Character
  var body: some View{
    HStack(spacing: 0) {
      CachedImageView(urlString: character.imageURL)
        .frame(width: 60, height: 60)
        .frame(maxHeight: .infinity)
        .padding(.horizontal, 20)
      VStack{
        Text(character.name)
          .font(.system(size: 20, design: .rounded))
          .fontWeight(.bold)
          .foregroundColor(.goodTextBg)
          .padding(.vertical, 10)
          .padding(.horizontal, 20)
          
        Text(character.ability)
          .font(.system(size: 15, design: .rounded))
          .fontWeight(.semibold)
          .foregroundColor(.goodTextBg)
          .padding(.bottom, 10)
          .padding(.horizontal, 20)
      }
      .frame(maxWidth: .infinity)
      .frame(maxHeight: .infinity)
      .background(team2Color(character.team))
    }
    .frame(maxWidth: .infinity)
    .background(.goodTextBg)
    .clipShape(RoundedRectangle(cornerRadius: 20))
    .padding(.horizontal, 10)
    .padding(.vertical, 5)
  }
}


struct SpecialCare: View {
  @Binding var mergedSelectedCharactersShuffled: [Character] // for manipulating the selected characters
  @Binding var playerChoices: [Int] // which card did player choose
  @Binding var specialCarePlayerChoices: [Int: Int]
  @Binding var currentSelectingPlayerIndex: Int
  @Binding var showSpecialCare: Bool
  @Binding var selectedCardIndices: Set<Int>
  @State private var preSelectedIndex: Int = -1
  var body: some View{
    ZStack{
      Color.mainbg.opacity(0.3)
        .edgesIgnoringSafeArea(.all)
      VStack{
        ScrollView{
          HStack{
            Text("为\(currentSelectingPlayerIndex + 1)号玩家提前选择角色")
              .font(.system(size: 25, design: .rounded))
              .fontWeight(.bold)
          }
          .padding(.vertical, 25)
          .frame(maxWidth: .infinity)
          ForEach(mergedSelectedCharactersShuffled.indices, id: \.self) { index in
            let character = mergedSelectedCharactersShuffled[index]
            if character.team == "townsfolk"{
              SpecialCareCharacterCard(character: character)
                .scaleEffect((preSelectedIndex == index) ? 1 : 0.95)
                .opacity((selectedCardIndices.contains(index) || specialCarePlayerChoices.values.contains(index)) ? 0.5 : 1)
                .onTapGesture {
                  if preSelectedIndex == index{
                    if specialCarePlayerChoices.keys.contains(currentSelectingPlayerIndex){
                      specialCarePlayerChoices[currentSelectingPlayerIndex] = -1
                    }else{
                      specialCarePlayerChoices[currentSelectingPlayerIndex] = -1
                    }
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.85, blendDuration: 0.2)) {
                      preSelectedIndex = -1
                    }
                  }else{
                    if selectedCardIndices.contains(index) || specialCarePlayerChoices.values.contains(index){
                      return
                    }else{
                      withAnimation(.spring(response: 0.35, dampingFraction: 0.85, blendDuration: 0.2)) {
                        preSelectedIndex = index
                      }
                      if specialCarePlayerChoices.keys.contains(currentSelectingPlayerIndex){
                        let previouslySelectedIndex = specialCarePlayerChoices[currentSelectingPlayerIndex]!
                        if previouslySelectedIndex == preSelectedIndex {
                          specialCarePlayerChoices[currentSelectingPlayerIndex] = -1
                        }else{
                          specialCarePlayerChoices[currentSelectingPlayerIndex] = preSelectedIndex
                        }
                      }else{
                        specialCarePlayerChoices[currentSelectingPlayerIndex] = preSelectedIndex
                      }
                    }
                  }
                }
            }
          }
          ForEach(mergedSelectedCharactersShuffled.indices, id: \.self) { index in
            let character = mergedSelectedCharactersShuffled[index]
            if character.team == "outsider"{
              SpecialCareCharacterCard(character: character)
                .scaleEffect((preSelectedIndex == index) ? 1 : 0.95)
                .opacity((selectedCardIndices.contains(index) || specialCarePlayerChoices.values.contains(index)) ? 0.5 : 1)
                .onTapGesture {
                  if preSelectedIndex == index{
                    if specialCarePlayerChoices.keys.contains(currentSelectingPlayerIndex){
                      specialCarePlayerChoices[currentSelectingPlayerIndex] = -1
                    }else{
                      specialCarePlayerChoices[currentSelectingPlayerIndex] = -1
                    }
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.85, blendDuration: 0.2)) {
                      preSelectedIndex = -1
                    }
                  }else{
                    if selectedCardIndices.contains(index) || specialCarePlayerChoices.values.contains(index){
                      return
                    }else{
                      withAnimation(.spring(response: 0.35, dampingFraction: 0.85, blendDuration: 0.2)) {
                        preSelectedIndex = index
                      }
                      if specialCarePlayerChoices.keys.contains(currentSelectingPlayerIndex){
                        let previouslySelectedIndex = specialCarePlayerChoices[currentSelectingPlayerIndex]!
                        if previouslySelectedIndex == preSelectedIndex {
                          specialCarePlayerChoices[currentSelectingPlayerIndex] = -1
                        }else{
                          specialCarePlayerChoices[currentSelectingPlayerIndex] = preSelectedIndex
                        }
                      }else{
                        specialCarePlayerChoices[currentSelectingPlayerIndex] = preSelectedIndex
                      }
                    }
                  }
                }
            }
          }
          ForEach(mergedSelectedCharactersShuffled.indices, id: \.self) { index in
            let character = mergedSelectedCharactersShuffled[index]
            if character.team == "minion"{
              SpecialCareCharacterCard(character: character)
                .scaleEffect((preSelectedIndex == index) ? 1 : 0.95)
                .opacity((selectedCardIndices.contains(index) || specialCarePlayerChoices.values.contains(index)) ? 0.5 : 1)
                .onTapGesture {
                  if preSelectedIndex == index{
                    if specialCarePlayerChoices.keys.contains(currentSelectingPlayerIndex){
                      specialCarePlayerChoices[currentSelectingPlayerIndex] = -1
                    }else{
                      specialCarePlayerChoices[currentSelectingPlayerIndex] = -1
                    }
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.85, blendDuration: 0.2)) {
                      preSelectedIndex = -1
                    }
                  }else{
                    if selectedCardIndices.contains(index) || specialCarePlayerChoices.values.contains(index){
                      return
                    }else{
                      withAnimation(.spring(response: 0.35, dampingFraction: 0.85, blendDuration: 0.2)) {
                        preSelectedIndex = index
                      }
                      if specialCarePlayerChoices.keys.contains(currentSelectingPlayerIndex){
                        let previouslySelectedIndex = specialCarePlayerChoices[currentSelectingPlayerIndex]!
                        if previouslySelectedIndex == preSelectedIndex {
                          specialCarePlayerChoices[currentSelectingPlayerIndex] = -1
                        }else{
                          specialCarePlayerChoices[currentSelectingPlayerIndex] = preSelectedIndex
                        }
                      }else{
                        specialCarePlayerChoices[currentSelectingPlayerIndex] = preSelectedIndex
                      }
                    }
                  }
                }
            }
          }
          ForEach(mergedSelectedCharactersShuffled.indices, id: \.self) { index in
            let character = mergedSelectedCharactersShuffled[index]
            if character.team == "demon"{
              SpecialCareCharacterCard(character: character)
                .scaleEffect((preSelectedIndex == index) ? 1 : 0.95)
                .opacity((selectedCardIndices.contains(index) || specialCarePlayerChoices.values.contains(index)) ? 0.5 : 1)
                .onTapGesture {
                  if preSelectedIndex == index{
                    if specialCarePlayerChoices.keys.contains(currentSelectingPlayerIndex){
                      specialCarePlayerChoices[currentSelectingPlayerIndex] = -1
                    }else{
                      specialCarePlayerChoices[currentSelectingPlayerIndex] = -1
                    }
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.85, blendDuration: 0.2)) {
                      preSelectedIndex = -1
                    }
                  }else{
                    if selectedCardIndices.contains(index) || specialCarePlayerChoices.values.contains(index){
                      return
                    }else{
                      withAnimation(.spring(response: 0.35, dampingFraction: 0.85, blendDuration: 0.2)) {
                        preSelectedIndex = index
                      }
                      if specialCarePlayerChoices.keys.contains(currentSelectingPlayerIndex){
                        let previouslySelectedIndex = specialCarePlayerChoices[currentSelectingPlayerIndex]!
                        if previouslySelectedIndex == preSelectedIndex {
                          specialCarePlayerChoices[currentSelectingPlayerIndex] = -1
                        }else{
                          specialCarePlayerChoices[currentSelectingPlayerIndex] = preSelectedIndex
                        }
                      }else{
                        specialCarePlayerChoices[currentSelectingPlayerIndex] = preSelectedIndex
                      }
                    }
                  }
                }
            }
          }
        }
        Spacer()
        HStack{
          Button(action: {
            showSpecialCare = false
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
            showSpecialCare = false
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
      }
      .background(Color.mainbg)
      .cornerRadius(20)
      .frame(width: 600)
      .overlay(
        RoundedRectangle(cornerRadius: 20)
          .stroke(Color.black, lineWidth: 3)
      )
      .padding(.vertical, 50)
      .onAppear(){
        if specialCarePlayerChoices.keys.contains(currentSelectingPlayerIndex){
          preSelectedIndex = specialCarePlayerChoices[currentSelectingPlayerIndex] ?? -1
        }
      }
    }
  }
}
