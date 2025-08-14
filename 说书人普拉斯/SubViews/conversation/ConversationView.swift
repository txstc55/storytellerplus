import SwiftUI
import Flow
struct playerNumberCircle: View {
  let playerNumber: Int
  let playerTeam: Int
  var body: some View{
    let isPlayer: Bool = playerNumber < 21
    let number: String = isPlayer ? "\(playerNumber)" : "说"
    let teamColor: Color = teamid2Color(playerTeam)
    Text(number)
      .font(.system(size: 20, design: .rounded))
      .fontWeight(.semibold)
      .foregroundColor(.goodTextBg)
      .frame(width: 40, height: 40)
      .background(Circle().fill(teamColor))
      .padding(.horizontal, 2)
  }
}

struct playerCharacterBox: View{
  let playerCharacter: String
  let playerTeam: Int
  var body: some View{
    Text(playerCharacter)
      .font(.system(size: 20, design: .rounded))
      .fontWeight(.semibold)
      .foregroundColor(.goodTextBg)
      .padding(.horizontal, 10)
      .frame(height: 40)
      .background(RoundedRectangle(cornerRadius: 10).fill(teamid2Color(playerTeam)))
      .padding(.horizontal, 2)
  }
}



struct ConversationLogView: View{
  @Binding var playersAssignedCharacters: [Character]
  @Binding var showConversation: Bool
  //  @Binding var recorder: AudioRecorder
  @Binding var allLogs: [GameLogEntry]
  @State private var nightCount: Int = 0
  @State private var dayCount: Int = 0
  var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      ForEach(allLogs.indices, id: \.self){index in
        let entry = allLogs[index]
        let type = entry.type
        if type == 0 {
          // MARK: 0 for character assignment
          HStack{
            // this is assigning character
            playerNumberCircle(playerNumber: entry.messager, playerTeam: entry.playerTeams[0])
            HStack(spacing: 2){
              Text("获得角色: ")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.black)
              playerCharacterBox(playerCharacter: entry.playerCharacters[0], playerTeam: entry.playerTeams[0])
            }
            .padding(.horizontal, 10)
            .frame(minHeight: 50)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
            Spacer()
          }
          .padding(.vertical, 3)
        }else if type == 1 {
          // MARK: 1 for tag assignment
          HStack{
            playerNumberCircle(playerNumber: entry.messager, playerTeam: entry.playerTeams[0])
            playerCharacterBox(playerCharacter: entry.playerCharacters[0], playerTeam: entry.playerTeams[0])
            HStack(spacing: 2){
              Text("获得标签: ")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.black)
              +
              Text("\(entry.message)")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(teamid2Color(entry.playerTeams[1]))
              +
              Text("，来源为：")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.black)
              playerCharacterBox(playerCharacter: entry.playerCharacters[1], playerTeam: entry.playerTeams[1])
            }
            .padding(.horizontal, 10)
            .frame(minHeight: 50)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
            Spacer()
          }
          .padding(.vertical, 3)
        }else if type == 2{
          // MARK: 2 for character wake up
          if entry.messager < 0 {
            HStack(spacing: 4){
              playerCharacterBox(playerCharacter: entry.characterName, playerTeam: entry.playerTeams[0])
              Text("被唤醒了")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.horizontal, 5)
                .padding(.vertical, 5)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .border(width: 2, edges: [.top, .bottom], color: .black)
            .padding(.vertical, 5)
          }else{
            HStack(spacing: 4){
              playerNumberCircle(playerNumber: entry.messager, playerTeam: entry.playerTeams[0])
              playerCharacterBox(playerCharacter: entry.characterName, playerTeam: entry.playerTeams[0])
              Text("被唤醒了")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.horizontal, 5)
                .padding(.vertical, 5)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .border(width: 2, edges: [.top, .bottom], color: .black)
            .padding(.vertical, 10)
          }
        }else if type == 3{
          // MARK: 3 for player message
          let isPlayer = (entry.messager) < playersAssignedCharacters.count
          HStack{
            if isPlayer{
              playerNumberCircle(playerNumber: entry.messager, playerTeam: entry.playerTeams[0])
              playerCharacterBox(playerCharacter: entry.playerCharacters[0], playerTeam: entry.playerTeams[0])
              Text(entry.message)
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding(.horizontal, 10)
                .frame(minHeight: 50)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
              Spacer()
            }else{
              Spacer()
              Text(entry.message)
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding(.horizontal, 10)
                .frame(minHeight: 50)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
              playerNumberCircle(playerNumber: 21, playerTeam: 5) // 说书人
            }
          }
          .padding(.vertical, 3)
        }else if type == 4{
          // MARK: 4 for nomination
          HFlow(itemSpacing: 2){
            let isPlayer = (entry.messager) < 21
            if isPlayer{
              playerNumberCircle(playerNumber: entry.messager, playerTeam: entry.playerTeams[0])
              Text("号玩家")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.horizontal, 5)
                .padding(.vertical, 5)
            }
            playerCharacterBox(playerCharacter: entry.characterName, playerTeam: entry.playerTeams[0])
            Text("提名了")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.black)
              .padding(.horizontal, 5)
              .padding(.vertical, 5)
            if entry.playerTeams[1] != 5{
              playerNumberCircle(playerNumber: entry.playerNumbers[1], playerTeam: entry.playerTeams[1])
              Text("号玩家")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.horizontal, 5)
                .padding(.vertical, 5)
            }
            playerCharacterBox(playerCharacter: entry.playerCharacters[1], playerTeam: entry.playerTeams[1])
          }
          .padding()
          .frame(maxWidth: .infinity)
          .border(width: 2, edges: [.top, .bottom], color: .black)
          .padding(.vertical, 5)
        }else if type == 5{
          // MARK: 5 for voting
          HFlow(itemSpacing: 2){
            Text("投票结果: ")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.black)
              .padding(.horizontal, 5)
              .padding(.vertical, 5)
            ForEach(entry.playerNumbers.indices, id: \.self) { i in
              let playerNumber = entry.playerNumbers[i]
              let playerCharacter = entry.playerCharacters[i]
              let playerTeam = entry.playerTeams[i]
              if playerNumber < 21 {
                playerNumberCircle(playerNumber: playerNumber, playerTeam: playerTeam)
                playerCharacterBox(playerCharacter: playerCharacter, playerTeam: playerTeam)
              }else{
                playerCharacterBox(playerCharacter: playerCharacter, playerTeam: playerTeam)
              }
              if i < entry.playerNumbers.count - 1 {
                Text(", ")
                  .font(.system(size: 20, design: .rounded))
                  .fontWeight(.bold)
                  .foregroundColor(.black)
                  .padding(.horizontal, 5)
                  .padding(.vertical, 5)
              }
            }
          }
          .padding()
          .frame(maxWidth: .infinity)
          .border(width: 2, edges: [.top, .bottom], color: .black)
          .padding(.vertical, 5)
        }else if type == 6{
          // MARK: 6 for death
          HStack{
            playerNumberCircle(playerNumber: entry.playerNumbers[0], playerTeam: entry.playerTeams[0])
            playerCharacterBox(playerCharacter: entry.playerCharacters[0], playerTeam: entry.playerTeams[0])
            Text("死亡")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.red)
              .padding(.horizontal, 5)
              .padding(.vertical, 5)
          }
          .padding()
          .frame(maxWidth: .infinity)
          .border(width: 2, edges: [.top, .bottom], color: .black)
          .padding(.vertical, 5)
        }else if type == 7{
          // MARK: 7 for player enter game
          HStack{
            Text("\(entry.playerNumbers[0])")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.semibold)
              .foregroundColor(.black)
              .frame(width: 40, height: 40)
              .overlay(Circle().stroke(Color.black, lineWidth: 2))
              .padding(.horizontal, 2)
            HStack(spacing: 2){
              Text("进入游戏")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.horizontal, 10)
                .frame(minHeight: 40)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
              Spacer()
            }
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
        }else if type == 9 {
          HStack{
            Text("进入第1个夜晚")
              .font(.system(size: 30, design: .rounded))
              .fontWeight(.black)
              .foregroundColor(.black)
              .padding(.horizontal, 2)
              .padding(.vertical, 10)
          }
          .frame(maxWidth: .infinity)
          .border(width: 3, edges: [.top, .bottom], color: .black)
          .padding(.vertical, 15)
        }else if type == 10 {
          HStack{
            let dayCount = allLogs.prefix(index + 1).filter { $0.type == 10 }.count
            Text("进入第\(dayCount)个白天")
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
            let nightCount = allLogs.prefix(index + 1).filter { $0.type == 11 }.count
            Text("进入第\(nightCount+1)个夜晚")
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
          // MARK: 12 for revival
          HStack{
            playerNumberCircle(playerNumber: entry.playerNumbers[0], playerTeam: entry.playerTeams[0])
            playerCharacterBox(playerCharacter: entry.playerCharacters[0], playerTeam: entry.playerTeams[0])
            Text("复活")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.green)
              .padding(.horizontal, 5)
              .padding(.vertical, 5)
          }
          .padding()
          .frame(maxWidth: .infinity)
          .border(width: 2, edges: [.top, .bottom], color: .black)
          .padding(.vertical, 5)
        }else if type == 13{
          // MARK: 13 for cover for demon
          HStack(spacing: 2){
            Text("恶魔得知伪装: ")
              .font(.system(size: 25, design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.black)
              .padding(.horizontal, 2)
              .padding(.vertical, 10)
            playerCharacterBox(playerCharacter: entry.playerCharacters[0], playerTeam: entry.playerTeams[0])
          }
          .frame(maxWidth: .infinity)
          .border(width: 3, edges: [.top, .bottom], color: .black)
          .padding(.vertical, 10)
        }else if type == 14{
          // MARK: 14 for removing tags
          HStack{
            playerNumberCircle(playerNumber: entry.messager, playerTeam: entry.playerTeams[0])
            playerCharacterBox(playerCharacter: entry.playerCharacters[0], playerTeam: entry.playerTeams[0])
            HStack(spacing: 2){
              Text("失去标签: ")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.black)
              +
              Text("\(entry.message)")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(teamid2Color(entry.playerTeams[1]))
              +
              Text("，来源为：")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.black)
              playerCharacterBox(playerCharacter: entry.playerCharacters[1], playerTeam: entry.playerTeams[1])
            }
            .padding(.horizontal, 10)
            .frame(minHeight: 50)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
            Spacer()
          }
          .padding(.vertical, 3)
        }else if type == 15{
          // MARK: 15 for inversing tags
          HStack{
            playerNumberCircle(playerNumber: entry.messager, playerTeam: entry.playerTeams[0])
            playerCharacterBox(playerCharacter: entry.playerCharacters[0], playerTeam: entry.playerTeams[0])
            HStack(spacing: 2){
              Text("倒置标签: ")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.black)
              +
              Text("\(entry.message)")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(teamid2Color(entry.playerTeams[1]))
              +
              Text("，来源为：")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.black)
              playerCharacterBox(playerCharacter: entry.playerCharacters[1], playerTeam: entry.playerTeams[1])
            }
            .padding(.horizontal, 10)
            .frame(minHeight: 50)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
            Spacer()
          }
          .padding(.vertical, 3)
        }
      }
    }
  }
}



