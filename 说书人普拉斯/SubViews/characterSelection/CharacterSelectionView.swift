//
//  CharacterSelectionView.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/22/25.
//
import SwiftUI
struct CharacterSelectionView: View {
  @Binding var playableCharacters: [Character]
  @Binding var travelersInPlay: [Character]
  @Binding var currentSelectedPlayerID: Int
  @Binding var selectNewCharacter: Bool
  @Binding var playersAssignedCharacters: [Character]
  @Binding var notPresentedGoodCharacters: [Character]
  @Binding var gameState: Int
  @Binding var allLogs: [GameLogEntry]
  
  @State private var selectedCharacterNames: [String] = []
  
  let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 6)
  @State private var townsfolks: [Character] = []
  @State private var outsiders: [Character] = []
  @State private var minions: [Character] = []
  @State private var demons: [Character] = []
  @State private var travelers: [Character] = []
  @State private var officialTravelers: [Character] = []
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
                  allLogs.append(GameLogEntry(message: "获得角色：\(character.name)", messager: currentSelectedPlayerID + 1, source: "说书人", type: 0, playerCharacters: [character.name], playerTeams: [team2Int(character.team)]))
                }else{
                  // give the demon a cover
                  allLogs.append(GameLogEntry(message: "", messager: 0, source: "说书人", type: 13, playerCharacters: [character.name], playerTeams: [team2Int(character.team)]))
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
                  allLogs.append(GameLogEntry(message: "获得角色：\(character.name)", messager: currentSelectedPlayerID + 1, source: "说书人", type: 0, playerCharacters: [character.name], playerTeams: [team2Int(character.team)]))
                }else{
                  // give the demon a cover
                  allLogs.append(GameLogEntry(message: "", messager: 0, source: "说书人", type: 13, playerCharacters: [character.name], playerTeams: [team2Int(character.team)]))
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
                  allLogs.append(GameLogEntry(message: "获得角色：\(character.name)", messager: currentSelectedPlayerID + 1, source: "说书人", type: 0, playerCharacters: [character.name], playerTeams: [team2Int(character.team)]))
                }else{
                  // give the demon a cover
                  allLogs.append(GameLogEntry(message: "", messager: 0, source: "说书人", type: 13, playerCharacters: [character.name], playerTeams: [team2Int(character.team)]))
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
                  allLogs.append(GameLogEntry(message: "获得角色：\(character.name)", messager: currentSelectedPlayerID + 1, source: "说书人", type: 0, playerCharacters: [character.name], playerTeams: [team2Int(character.team)]))
                }else{
                  // give the demon a cover
                  allLogs.append(GameLogEntry(message: "", messager: 0, source: "说书人", type: 13, playerCharacters: [character.name], playerTeams: [team2Int(character.team)]))
                }
              }
            }
          }
        }
        .padding()
        HStack{
          Text("剧本旅行者")
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
                  allLogs.append(GameLogEntry(message: "获得角色：\(character.name)", messager: currentSelectedPlayerID + 1, source: "说书人", type: 0, playerCharacters: [character.name], playerTeams: [team2Int(character.team)]))
                }else{
                  // give the demon a cover
                  allLogs.append(GameLogEntry(message: "", messager: 0, source: "说书人", type: 13, playerCharacters: [character.name], playerTeams: [team2Int(character.team)]))
                }
              }
            }
          }
        }
        .padding()
        HStack{
          Text("官方旅行者")
            .font(.system(size: 30, design: .rounded))
            .fontWeight(.bold)
          Spacer()
        }
        .padding()
        .padding(.horizontal, 20)
        LazyVGrid(columns: columns, spacing: 20) {
          ForEach(officialTravelers, id: \.id) { character in
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
                  allLogs.append(GameLogEntry(message: "获得角色：\(character.name)", messager: currentSelectedPlayerID + 1, source: "说书人", type: 0, playerCharacters: [character.name], playerTeams: [team2Int(character.team)]))
                }else{
                  // give the demon a cover
                  allLogs.append(GameLogEntry(message: "", messager: 0, source: "说书人", type: 13, playerCharacters: [character.name], playerTeams: [team2Int(character.team)]))
                }
              }
            }
          }
        }
        .padding()
      }
      .background(Color.mainbg)
      .frame(width: 800)
      .clipShape(RoundedRectangle(cornerRadius: 20))
      .overlay(
        RoundedRectangle(cornerRadius: 20)
          .stroke(Color.black, lineWidth: 3)
      )
      .padding(.vertical, 50)
      .animation(.easeInOut(duration: 0.3), value: selectNewCharacter)
      .onAppear(){
        townsfolks = playableCharacters.filter { $0.team == "townsfolk" }
        outsiders = playableCharacters.filter { $0.team == "outsider" }
        minions = playableCharacters.filter { $0.team == "minion" }
        demons = playableCharacters.filter { $0.team == "demon" }
        travelers = travelersInPlay
        let travelersName = travelersInPlay.map { $0.name }
        officialTravelers = playableCharacters.filter { $0.team == "traveler" && !travelersName.contains($0.name) }
        selectedCharacterNames = playersAssignedCharacters.map { $0.name }
      }
      
      
    }
  }
}
