//
//  CharacterSelectionView.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/22/25.
//
import SwiftUI
struct CharacterSelectionView: View {
  @Binding var playableCharacters: [Character]
  @Binding var currentSelectedPlayerID: Int
  @Binding var selectNewCharacter: Bool
  @Binding var playersAssignedCharacters: [Character]
  @Binding var notPresentedGoodCharacters: [Character]
  @Binding var gameState: Int
  @Binding var allLogs: [GameLogEntry]
  
  var selectedCharacterNames: [String] {
    playersAssignedCharacters.map { $0.name }
  }
  
  let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 6)
  var townsfolks: [Character] {
    playableCharacters.filter { $0.team == "townsfolk" }
  }
  
  var outsiders: [Character] {
    playableCharacters.filter { $0.team == "outsider" }
  }
  
  var minions: [Character] {
    playableCharacters.filter { $0.team == "minion" }
  }
  
  var demons: [Character] {
    playableCharacters.filter { $0.team == "demon" }
  }
  
  var travelers: [Character] {
    playableCharacters.filter { $0.team == "traveler" }
  }
  var body: some View{
    ZStack {
      Color.mainbg.opacity(0.3)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture(count: 2) {
          withAnimation(.easeInOut(duration: 0.3)) {
            selectNewCharacter = false
          }
        }
      
      ScrollView {
        HStack{
          Text("镇民")
            .font(.system(size: 30, design: .rounded))
            .fontWeight(.bold)
          Spacer()
        }
        .padding()
        .padding(.horizontal, 20)
        LazyVGrid(columns: columns, spacing: 20) {
          ForEach(townsfolks, id: \.id) { character in
            VStack {
              CachedImageView(urlString: character.imageURL)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
              
              Text(character.name)
                .font(.system(size: 15, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.black)
            }
            .padding()
            .background(Color.white.opacity(0.2))
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
              .stroke(Color.black, lineWidth: selectedCharacterNames.contains(character.name) ? 3 : 0))
            .onTapGesture {
              assignCharacter(to: currentSelectedPlayerID, character: character, playersAssignedCharacters: &playersAssignedCharacters, notPresentedGoodCharacters: &notPresentedGoodCharacters)
              selectNewCharacter = false
              if gameState != 0{
                // we assigned a new character not in start phase
                // add a log
                if currentSelectedPlayerID <= 20{
                  allLogs.append(GameLogEntry(message: "获得角色：\(character.name)", messager: currentSelectedPlayerID + 1, source: "说书人", type: 0))
                }else{
                  // give the demon a cover
                  allLogs.append(GameLogEntry(message: "\(character.name)", messager: 0, source: "说书人", type: 13))
                }
              }
            }
          }
        }
        .padding()
        HStack{
          Text("外来者")
            .font(.system(size: 30, design: .rounded))
            .fontWeight(.bold)
          Spacer()
        }
        .padding()
        .padding(.horizontal, 20)
        LazyVGrid(columns: columns, spacing: 20) {
          ForEach(outsiders, id: \.id) { character in
            VStack {
              CachedImageView(urlString: character.imageURL)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
              
              Text(character.name)
                .font(.system(size: 15, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.black)
            }
            .padding()
            .background(Color.white.opacity(0.2))
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
              .stroke(Color.black, lineWidth: selectedCharacterNames.contains(character.name) ? 3 : 0))
            .onTapGesture {
              assignCharacter(to: currentSelectedPlayerID, character: character, playersAssignedCharacters: &playersAssignedCharacters, notPresentedGoodCharacters: &notPresentedGoodCharacters)
              selectNewCharacter = false
              if gameState != 0{
                // we assigned a new character not in start phase
                // add a log
                if currentSelectedPlayerID <= 20{
                  allLogs.append(GameLogEntry(message: "获得角色：\(character.name)", messager: currentSelectedPlayerID + 1, source: "说书人", type: 0))
                }else{
                  // give the demon a cover
                  allLogs.append(GameLogEntry(message: "\(character.name)", messager: 0, source: "说书人", type: 13))
                }
              }
            }
          }
        }
        .padding()
        HStack{
          Text("爪牙")
            .font(.system(size: 30, design: .rounded))
            .fontWeight(.bold)
          Spacer()
        }
        .padding()
        .padding(.horizontal, 20)
        LazyVGrid(columns: columns, spacing: 20) {
          ForEach(minions, id: \.id) { character in
            VStack {
              CachedImageView(urlString: character.imageURL)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
              
              Text(character.name)
                .font(.system(size: 15, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.black)
            }
            .padding()
            .background(Color.white.opacity(0.2))
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
              .stroke(Color.black, lineWidth: selectedCharacterNames.contains(character.name) ? 3 : 0))
            .onTapGesture {
              assignCharacter(to: currentSelectedPlayerID, character: character, playersAssignedCharacters: &playersAssignedCharacters, notPresentedGoodCharacters: &notPresentedGoodCharacters)
              selectNewCharacter = false
              if gameState != 0{
                // we assigned a new character not in start phase
                // add a log
                if currentSelectedPlayerID <= 20{
                  allLogs.append(GameLogEntry(message: "获得角色：\(character.name)", messager: currentSelectedPlayerID + 1, source: "说书人", type: 0))
                }else{
                  // give the demon a cover
                  allLogs.append(GameLogEntry(message: "\(character.name)", messager: 0, source: "说书人", type: 13))
                }
              }
            }
          }
        }
        .padding()
        HStack{
          Text("恶魔")
            .font(.system(size: 30, design: .rounded))
            .fontWeight(.bold)
          Spacer()
        }
        .padding()
        .padding(.horizontal, 20)
        LazyVGrid(columns: columns, spacing: 20) {
          ForEach(demons, id: \.id) { character in
            VStack {
              CachedImageView(urlString: character.imageURL)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
              
              Text(character.name)
                .font(.system(size: 15, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.black)
            }
            .padding()
            .background(Color.white.opacity(0.2))
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
              .stroke(Color.black, lineWidth: selectedCharacterNames.contains(character.name) ? 3 : 0))
            .onTapGesture {
              assignCharacter(to: currentSelectedPlayerID, character: character, playersAssignedCharacters: &playersAssignedCharacters, notPresentedGoodCharacters: &notPresentedGoodCharacters)
              selectNewCharacter = false
              if gameState != 0{
                // we assigned a new character not in start phase
                // add a log
                if currentSelectedPlayerID <= 20{
                  allLogs.append(GameLogEntry(message: "获得角色：\(character.name)", messager: currentSelectedPlayerID + 1, source: "说书人", type: 0))
                }else{
                  // give the demon a cover
                  allLogs.append(GameLogEntry(message: "\(character.name)", messager: 0, source: "说书人", type: 13))
                }
              }
            }
          }
        }
        .padding()
        HStack{
          Text("旅行者")
            .font(.system(size: 30, design: .rounded))
            .fontWeight(.bold)
          Spacer()
        }
        .padding()
        .padding(.horizontal, 20)
        LazyVGrid(columns: columns, spacing: 20) {
          ForEach(travelers, id: \.id) { character in
            VStack {
              CachedImageView(urlString: character.imageURL)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
              
              Text(character.name)
                .font(.system(size: 15, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.black)
            }
            .padding()
            .background(Color.white.opacity(0.2))
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
              .stroke(Color.black, lineWidth: selectedCharacterNames.contains(character.name) ? 3 : 0))
            .onTapGesture {
              assignCharacter(to: currentSelectedPlayerID, character: character, playersAssignedCharacters: &playersAssignedCharacters, notPresentedGoodCharacters: &notPresentedGoodCharacters)
              selectNewCharacter = false
              if gameState != 0{
                // we assigned a new character not in start phase
                // add a log
                if currentSelectedPlayerID <= 20{
                  allLogs.append(GameLogEntry(message: "获得角色：\(character.name)", messager: currentSelectedPlayerID + 1, source: "说书人", type: 0))
                }else{
                  // give the demon a cover
                  allLogs.append(GameLogEntry(message: "\(character.name)", messager: 0, source: "说书人", type: 13))
                }
              }
            }
          }
        }
        .padding()
//        Button(action: {
//          selectNewCharacter = false
//        }) {
//          Text("返回")
//            .font(.system(size: 20, design: .rounded))
//            .fontWeight(.bold)
//            .foregroundColor(.black)
//            .padding(.horizontal, 20)
//            .padding(.vertical, 8)
//            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 3))
//        }
//        .contentShape(Rectangle())
//        .padding()
      }
      .background(Color.mainbg)
      .frame(width: 800, height: 800)
      .clipShape(RoundedRectangle(cornerRadius: 20))
      .overlay(
        RoundedRectangle(cornerRadius: 20)
          .stroke(Color.black, lineWidth: 3)
      )
      .animation(.easeInOut(duration: 0.3), value: selectNewCharacter)
      
      Image(systemName: "xmark")
        .font(.system(size: 14, weight: .bold))
        .foregroundColor(.black)
        .frame(width: 30, height: 30)
        .background(Color.mainbg)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.black, lineWidth: 2))
        .padding(10)
        .offset(x: 395, y: -395)
        .onTapGesture {
          withAnimation(.easeInOut(duration: 0.3)) {
            selectNewCharacter = false
          }
        }
      
    }
  }
}
