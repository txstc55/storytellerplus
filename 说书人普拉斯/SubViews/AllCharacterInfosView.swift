//
//  AllCharacterInfosView.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/23/25.
//

import SwiftUI

struct CharacterInfoCard: View {
  let character: Character
  let characterNameColor: Color
  var body: some View{
    HStack{
      CachedImageView(urlString: character.imageURL)
        .frame(width: 40, height: 40)
        .padding()
      VStack{
        Text(character.name)
          .font(.system(size: 25, design: .rounded))
          .fontWeight(.bold)
          .foregroundColor(characterNameColor)
          .frame(maxWidth: .infinity, alignment: .leading)
        Text(character.ability)
          .font(.system(size: 23, design: .rounded))
          .fontWeight(.semibold)
          .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
  }
}


struct AllCharacterInfosView: View {
  @Binding var playableCharacters: [Character]
  @Binding var showAllCharacterInfos: Bool
  
  @State private var townsfolks: [Character] = []
  @State private var outsiders: [Character] = []
  @State private var minions: [Character] = []
  @State private var demons: [Character] = []
  @State private var travelers: [Character] = []
  @State private var townsfolksMiddleIndex: Int = 0
  @State private var outsidersMiddleIndex: Int = 0
  @State private var minionsMiddleIndex: Int = 0
  @State private var demonsMiddleIndex: Int = 0
  @State private var travelersMiddleIndex: Int = 0
  
  
  var body: some View {
    ZStack {
      Color.mainbg.ignoresSafeArea(.all)
        .onTapGesture(count: 2) {
          showAllCharacterInfos = false
        }
      ScrollView(showsIndicators: false) {
        if (townsfolks.count > 0){
          HStack {
            VStack{
              Spacer()
              Text("镇")
                .font(.system(size: 30, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(Color.townsfolk)
              Text("民")
                .font(.system(size: 30, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(Color.townsfolk)
              Spacer()
            }
            .frame(maxHeight: .infinity)
            if (townsfolks.count == 1){
              CharacterInfoCard(character: townsfolks[0], characterNameColor: Color.townsfolk)
                .padding(.bottom, 10)
                .frame(maxHeight: .infinity, alignment: .top)
            }else{
              VStack{
                ForEach(0..<townsfolksMiddleIndex, id: \.self) { index in
                  let character = townsfolks[index]
                  CharacterInfoCard(character: character, characterNameColor: Color.townsfolk)
                    .padding(.bottom, 10)
                }
              }
              .frame(maxHeight: .infinity, alignment: .top)
              VStack{
                ForEach(townsfolksMiddleIndex..<townsfolks.count, id: \.self) { index in
                  let character = townsfolks[index]
                  CharacterInfoCard(character: character, characterNameColor: Color.townsfolk)
                    .padding(.bottom, 10)
                }
              }
              .frame(maxHeight: .infinity, alignment: .top)
            }
          } // end of hstack for the townsfolk characters
          
          Rectangle()
            .fill(Color.black)
            .frame(height: 4)
            .padding(.vertical, 30)
        }
        if (outsiders.count > 0){
          HStack {
            VStack{
              Spacer()
              Text("外")
                .font(.system(size: 30, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(Color.outsider)
              Text("来")
                .font(.system(size: 30, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(Color.outsider)
              Text("者")
                .font(.system(size: 30, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(Color.outsider)
              Spacer()
            }
            .frame(maxHeight: .infinity)
            if (outsiders.count == 1){
              CharacterInfoCard(character: outsiders[0], characterNameColor: Color.outsider)
                .padding(.bottom, 10)
                .frame(maxHeight: .infinity, alignment: .top)
            }else{
              VStack{
                ForEach(0..<outsidersMiddleIndex, id: \.self) { index in
                  let character = outsiders[index]
                  CharacterInfoCard(character: character, characterNameColor: Color.outsider)
                    .padding(.bottom, 10)
                }
              }
              .frame(maxHeight: .infinity, alignment: .top)
              VStack{
                ForEach(outsidersMiddleIndex..<outsiders.count, id: \.self) { index in
                  let character = outsiders[index]
                  CharacterInfoCard(character: character, characterNameColor: Color.outsider)
                    .padding(.bottom, 10)
                }
              }
              .frame(maxHeight: .infinity, alignment: .top)
            }
          } // end of hstack for the outsiders characters
          
          Rectangle()
            .fill(Color.black)
            .frame(height: 4)
            .padding(.vertical, 30)
        }
        if (minions.count > 0){
          HStack {
            VStack{
              Spacer()
              Text("爪")
                .font(.system(size: 30, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(Color.minion)
              Text("牙")
                .font(.system(size: 30, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(Color.minion)
              Spacer()
            }
            .frame(maxHeight: .infinity)
            if (minions.count == 1){
              CharacterInfoCard(character: minions[0], characterNameColor: Color.minion)
                .padding(.bottom, 10)
                .frame(maxHeight: .infinity, alignment: .top)
            }else{
              VStack{
                ForEach(0..<minionsMiddleIndex, id: \.self) { index in
                  let character = minions[index]
                  CharacterInfoCard(character: character, characterNameColor: Color.minion)
                    .padding(.bottom, 10)
                }
              }
              .frame(maxHeight: .infinity, alignment: .top)
              VStack{
                ForEach(minionsMiddleIndex..<minions.count, id: \.self) { index in
                  let character = minions[index]
                  CharacterInfoCard(character: character, characterNameColor: Color.minion)
                    .padding(.bottom, 10)
                }
              }
              .frame(maxHeight: .infinity, alignment: .top)
            }
          } // end of hstack for the minions characters
          Rectangle()
            .fill(Color.black)
            .frame(height: 4)
            .padding(.vertical, 30)
        }
        if (demons.count > 0){
          HStack {
            VStack{
              Spacer()
              Text("恶")
                .font(.system(size: 30, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(Color.demon)
              Text("魔")
                .font(.system(size: 30, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(Color.demon)
              Spacer()
            }
            .frame(maxHeight: .infinity)
            if (demons.count == 1){
              CharacterInfoCard(character: demons[0], characterNameColor: Color.demon)
                .padding(.bottom, 10)
                .frame(maxHeight: .infinity, alignment: .top)
            }else{
              
              VStack{
                ForEach(0..<demonsMiddleIndex, id: \.self) { index in
                  let character = demons[index]
                  CharacterInfoCard(character: character, characterNameColor: Color.demon)
                    .padding(.bottom, 10)
                }
              }
              .frame(maxHeight: .infinity, alignment: .top)
              VStack{
                ForEach(demonsMiddleIndex..<demons.count, id: \.self) { index in
                  let character = demons[index]
                  CharacterInfoCard(character: character, characterNameColor: Color.demon)
                    .padding(.bottom, 10)
                }
              }
              .frame(maxHeight: .infinity, alignment: .top)
            }
          } // end of hstack for the minions characters
          Rectangle()
            .fill(Color.black)
            .frame(height: 4)
            .padding(.vertical, 30)
        }
        if (travelers.count > 0){
          HStack {
            VStack{
              Spacer()
              Text("旅")
                .font(.system(size: 30, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(Color.traveler)
              Text("行")
                .font(.system(size: 30, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(Color.traveler)
              Text("者")
                .font(.system(size: 30, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(Color.traveler)
              Spacer()
            }
            .frame(maxHeight: .infinity)
            if (travelers.count == 1){
              CharacterInfoCard(character: travelers[0], characterNameColor: Color.traveler)
                .padding(.bottom, 10)
                .frame(maxHeight: .infinity, alignment: .top)
            }else{
              
              VStack{
                ForEach(0..<travelersMiddleIndex, id: \.self) { index in
                  let character = travelers[index]
                  CharacterInfoCard(character: character, characterNameColor: Color.traveler)
                    .padding(.bottom, 10)
                }
              }
              .frame(maxHeight: .infinity, alignment: .top)
              VStack{
                ForEach(travelersMiddleIndex..<travelers.count, id: \.self) { index in
                  let character = travelers[index]
                  CharacterInfoCard(character: character, characterNameColor: Color.traveler)
                    .padding(.bottom, 10)
                }
              }
              .frame(maxHeight: .infinity, alignment: .top)
            }
          } // end of hstack for the travelers characters
          Rectangle()
            .fill(Color.black)
            .frame(height: 4)
            .padding(.vertical, 30)
        }
      }
      .frame(width: 800)
      .padding(.horizontal, 30)
    }
    .onAppear {
      townsfolks = playableCharacters.filter { $0.team == "townsfolk" }
      outsiders  = playableCharacters.filter { $0.team == "outsider" }
      minions    = playableCharacters.filter { $0.team == "minion" }
      demons     = playableCharacters.filter { $0.team == "demon" }
      travelers  = playableCharacters.filter { $0.team == "traveler" }
      townsfolksMiddleIndex = computeMiddleIndex(for: townsfolks)
      outsidersMiddleIndex = computeMiddleIndex(for: outsiders)
      minionsMiddleIndex = computeMiddleIndex(for: minions)
      demonsMiddleIndex = computeMiddleIndex(for: demons)
      travelersMiddleIndex = computeMiddleIndex(for: travelers)
    }
  }
  
  func computeMiddleIndex(for array: [Character]) -> Int {
    return Int(ceil(Double(array.count) / 2))
  }
}
