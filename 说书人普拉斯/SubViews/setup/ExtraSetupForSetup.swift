//
//  ExtraSetupForSetup.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 6/30/25.
//

import SwiftUI

struct ExtraSetupForSetup: View {
  @Binding var playableCharacters: [Character]
  @Binding var selectedCharacters: [Character]
  @Binding var selectionState: Int
  @Binding var showSetup: Bool
  private var assignedCharacterNames: [String] {
    selectedCharacters.map { $0.name }
  }
  var body: some View {
    VStack{
      ScrollView(showsIndicators: false) {
        Text("设置调整")
          .font(.system(size: 25, design: .rounded))
          .fontWeight(.bold)
          .padding(.top, 10)
        VStack{
          ForEach($playableCharacters, id: \.id) { character in
            if (character.setup.wrappedValue){
              HStack{
                CachedImageView(urlString: character.imageURL.wrappedValue)
                  .frame(width: 50, height: 50)
                VStack(alignment: .leading){
                  Text(character.name.wrappedValue)
                    .font(.system(size: 20, design: .rounded))
                    .fontWeight(.bold)
                  Text(character.ability.wrappedValue)
                    .font(.system(size: 15, design: .rounded))
                    .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
              }
              .padding(.horizontal, 10)
              .padding(.vertical, 10)
            }
          }
        }
        .padding(.bottom, 20)
      }
      .frame(maxWidth: .infinity)
      .background(Color.mainbg)
      .clipShape(RoundedRectangle(cornerRadius: 10))
      .overlay(
        RoundedRectangle(cornerRadius: 10)
          .stroke(Color.black.opacity(1), lineWidth: 3)
      )
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
          selectionState += 1
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
