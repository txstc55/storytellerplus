//
//  OrderInfoStruct.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/22/25.
//

struct OrderInfo: Codable, Hashable {
  var order: Double
  var reminder: String
  var playerID: Int
  var imageURL: String
  var characterName: String
  
  init(order: Double, reminder: String, playerID: Int, imageURL: String, characterName: String) {
    self.order = order
    self.reminder = reminder
    self.playerID = playerID
    self.imageURL = imageURL
    self.characterName = characterName
  }
}


let 爪牙信息 = OrderInfo(order: 20, reminder: "如果有七名或更多玩家，唤醒所有爪牙：展示“他是恶魔”信息标记。指向恶魔。", playerID: -2, imageURL: "https://clocktower-wiki.gstonegames.com/images/thumb/8/85/Mi.png/180px-Mi.png", characterName: "所有爪牙")
let 恶魔信息 = OrderInfo(order: 30, reminder: "如果有七名或更多玩家，唤醒恶魔：展示“他们是你的爪牙”信息标记。指向所有爪牙。 展示“这些角色不在场”信息标记。展示三个不在场的善良角色。", playerID: -3, imageURL: "https://clocktower-wiki.gstonegames.com/images/thumb/1/18/Di.png/180px-Di.png", characterName: "恶魔")
