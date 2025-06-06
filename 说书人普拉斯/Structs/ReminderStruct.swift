//
//  ReminderStruct.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/21/25.
//

struct Reminder: Codable, Hashable, Identifiable {
  var from: String // who has this reminder
  var effect: String // what is the effect
  var isGlobal: Bool = false // is this reminder global
  var id: String { "\(from)-\(effect)-\(isGlobal)" }
  var isReversed: Bool = false // is this reminder reversed
  
  init(from: String, effect: String, isGlobal: Bool = false) {
    self.from = from
    self.effect = effect
    self.isGlobal = isGlobal
  }
}
