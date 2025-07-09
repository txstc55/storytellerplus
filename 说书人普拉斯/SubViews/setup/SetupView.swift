//
//  SetupView.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 6/29/25.
//

import SwiftUI
import Flow

struct SetupView: View {
  @Binding var playableCharacters: [Character]
  @Binding var playersAssignedCharacters: [Character]
  @Binding var playerCount: Int
  
  @Binding var showSetup: Bool
  let startDate = Date() // for the animation effect
  @State private var selectionState: Int = 0 // 0 for choosing number of demon, 1 for letting user choose demon, 2 for show demon, 3 for selecting number of minions, 4 for letting user choose minions, 5 for show minions, 6 for selecting number of outsiders, 7 for letting user choose outsiders, 8 for show outsiders, 9 for selecting number of townsfolk, 10 for letting user choose townsfolk, 11 for show townsfolk, then 12 for letting user pick the actual characters 1 by 1
  @State private var selectedCharacters: [Character] = []
  @State private var selectedTeamCounts: [Int] = [0, 0, 0, 0] // [demon, minion, outsider, townsfolk]
  @State private var cardSelected: [Bool] = [] // just placeholders
  @State private var playableCharactersShuffled: [Character] = []
  @State private var extraRepeatedCharacters: [Character] = [] // for repeated characters
  @State private var extraRepeatedCardSelected: [Bool] = []
  @State private var playerChoices: [Int] = []
  let teamNames = ["恶魔", "爪牙", "外来者", "镇民"]
  let teamNameEnglish = ["demon", "minion", "outsider", "townsfolk"]
  let teamColors: [Color] = [.demon, .minion, .outsider, .townsfolk]
  var body: some View{
    ZStack{
      // setup the background color effect
      TimelineView(.periodic(from: .now, by: 1.0 / 15.0)) { context in
        let time = Float(context.date.timeIntervalSince(startDate))
        ZStack{
          Color.white
            .colorEffect(ShaderLibrary.dotPatternShader(
              .float(80),
              .float(1),
              .float(time)))
            .edgesIgnoringSafeArea(.all)
        }
      } // end of timeline view
      
      
      Group{
        if selectionState == 0 || selectionState == 3 || selectionState == 6 || selectionState == 9{
          HStack{
            SetupCount(playerCount: $playerCount, selectionState: $selectionState, selectedTeamCounts: $selectedTeamCounts)
              .frame(maxWidth: .infinity, alignment: .center)
            
            ExtraSetupForSetup(playableCharacters: $playableCharacters, selectedCharacters: $selectedCharacters, selectionState: $selectionState, showSetup: $showSetup)
          }
        }
      }// end of group 1
      Group{
        if selectionState == 1 || selectionState == 4 || selectionState == 7 || selectionState == 10{
          SetupBlindPick(playableCharactersShuffled: $playableCharactersShuffled, selectedTeamCounts: $selectedTeamCounts, cardSelected: $cardSelected, selectionState: $selectionState)
            .frame(maxHeight: .infinity)
        }
      }
      Group{
        if selectionState == 2 || selectionState == 5 || selectionState == 8 || selectionState == 11{
          HStack{
            SetupCheck(playableCharacters: $playableCharacters, playableCharactersShuffled: $playableCharactersShuffled, cardSelected: $cardSelected, extraRepeatedCharacters: $extraRepeatedCharacters, extraRepeatedCardSelected: $extraRepeatedCardSelected, playerCount: $playerCount, selectionState: $selectionState)
              .frame(maxWidth: .infinity, alignment: .center)
            ExtraSetupForSetup(playableCharacters: $playableCharacters, selectedCharacters: $selectedCharacters, selectionState: $selectionState, showSetup: $showSetup)
          }
        }
      }
      Group{
        if selectionState == 12{
          SetupPlayerPick(playableCharactersShuffled: $playableCharactersShuffled, playersAssignedCharacters: $playersAssignedCharacters, extraRepeatedCharacters: $extraRepeatedCharacters,cardSelected: $cardSelected, extraRepeatedCardSelected: $extraRepeatedCardSelected, playerChoices: $playerChoices, selectionState: $selectionState, showSetup: $showSetup)
        }
      }
      
    }
    .onAppear{
      playableCharactersShuffled = playableCharacters.shuffled()
      for _ in 0..<playableCharactersShuffled.count {
        cardSelected.append(false) // initialize the selection state
      }
      for _ in 0..<playerCount {
        playerChoices.append(-1) // initialize the player choices
      }
    }
    .animation(.easeInOut(duration: 0.5), value: selectionState)
    .animation(.easeInOut(duration: 0.5), value: showSetup)
  }
}
