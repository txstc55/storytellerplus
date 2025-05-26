//
//  FabledSelectionView.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/25/25.
//
import SwiftUI
struct fabledCharacterCard: View{
  let character: Character
  var body: some View{
    HStack{
      CachedImageView(urlString: character.imageURL)
        .frame(width: 60, height: 60)
      VStack{
        Text(character.name)
          .font(.system(size: 25, design: .monospaced))
          .fontWeight(.bold)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal, 5)
          .padding(.vertical, 10)
        Text(character.ability)
          .font(.system(size: 23, design: .rounded))
          .fontWeight(.semibold)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal, 5)
          .padding(.bottom, 10)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
    .frame(maxWidth: .infinity)
  }
}


struct FabledSelectionView: View{
  @Binding var fabledInPlay: [Character] // the fabled that are defined in play
  @Binding var characters: [Character] // all the characters in play
  @Binding var selectedFabledCharacters: [Character] // the selected fabled characters
  @Binding var showFabledCharactersSelection: Bool
  @State private var selectedFabledCharactersName: [String] = []
  @State private var officialFabledCharacters: [Character] = []
    
  
  var body: some View{
    ZStack{
      Color.mainbg.opacity(0.3)
        .ignoresSafeArea(.all)
      ScrollView{
        VStack{
          Text("选择传说角色")
            .font(.system(size: 30, design: .monospaced))
            .fontWeight(.bold)
            .padding(.top, 20)
          HStack{
            Text("剧本传奇角色")
              .font(.system(size: 25, design: .monospaced))
              .fontWeight(.bold)
              .padding(.leading, 20)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.top, 20)
          .padding(.bottom, 5)
          ForEach(fabledInPlay, id: \.id) { character in
            fabledCharacterCard(character: character)
              .padding(.horizontal, 20)
              .padding(.vertical, 10)
              .opacity(selectedFabledCharactersName.contains(character.name) ? 1 : 0.5)
              .onTapGesture {
                if selectedFabledCharactersName.contains(character.name){
                  // do nothing
                }else{
                  selectedFabledCharacters.append(character)
                  showFabledCharactersSelection = false
                }
              }
          }
          HStack{
            Text("官方传奇角色")
              .font(.system(size: 25, design: .monospaced))
              .fontWeight(.bold)
              .padding(.leading, 20)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.top, 20)
          .padding(.bottom, 5)
          ForEach(officialFabledCharacters, id: \.id) { character in
            fabledCharacterCard(character: character)
              .padding(.horizontal, 20)
              .padding(.vertical, 10)
              .opacity(selectedFabledCharactersName.contains(character.name) ? 1 : 0.5)
              .onTapGesture {
                if selectedFabledCharactersName.contains(character.name){
                  // do nothing
                }else{
                  selectedFabledCharacters.append(character)
                  showFabledCharactersSelection = false
                }
              }
          }
          
        }
      }
      .background(Color.mainbg)
      .frame(width: 800, height: 800)
      .clipShape(RoundedRectangle(cornerRadius: 20))
      .overlay(RoundedRectangle(cornerRadius: 20)
        .stroke(Color.black, lineWidth: 3))
      
      
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
            showFabledCharactersSelection = false
          }
        }
    }
    .onAppear(){
      selectedFabledCharactersName = selectedFabledCharacters.map { $0.name }
      let fabledInPlayNames = fabledInPlay.map { $0.name }
      officialFabledCharacters = characters.filter { $0.team == "fabled" && !fabledInPlayNames.contains($0.name) }
    }
  }
}
