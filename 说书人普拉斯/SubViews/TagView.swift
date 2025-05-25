//
//  TagView.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/22/25.
//

import SwiftUI
import Flow

struct TagView: View{
  @Binding var allReminders: [Reminder]
  @Binding var playersAssignedCharacters: [Character]
  @Binding var playersStates: [[Reminder]]
  @Binding var currentSelectedPlayerIDForReminder: Int
  @Binding var selectNewReminder: Bool
  @Binding var selectedReminderIndex: Int
  @Binding var characters: [Character]
  @Binding var gameState: Int
  @Binding var allLogs: [GameLogEntry]
  @State private var showTagEditor: Bool = false
  @State private var newTagName: String = ""
  
  var selectedCharacterNames: [String] {
    playersAssignedCharacters.map { $0.name }
  }
  var body: some View{
    ZStack{
      Color.mainbg.opacity(0.3)
        .edgesIgnoringSafeArea(.all)
        .zIndex(1)
      if showTagEditor{
        ZStack{
          Color.mainbg.opacity(0.5)
            .edgesIgnoringSafeArea(.all)
          VStack{
            Spacer()
            HStack{
              Text("标签名字： ")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.bold)
              TextField("输入标签名字", text: $newTagName)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(.clear)
            }
            
            Spacer()
            HStack{
              Button(action: {
                if newTagName != ""{
                  allReminders.append(Reminder(from: "说书人", effect: newTagName, isGlobal: true))
                  showTagEditor = false
                  newTagName = ""
                  selectedReminderIndex = allReminders.count - 1
                }
              }){
                Text("确认")
                  .font(.system(size: 15, design: .rounded))
                  .fontWeight(.bold)
                  .foregroundColor(.black)
                  .padding(.horizontal, 20)
                  .padding(.vertical, 8)
                  .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 2))
              }
              Button(action: {
                showTagEditor = false
              }){
                Text("取消")
                  .font(.system(size: 15, design: .rounded))
                  .fontWeight(.bold)
                  .foregroundColor(.black)
                  .padding(.horizontal, 20)
                  .padding(.vertical, 8)
                  .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 2))
              }
              
            }
            .padding(.bottom, 10)
          }
          .padding(.horizontal, 20)
          .frame(width: 300, height: 200)
          .background(.ultraThinMaterial)
          .cornerRadius(20)
          .overlay(
            RoundedRectangle(cornerRadius: 20)
              .stroke(Color.black, lineWidth: 3)
          )
        }
        .zIndex(3)
      }
      
      VStack{
        ScrollView{
          HStack{
            Text("为\(currentSelectedPlayerIDForReminder + 1)号玩家选择标记")
              .font(.system(size: 25, design: .rounded))
              .fontWeight(.bold)
          }
          .padding(.top, 25)
          .frame(maxWidth: .infinity)
          HFlow(itemSpacing: 15){
            ForEach(allReminders.indices, id: \.self){index in
              let reminder = allReminders[index]
              if (selectedCharacterNames.contains(reminder.from) || reminder.isGlobal){
                HStack(spacing: 0){
                  let imageURL = getImageURL(name: reminder.from, characters: characters)
                  if (imageURL != ""){
                    CachedImageView(urlString: getImageURL(name: reminder.from, characters: characters))
                      .frame(width: 50, height: 50)
                      .padding(.horizontal, 5)
                  }else{
                    Color.clear
                      .frame(width: 10, height: 50)
                  }
                  //                .padding(.vertical, 5)
                  Text(reminder.effect)
                    .font(.system(size: 18, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.trailing, 10)
                    .padding(.vertical, 5)
                }
                .overlay(RoundedRectangle(cornerRadius: 10)
                  .stroke(Color.black, lineWidth: 2))
                .onTapGesture {
                  selectedReminderIndex = index
                }
                .scaleEffect(selectedReminderIndex == index ? 1.1 : 0.9)
                .animation(.easeInOut(duration: 0.3), value: selectedReminderIndex)
              }
            }
            Button(action: {
              showTagEditor = true
            }){
              Image(systemName: "plus")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundColor(.black)
                .frame(width: 50, height: 50) // This defines the container size
                .overlay(
                  Circle()
                    .stroke(Color.black, lineWidth: 2)
                )
            }
            .scaleEffect(0.9)
            .contentShape(Circle())
            
          }
          .animation(.easeInOut(duration: 0.3), value: selectedCharacterNames)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal, 20)
          //      .frame(maxWidth: .infinity)
          
        }
        Spacer()
        HStack{
          Button(action: {
            selectNewReminder = false
            if selectedReminderIndex >= 0 {
              let selectedReminder = allReminders[selectedReminderIndex]
              playersStates[currentSelectedPlayerIDForReminder].append(selectedReminder)
              if gameState != 0 {
                allLogs.append(GameLogEntry(message: "获得标记：\(selectedReminder.effect)", messager: currentSelectedPlayerIDForReminder + 1, source: selectedReminder.from, type: 1, characterName: playersAssignedCharacters[currentSelectedPlayerIDForReminder].name))
              }
            }
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
            selectNewReminder = false
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
      } // end of vstack
      .zIndex(2)
      .background(Color.mainbg)
      .cornerRadius(20)
      .frame(width: 600, height: 800)
      .overlay(
        RoundedRectangle(cornerRadius: 20)
          .stroke(Color.black, lineWidth: 3)
      )
    } // end of zstack
    .animation(.easeInOut(duration: 0.3), value: showTagEditor)
  }
}

//#Preview{
//  TagView(allReminders: .constant([]), playersAssignedCharacters: .constant([]), playersStates: .constant([[]]), currentSelectedPlayerIDForReminder: .constant(0), selectNewReminder: .constant(true), selectedReminderIndex: .constant(0), characters: .constant([]))
//    
//}
