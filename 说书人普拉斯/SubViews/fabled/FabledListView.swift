//
//  FabledListView.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/25/25.
//

import SwiftUI

struct FabledListView: View {
  @Binding var selectedFabledCharacters: [Character]
  @Binding var showFabledCharactersSelection: Bool
  
  var body: some View{
    VStack{
      Text("传奇角色")
        .font(.system(size: 20, design: .rounded))
        .fontWeight(.bold)
        .foregroundColor(.black)
        .padding(.top, 20)
      ScrollView(showsIndicators: false) {
        ForEach(selectedFabledCharacters, id: \.id) { character in
          VStack(spacing: 0){
            CachedImageView(urlString: character.imageURL)
              .frame(width: 80, height: 80)
            Text(character.name)
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.black)
          }
          .onTapGesture(count: 2){
            selectedFabledCharacters.removeAll { $0.id == character.id }
          }
          .padding(.bottom, 5)
        }
      }
      Spacer()
      Image(systemName: "plus.circle.fill")
        .font(.system(size: 50, design: .rounded))
//          .frame(width: 100, height: 100)
        .foregroundColor(.black)
        .onTapGesture {
          showFabledCharactersSelection = true
        }
      .padding(.bottom, 10)
      .padding(.top, 5)
      .frame(maxWidth: .infinity)
    }
  }
}
