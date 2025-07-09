//
//  ExtraRepeatedCharacterSelectionView.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 7/8/25.
//

import SwiftUI
import Flow
struct ExtraRepeatedCharacterSelectionView: View {
  @Binding var playableCharacters: [Character]
  @Binding var extraRepeatedCharacters: [Character]
  @Binding var extraRepeatedCardSelected: [Bool]
  @Binding var showExtraCharacterSelection: Bool
  var body: some View {
    ZStack{
      Color.mainbg
        .opacity(0.3)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture(count: 2) {
          withAnimation(.easeInOut(duration: 0.3)) {
            showExtraCharacterSelection = false
          }
        }
      ScrollView(showsIndicators: false) {
        HFlow{
          ForEach(playableCharacters.indices, id: \.self) { index in
            if playableCharacters[index].team == "demon"{
              CardFront(character: playableCharacters[index], cardColor: .demon)
                .scaleEffect(0.5)
                .frame(width: 100, height: 150)
                .padding(15)
                .onTapGesture {
                  extraRepeatedCardSelected.append(true)
                  extraRepeatedCharacters.append(playableCharacters[index])
                  showExtraCharacterSelection = false
                }
            }
          }
          ForEach(playableCharacters.indices, id: \.self) { index in
            if playableCharacters[index].team == "minion"{
              CardFront(character: playableCharacters[index], cardColor: .minion)
                .scaleEffect(0.5)
                .frame(width: 100, height: 150)
                .padding(15)
                .onTapGesture {
                  extraRepeatedCardSelected.append(true)
                  extraRepeatedCharacters.append(playableCharacters[index])
                  showExtraCharacterSelection = false
                }
            }
            
          }
          ForEach(playableCharacters.indices, id: \.self) { index in
            if playableCharacters[index].team == "outsider"{
              CardFront(character: playableCharacters[index], cardColor: .outsider)
                .scaleEffect(0.5)
                .frame(width: 100, height: 150)
                .padding(15)
                .onTapGesture {
                  extraRepeatedCardSelected.append(true)
                  extraRepeatedCharacters.append(playableCharacters[index])
                  showExtraCharacterSelection = false
                }
            }
            
          }
          ForEach(playableCharacters.indices, id: \.self) { index in
            if playableCharacters[index].team == "townsfolk"{
              CardFront(character: playableCharacters[index], cardColor: .townsfolk)
                .scaleEffect(0.5)
                .frame(width: 100, height: 150)
                .padding(15)
                .onTapGesture {
                  extraRepeatedCardSelected.append(true)
                  extraRepeatedCharacters.append(playableCharacters[index])
                  showExtraCharacterSelection = false
                }
            }
            
          }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 10)
      }
      .frame(width: 800)
      .frame(maxHeight: 800)
      .background(Color.mainbg)
      .clipShape(RoundedRectangle(cornerRadius: 20))
      .overlay(RoundedRectangle(cornerRadius: 20)
        .stroke(Color.black, lineWidth: 3))
      .padding(.vertical, 50)
    }
  }
}

//#Preview {
//    ExtraRepeatedCharacterSelectionView()
//}
