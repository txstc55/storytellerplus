//
//  StoryTellerView.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/21/25.
//

import SwiftUI
import Flow

struct StoryTellerView: View {
  @Binding var currentView: Int
  @Binding var loadLast: Bool // if we just load the last game
  let playJSON: [[String: Any]]
  @State private var showExitConfirmation = false
  @State private var showMenu = false
  @State private var playerCount: Int = 0
  
  @State private var aliveCount: Int = 0
  @State private var playName: String = ""
  @State private var playAuthor: String = ""
  @State private var characters: [Character] = [] // store all the characters, this is for us to access the image urls
  @State private var playableCharacters: [Character] = [] // store all the characters accessible to players
  @State private var travelers: [Character] = [] // store all the traverlers accessible to players
  @State private var fabled: [Character] = []
  @State private var playersAssignedCharacters: [Character] = []
  
  @State private var playersIsAlive: [Bool] = []
  
  @State private var notPresentedGoodCharacters: [Character] = [defaultCharacter, defaultCharacter, defaultCharacter]
  
  // FOR ALERTS
  @State private var alertMessage: String = ""
  @State private var showAlert: Bool = false
  
  @State private var gameState: Int = 0 // 0 for setup, 1 for first night, 2 for day, 3 for night, 4 for voting
  
  // FOR SELECTING NEW CHARACTERS
  @State private var selectNewCharacter: Bool = false
  @State private var currentSelectedPlayerID: Int = 0
  
  // FOR JINXES
  @State private var jinxList: [Jinx] = []
  
  // FOR REMINDERS
  @State private var allReminders: [Reminder] = []
  @State private var playersStates: [[Reminder]] = [[]]
  @State private var selectNewReminder: Bool = false
  @State private var currentSelectedPlayerIDForReminder: Int = 0
  @State private var selectedReminderIndex: Int = 0
  
  // FOR CONVENIENCE
  var selectedCharacterNames: [String] {
    playersAssignedCharacters.map { $0.name }
  }
  
  // FOR THE LOG
  @State private var allLogs: [GameLogEntry] = []
  
  // FOR THE ORDER CHECKING
  @State private var firstNightOrder: Bool = true
  @State private var currentlyAwakePlayerIndex: Int = -666
  
  // FOR THE NOTEPAD
  @State private var showNotepad: Bool = false
  
  // FOR LISTING THE CHARACTER AND THEIR ABILITIES
  @State private var showCharacterAndAbilities: Bool = false
  
  // FOR CONVERSATIONS
  @State private var showConversation: Bool = false
//  @State private var recorder: AudioRecorder = AudioRecorder()
  
  // FOR SHOWING ALL CHARACTER INFOS
  @State private var showAllCharacterInfos: Bool = false
  
  // FOR VOTING
  @State private var playersHasDeathVote: [Bool] = []
  @State private var votingPhase: Int = 2
  @State private var nominationPhase: Int = 0
  
  // FOR FABLED CHARACTERS
  @State private var showFabledCharactersSelection: Bool = false
  @State private var selectedFabledCharacters: [Character] = []
  