struct ConversationView: View {
  @Binding var playersAssignedCharacters: [Character]
  @Binding var showConversation: Bool
//  @Binding var recorder: AudioRecorder
  @Binding var allLogs: [GameLogEntry]
  
  @State private var currentSelection: Int
  @State private var inputText: String = ""
  init(playersAssignedCharacters: Binding<[Character]>, showConversation: Binding<Bool>, allLogs: Binding<[GameLogEntry]>) {
    self._playersAssignedCharacters = playersAssignedCharacters
    self._showConversation = showConversation
//    self._recorder = recorder
    self._allLogs = allLogs
    
    // default to last in list, which is "说书人"
    self._currentSelection = State(initialValue: playersAssignedCharacters.wrappedValue.count)
  }
  
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
        .onTapGesture(count: 2) {
          withAnimation(.easeInOut(duration: 0.3)) {
            showConversation = false
          }
        }
      
      VStack {
        ScrollView {
          ScrollViewReader{ value in
            ConversationLogView(playersAssignedCharacters: $playersAssignedCharacters, showConversation: $showConversation, allLogs: $allLogs)
            .onChange(of: allLogs.count) {_, _ in
              //               Scroll to bottom (last ID), anchor to bottom
              withAnimation {
                value.scrollTo(allLogs.count - 1, anchor: .bottom)
              }
            }
            .padding(.vertical, 20)
            .onAppear(){
              withAnimation {
                value.scrollTo(allLogs.count - 1, anchor: .bottom)
              }
            }
          }
        }
        .scrollDismissesKeyboard(.interactively)
        .frame(maxWidth: .infinity)
        //        .frame(maxHeight: .infinity)
        .padding(.horizontal, 10)
        .padding(.vertical, 20)
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
          TextField("输入聊天内容", text: $inputText)
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
              allLogs.append(GameLogEntry(message: inputText, messager: currentSelection < playersAssignedCharacters.count ? (currentSelection + 1) : 21, source: "", type: 3, characterName: currentSelection < playersAssignedCharacters.count ? playersAssignedCharacters[currentSelection].name : "说书人", playerCharacters: [currentSelection < playersAssignedCharacters.count ? playersAssignedCharacters[currentSelection].name : "说书人"], playerTeams: [currentSelection < playersAssignedCharacters.count ? team2Int(playersAssignedCharacters[currentSelection].team) : 5]))
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
      .frame(width: 800)
      .clipShape(RoundedRectangle(cornerRadius: 20))
      .overlay(
        RoundedRectangle(cornerRadius: 20)
          .stroke(.black, lineWidth: 3)
      )
      .padding(.vertical, 50)
      //      .ignoresSafeArea(.keyboard)
    }
  }
}

