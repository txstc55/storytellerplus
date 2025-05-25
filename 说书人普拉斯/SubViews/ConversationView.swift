import SwiftUI

struct ConversationView: View {
  @Binding var playersAssignedCharacters: [Character]
  @Binding var showConversation: Bool
  @Binding var recorder: AudioRecorder
  @Binding var allLogs: [GameLogEntry]
  
  @State private var currentSelection: Int = 0
  @State private var inputText: String = ""
  
  var allUserIDs: [Int] {
    (0..<(playersAssignedCharacters.count + 1)).map { $0 }
  }
  
  var currentSpeaker: String {
    if currentSelection < playersAssignedCharacters.count {
      return "\(currentSelection + 1)号 \(playersAssignedCharacters[currentSelection].name)"
    } else {
      return "说书人"
    }
  }
  
  var body: some View {
    ZStack {
      Color.mainbg
        .edgesIgnoringSafeArea(.all)
      
      VStack {
        ScrollView {
          ScrollViewReader{ value in
            ForEach(allLogs.indices, id: \.self){index in
              let entry = allLogs[index]
              let type = entry.type
              if type == 0 || type == 3{
                HStack(spacing: 2){
                  let isPlayer = (entry.messager - 1) < playersAssignedCharacters.count
                  if isPlayer{
                    Text("\(entry.messager)")
                      .font(.system(size: 20, design: .rounded))
                      .fontWeight(.semibold)
                      .foregroundColor(.black)
                      .frame(width: 40, height: 40)
                      .overlay(Circle().stroke(Color.black, lineWidth: 2))
                      .padding(.horizontal, 2)
                    if (entry.characterName != ""){
                      Text(entry.characterName)
                        .font(.system(size: 20, design: .rounded))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.horizontal, 5)
                        .frame(height: 40)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                        .padding(.horizontal, 2)
                    }
                    Text(entry.message)
                      .font(.system(size: 20, design: .rounded))
                      .fontWeight(.semibold)
                      .foregroundColor(.black)
                      .padding(.horizontal, 10)
                      .frame(minHeight: 40)
                      .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                    Spacer()
                  }else{
                    Spacer()
                    Text(entry.message)
                      .font(.system(size: 20, design: .rounded))
                      .fontWeight(.semibold)
                      .foregroundColor(.black)
                      .padding(.horizontal, 10)
                      .frame(minHeight: 40)
                      .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                    Text("说")
                      .font(.system(size: 20, design: .rounded))
                      .fontWeight(.semibold)
                      .foregroundColor(.black)
                      .frame(width: 40, height: 40)
                      .overlay(Circle().stroke(Color.black, lineWidth: 2))
                      .padding(.horizontal, 2)
                  }
                }
                .padding(.vertical, 5)
              }else if type == 1 || type == 14 {
                HStack(spacing: 2){
                  Text("\(entry.messager)")
                    .font(.system(size: 20, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .frame(width: 40, height: 40)
                    .overlay(Circle().stroke(Color.black, lineWidth: 2))
                    .padding(.horizontal, 2)
                  Text(entry.characterName)
                    .font(.system(size: 20, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(.horizontal, 5)
                    .frame(height: 40)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                    .padding(.horizontal, 2)
                  Text("\(entry.message)，来源为：\(entry.source)")
                    .font(.system(size: 20, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(.horizontal, 10)
                    .frame(minHeight: 40)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                  Spacer()
                }
                .padding(.vertical, 5)
              }else if type == 2{
                if entry.messager < 0 {
                  HStack{
                    Text("\(entry.characterName) 被唤醒了")
                      .font(.system(size: 20, design: .rounded))
                      .fontWeight(.bold)
                      .foregroundColor(.black)
                      .padding(.horizontal, 5)
                      .padding(.vertical, 5)
                  }
                  .frame(maxWidth: .infinity)
                  .border(width: 2, edges: [.top, .bottom], color: .black)
                  .padding(.vertical, 5)
                }else{
                  HStack{
                    Text("\(entry.messager)号玩家 \(entry.characterName) 被唤醒了")
                      .font(.system(size: 20, design: .rounded))
                      .fontWeight(.bold)
                      .foregroundColor(.black)
                      .padding(.horizontal, 5)
                      .padding(.vertical, 5)
                  }
                  .frame(maxWidth: .infinity)
                  .border(width: 2, edges: [.top, .bottom], color: .black)
                  .padding(.vertical, 10)
                }
              }else if type == 4{
                HStack{
                  Text("\(entry.messager)号玩家 \(entry.characterName) \(entry.message)")
                    .font(.system(size: 20, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 5)
                }
                .frame(maxWidth: .infinity)
                .border(width: 2, edges: [.top, .bottom], color: .black)
                .padding(.vertical, 5)
              }else if type == 6{
                HStack(spacing: 2){
                  Text("\(entry.messager)")
                    .font(.system(size: 20, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .frame(width: 40, height: 40)
                    .overlay(Circle().stroke(Color.black, lineWidth: 2))
                    .padding(.horizontal, 2)
                  Text(entry.characterName)
                    .font(.system(size: 20, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(.horizontal, 5)
                    .frame(height: 40)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                    .padding(.horizontal, 2)
                  Text("死亡")
                    .font(.system(size: 20, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                    .padding(.horizontal, 10)
                    .frame(minHeight: 40)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: 2))
                  Spacer()
                }
                .padding(.vertical, 5)
              }else if type == 7{
                HStack(spacing: 2){
                  Text("\(entry.messager)")
                    .font(.system(size: 20, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .frame(width: 40, height: 40)
                    .overlay(Circle().stroke(Color.black, lineWidth: 2))
                    .padding(.horizontal, 2)
                  Text("进入游戏")
                    .font(.system(size: 20, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.horizontal, 10)
                    .frame(minHeight: 40)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
                  Spacer()
                }
                .padding(.vertical, 5)
              }else if type == 8{
                HStack{
                  Text("游戏开始")
                    .font(.system(size: 30, design: .rounded))
                    .fontWeight(.black)
                    .foregroundColor(.black)
                    .padding(.horizontal, 2)
                    .padding(.vertical, 10)
                }
                .frame(maxWidth: .infinity)
                .border(width: 3, edges: [.top, .bottom], color: .black)
                .padding(.vertical, 15)
              }else if type == 9{
                HStack{
                  Text("进入第一晚")
                    .font(.system(size: 30, design: .rounded))
                    .fontWeight(.black)
                    .foregroundColor(.black)
                    .padding(.horizontal, 2)
                    .padding(.vertical, 10)
                }
                .frame(maxWidth: .infinity)
                .border(width: 3, edges: [.top, .bottom], color: .black)
                .padding(.vertical, 15)
              }else if type == 10{
                HStack{
                  Text("进入白天")
                    .font(.system(size: 30, design: .rounded))
                    .fontWeight(.black)
                    .foregroundColor(.black)
                    .padding(.horizontal, 2)
                    .padding(.vertical, 10)
                }
                .frame(maxWidth: .infinity)
                .border(width: 3, edges: [.top, .bottom], color: .black)
                .padding(.vertical, 15)
              }else if type == 11{
                HStack{
                  Text("进入夜晚")
                    .font(.system(size: 30, design: .rounded))
                    .fontWeight(.black)
                    .foregroundColor(.black)
                    .padding(.horizontal, 2)
                    .padding(.vertical, 10)
                }
                .frame(maxWidth: .infinity)
                .border(width: 3, edges: [.top, .bottom], color: .black)
                .padding(.vertical, 15)
              }else if type == 12{
                HStack(spacing: 2){
                  Text("\(entry.messager)")
                    .font(.system(size: 20, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .frame(width: 40, height: 40)
                    .overlay(Circle().stroke(Color.black, lineWidth: 2))
                    .padding(.horizontal, 2)
                  Text(entry.characterName)
                    .font(.system(size: 20, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(.horizontal, 5)
                    .frame(height: 40)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                    .padding(.horizontal, 2)
                  Text("复活")
                    .font(.system(size: 20, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                    .padding(.horizontal, 10)
                    .frame(minHeight: 40)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 2))
                  Spacer()
                }
                .padding(.vertical, 5)
              }else if type == 13{
                HStack{
                  Text("恶魔得知不在场身份: \(entry.message)")
                    .font(.system(size: 25, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.horizontal, 2)
                    .padding(.vertical, 10)
                }
                .frame(maxWidth: .infinity)
                .border(width: 3, edges: [.top, .bottom], color: .black)
                .padding(.vertical, 10)
              }
            }
            .onChange(of: allLogs.count) { _ in
              // Scroll to bottom (last ID), anchor to bottom
              withAnimation {
                value.scrollTo(allLogs.count - 1, anchor: .bottom)
              }
            }
            .onAppear(){
              withAnimation {
                value.scrollTo(allLogs.count - 1, anchor: .bottom)
              }
            }
          }
        }
        
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .padding(.horizontal, 10)
        .padding(.vertical, 20)
        Spacer()
        HStack {
          Picker(selection: $currentSelection, label: Text(currentSpeaker).font(.system(size: 20, design: .rounded))
            .fontWeight(.bold)
            .foregroundColor(.black)
            .lineLimit(1)               // <-- Restrict to 1 line
            .truncationMode(.tail)     // <-- Show "..." if needed
          ) {
            ForEach(allUserIDs, id: \.self) { item in
              Text(item < playersAssignedCharacters.count
                   ? "\(item + 1)号 \(playersAssignedCharacters[item].name)"
                   : "说书人")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.black) // <-- this makes each option black
              .tag(item)
              
            }
          }
          .pickerStyle(.menu)
          .padding(.horizontal, 5)
          .accentColor(.black)
          .frame(width: 150)
          .padding(.vertical, 5)
          .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
          TextField("    输入聊天内容", text: $inputText)
            .font(.system(size: 20, design: .rounded))
            .fontWeight(.semibold)
            .foregroundColor(.black)
            .frame(width: 500)
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
          Button(action: {
            // send message
            if inputText != "" {
              allLogs.append(GameLogEntry(message: inputText, messager: currentSelection < playersAssignedCharacters.count ? (currentSelection + 1) : 21, source: "", type: 0, characterName: currentSelection < playersAssignedCharacters.count ? playersAssignedCharacters[currentSelection].name : "说书人"))
              inputText = ""
            }
          }){
            Text("发送")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.semibold)
              .foregroundColor(.black)
              .padding(.horizontal, 10)
              .padding(.vertical, 10)
            
          }
          .padding(.horizontal, 5)
          .frame(maxWidth: .infinity)
          .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 2))
          
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 5)
      }
      .frame(width: 800, height: 600)
      .clipShape(RoundedRectangle(cornerRadius: 20))
      .overlay(
        RoundedRectangle(cornerRadius: 20)
          .stroke(.black, lineWidth: 2)
      )
      Image(systemName: "xmark")
        .font(.system(size: 14, weight: .bold))
        .foregroundColor(.black)
        .frame(width: 30, height: 30)
        .background(Color.mainbg)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.black, lineWidth: 2))
        .padding(10)
        .offset(x: 395, y: -295)
        .onTapGesture {
          withAnimation(.easeInOut(duration: 0.3)) {
            showConversation = false
          }
        }
    }
  }
}