  // FOR TIMER
  
  
  var body: some View {
    ZStack{
      if (selectNewCharacter){
        CharacterSelectionView(playableCharacters: $playableCharacters, travelersInPlay: $travelers, currentSelectedPlayerID: $currentSelectedPlayerID, selectNewCharacter: $selectNewCharacter, playersAssignedCharacters: $playersAssignedCharacters, notPresentedGoodCharacters: $notPresentedGoodCharacters, gameState: $gameState, allLogs: $allLogs)
          .zIndex(11)
      }
      
      // here we put a menu bar
      if showMenu{
        SubMenuView(playersAssignedCharacters: $playersAssignedCharacters, playersStates: $playersStates, playersIsAlive: $playersIsAlive, playersHasDeathVote: $playersHasDeathVote, playerCount: $playerCount, aliveCount: $aliveCount, playableCharacters: $playableCharacters, notPresentedGoodCharacters: $notPresentedGoodCharacters, showMenu: $showMenu, gameState: $gameState, allLogs: $allLogs)
          .offset(x: 65)
          .zIndex(10)
      }// end of the if loop for showing menu
      
      if selectNewReminder{
        TagView(allReminders: $allReminders, playersAssignedCharacters: $playersAssignedCharacters, playersStates: $playersStates, currentSelectedPlayerIDForReminder: $currentSelectedPlayerIDForReminder, selectNewReminder: $selectNewReminder, selectedReminderIndex: $selectedReminderIndex, characters: $characters, gameState: $gameState, allLogs: $allLogs, selectedFabledCharacters: $selectedFabledCharacters)
          .zIndex(12)
      }
      
      if showNotepad{
        NotepadView(playersAssignedCharacters: $playersAssignedCharacters, playableCharacters: $playableCharacters, showNotepad: $showNotepad)
          .zIndex(13)
      }
      if showConversation{
        ConversationView(playersAssignedCharacters: $playersAssignedCharacters, showConversation: $showConversation, allLogs: $allLogs)
          .zIndex(14)
      }
      if showAllCharacterInfos{
        AllCharacterInfosView(playableCharacters: $playableCharacters, showAllCharacterInfos: $showAllCharacterInfos, travelersInPlay: $travelers)
          .zIndex(15)
      }
      
      if showFabledCharactersSelection{
        FabledSelectionView(fabledInPlay: $fabled, characters: $characters, selectedFabledCharacters: $selectedFabledCharacters, showFabledCharactersSelection: $showFabledCharactersSelection)
          .zIndex(16)
      }
        
      
      HStack{
        // we do a menu bar here
        MenuView(firstNightOrder: $firstNightOrder, showMenu: $showMenu, showNotepad: $showNotepad, showConversation: $showConversation, showAllCharacterInfos: $showAllCharacterInfos, showExitConfirmation: $showExitConfirmation, currentView: $currentView, gameState: $gameState, allLogs: $allLogs, votingPhase: $votingPhase, nominationPhase: $nominationPhase)
          .alert("确定离开当前城镇吗？", isPresented: $showExitConfirmation) {
            Button("取消", role: .cancel) { }
            Button("确定", role: .destructive) {
              currentView = 0
            }
          } message: {
            Text("城镇内容将会被清空")
          }
          .background(Color.mainbg)
          .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(Color.black.opacity(1), lineWidth: 3))
        ScrollView(showsIndicators: false) {
          PlayersView(playersAssignedCharacters: $playersAssignedCharacters,
                      playersStates: $playersStates,
                      characters: $characters,
                      currentSelectedPlayerID: $currentSelectedPlayerID,
                      selectNewCharacter: $selectNewCharacter,
                      currentSelectedPlayerIDForReminder: $currentSelectedPlayerIDForReminder,
                      selectNewReminder: $selectNewReminder,
                      selectedReminderIndex: $selectedReminderIndex,
                      playersIsAlive: $playersIsAlive,
                      playersHasDeathVote: $playersHasDeathVote,
                      aliveCount: $aliveCount,
                      gameState: $gameState,
                      allLogs: $allLogs,
                      numCols: 3
          )
        }
        .frame(maxWidth: .infinity)
//        .padding(.horizontal, 10)
        .animation(.easeInOut(duration: 0.3), value: playersAssignedCharacters)
        .shadow(color: .black.opacity(0.2), radius: 5, x: 3, y: 5)
        //        Spacer()
        VStack{
          FabledListView(selectedFabledCharacters: $selectedFabledCharacters, showFabledCharactersSelection: $showFabledCharactersSelection)
            .animation(.easeInOut(duration: 0.3), value: selectedFabledCharacters)
            .padding(.horizontal)
            .frame(width: 110)
//            .frame(maxHeight: .infinity)
            .background(Color.mainbg)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
              RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black.opacity(1), lineWidth: 3)
            )
          TimerView(gameState: $gameState)
            .animation(.easeInOut(duration: 0.3), value: gameState)
            .frame(width: 110)
            .background(Color.mainbg)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
              RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black.opacity(1), lineWidth: 3)
            )
