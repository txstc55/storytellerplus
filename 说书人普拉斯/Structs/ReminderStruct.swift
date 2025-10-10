//
//  ReminderStruct.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/21/25.
//

struct Reminder: Codable, Hashable, Identifiable {
  var from: String // who has this reminder
  var effect: String // what is the effect
  var team: Int = 5
  var isGlobal: Bool = false // is this reminder global
  var playerId: Int = -1 // -1 for not setup right now, -2 for story teller
  var id: String { "\(playerId)-\(from)-\(effect)-\(isGlobal)" }
  var isReversed: Bool = false // is this reminder reversed
  
  
  init(from: String, effect: String, team: Int = 5, isGlobal: Bool = false, playerId: Int = -1) {
    self.from = from
    self.effect = effect
    self.team = team
    self.isGlobal = isGlobal
    self.playerId = playerId
  }
}