////            .frame(maxHeight: .infinity)
          FakeCover(playersAssignedCharacters: $playersAssignedCharacters, notPresentedGoodCharacters: $notPresentedGoodCharacters, selectNewCharacter: $selectNewCharacter, currentSelectedPlayerID: $currentSelectedPlayerID)
            .animation(.easeInOut(duration: 0.3), value: notPresentedGoodCharacters)
            .padding(.vertical, 20)
            .frame(width: 110)
            .background(Color.mainbg)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
              RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black.opacity(1), lineWidth: 3)
            )
//            .padding(.top, 10)
        }
        .zIndex(1)
        
        VStack{
          VStack(spacing: 2){
            PlayInfo(playName: $playName, playAuthor: $playAuthor)
              .padding(.top, 10)
              .padding(.bottom, 5)
              .padding(.horizontal, 10)
              .frame(maxWidth: .infinity)
            TeamInfo(playerCount: $playerCount)
              .padding(.horizontal, 10)
              .frame(maxWidth: .infinity)
              .padding(.vertical, 2)
            TeamActualInfo(playersAssignedCharacters: $playersAssignedCharacters)
              .padding(.horizontal, 10)
              .frame(maxWidth: .infinity)
              .padding(.vertical, 2)
            SurvivorInfo(playerCount: $playerCount, aliveCount: $aliveCount)
              .padding(.horizontal, 10)
              .padding(.bottom, 10)
              .frame(maxWidth: .infinity)
          } // end of the vstack for meta information
          .frame(height: 120)
          .background(Color.mainbg)
          .clipShape(RoundedRectangle(cornerRadius: 10))
          .overlay(
            RoundedRectangle(cornerRadius: 10)
              .stroke(Color.black.opacity(1), lineWidth: 3)
          )
          ExtraCareView(jinxList: $jinxList, playersAssignedCharacters: $playersAssignedCharacters, playersIsAlive: $playersIsAlive, votingPhase: $votingPhase, nominationPhase: $nominationPhase, gameState: $gameState)
            .frame(maxHeight: .infinity)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
              RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black.opacity(1), lineWidth: 3)
            )
            .padding(.top, 10)
          Group{
            if (gameState == 0){
              ExtraSetup(playableCharacters: $playableCharacters, playersAssignedCharacters: $playersAssignedCharacters)
            }else if (gameState == 1 || gameState == 3){
              OrderView(playersAssignedCharacters: $playersAssignedCharacters, playableCharacters: $playableCharacters, playersIsAlive: $playersIsAlive, firstNightOrder: $firstNightOrder, currentlyAwakePlayerIndex: $currentlyAwakePlayerIndex, allLogs: $allLogs)
            }else if (gameState == 2){
              VotingView(playersAssignedCharacters: $playersAssignedCharacters, playerCount: $playerCount, aliveCount: $aliveCount, playersIsAlive: $playersIsAlive, playersHasDeathVote: $playersHasDeathVote, allLogs: $allLogs, votingPhase: $votingPhase, nominationPhase: $nominationPhase)
            }
          } // end of group
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background(Color.mainbg)
          .clipShape(RoundedRectangle(cornerRadius: 10))
          .overlay(
            RoundedRectangle(cornerRadius: 10)
              .stroke(Color.black.opacity(1), lineWidth: 3)
          )
          .transition(.move(edge: .trailing))
          .padding(.top, 10)
        } // end of v stack for meta information
        .frame(width: 260)
        .padding(.trailing, 10)
        .animation(.easeInOut(duration: 0.3), value: gameState)
        //        .background(.gray)
      }
      
    } // end of the outer zstack
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .alert(isPresented: $showAlert) {
      Alert(title: Text("错误"), message: Text(alertMessage), dismissButton: .default(Text("确定")))
    }
    .onAppear(){
      if !loadLast{
        loadGameData(
          from: playJSON,
          characters: &characters,
          playableCharacters: &playableCharacters,
          travelers: &travelers,
          fabled: &fabled,
          allReminders: &allReminders,
          jinxList: &jinxList,
          playName: &playName,
          playAuthor: &playAuthor,
          alertMessage: &alertMessage,
          showAlert: &showAlert
        )
      }else{
        if let data = UserDefaults.standard.data(forKey: "SavedGameState") {
          do {
            let decoded = try JSONDecoder().decode(GameSaveData.self, from: data)
            
            self.playName = decoded.playName
            self.playAuthor = decoded.playAuthor
            self.gameState = decoded.gameState
            self.characters = decoded.characters
            self.playersAssignedCharacters = decoded.playersAssignedCharacters
            self.playersIsAlive = decoded.playersIsAlive
            self.playersHasDeathVote = decoded.playersHasDeathVote
            self.playerCount = decoded.playersAssignedCharacters.count
            self.aliveCount = decoded.aliveCount
            self.playableCharacters = decoded.playableCharacters
            self.travelers = decoded.travelers
            self.fabled = decoded.fabled
            self.notPresentedGoodCharacters = decoded.notPresentedGoodCharacters
            self.jinxList = decoded.jinxList
            self.allReminders = decoded.allReminders
            self.playersStates = decoded.playersStates
            self.currentSelectedPlayerID = decoded.currentSelectedPlayerID
            self.selectNewCharacter = decoded.selectNewCharacter
            self.currentSelectedPlayerIDForReminder = decoded.currentSelectedPlayerIDForReminder
            self.selectNewReminder = decoded.selectNewReminder
            self.selectedReminderIndex = decoded.selectedReminderIndex
            self.allLogs = decoded.allLogs
            self.firstNightOrder = decoded.firstNightOrder
            self.currentlyAwakePlayerIndex = decoded.currentlyAwakePlayerIndex
            self.selectedFabledCharacters = decoded.selectedFabledCharacters
            
            print("[Load] Successfully restored saved game.")
          } catch {
            print("[Load] Failed to decode saved data:", error)
            self.alertMessage = "读取存档失败。"
            self.showAlert = true
          }
        } else {
          print("[Load] No saved game found.")
          self.alertMessage = "没有找到存档。"
          self.showAlert = true
        }
      }
    }
    .onReceive(Timer.publish(every: 60, on: .main, in: .common).autoconnect()) { _ in
      let saveData = GameSaveData(
        playName: playName,
        playAuthor: playAuthor,
        gameState: gameState,
        characters: characters,
        playersAssignedCharacters: playersAssignedCharacters,
        playersIsAlive: playersIsAlive,
        playersHasDeathVote: playersHasDeathVote,
        aliveCount: aliveCount,
        playableCharacters: playableCharacters,
        travelers: travelers,
        fabled: fabled,
        notPresentedGoodCharacters: notPresentedGoodCharacters,
        jinxList: jinxList,
        allReminders: allReminders,
        playersStates: playersStates,
        currentSelectedPlayerID: currentSelectedPlayerID,
        selectNewCharacter: selectNewCharacter,
        currentSelectedPlayerIDForReminder: currentSelectedPlayerIDForReminder,
        selectNewReminder: selectNewReminder,
        selectedReminderIndex: selectedReminderIndex,
        allLogs: allLogs,
        firstNightOrder: firstNightOrder,
        currentlyAwakePlayerIndex: currentlyAwakePlayerIndex,
        selectedFabledCharacters: selectedFabledCharacters
      )
      
      if let encoded = try? JSONEncoder().encode(saveData) {
        UserDefaults.standard.set(encoded, forKey: "SavedGameState")
        print("[AutoSave] Game saved at \(Date())")
      } else {
        print("[AutoSave] Failed to encode game state.")
      }
    }
    .animation(.easeInOut(duration: 0.3), value: selectNewCharacter)
    .animation(.easeInOut(duration: 0.3), value: selectNewReminder)
    .animation(.easeInOut(duration: 0.3), value: showNotepad)
    .animation(.easeInOut(duration: 0.3), value: showConversation)
    .animation(.easeInOut(duration: 0.3), value: showAllCharacterInfos)
    .animation(.easeInOut(duration: 0.3), value: showFabledCharactersSelection)
  } // end of body
  
}

#Preview {
  StoryTellerView(currentView: .constant(1), loadLast: .constant(false), playJSON: test_json2)
}
