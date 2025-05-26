import Foundation

struct GameLogEntry: Identifiable, Hashable, Codable {
  var id: UUID
  var timestamp: Date
  
  var message: String
  var messager: Int
  var source: String
  var type: Int
  var characterName: String
  var logText: String
  var audioURL: String
  
  init(message: String, messager: Int, source: String = "", type: Int = 0, characterName: String = "", audioURL: String = "") {
    self.id = UUID()
    self.timestamp = Date()
    self.message = message
    self.messager = messager
    self.source = source
    self.type = type // let's say 0 is for assign character, 1 for adding a new tag, 2 for waken up, 3 for any reglar text exchange, 4 for start voting, 5 for voting, 6 for death, 7 for adding new player, 8 for start game announcement, 9 for going to first night, 10 for day, 11 for night, 12 for revival, 13 for assigning cover character, 14 for losing tag
    self.characterName = characterName
    self.audioURL = audioURL
    self.logText = GameLogEntry.toString(
      message: message,
      messager: messager,
      source: source,
      type: type,
      characterName: characterName
    )
    print("GameLogEntry: \(logText)")
  }
  
  static func toString(message: String, messager: Int, source: String, type: Int, characterName: String) -> String {
    switch type {
    case 0:
      return "\(messager)号玩家 \(message)"
    case 1:
      return "\(messager)号玩家 \(characterName) \(message)，来源为：\(source)"
    case 2:
      if messager < 0 {
        return "============\n\(characterName) 被唤醒了\n============\n\(message)"
      }
      return "============\n\(messager)号玩家 \(characterName) 被唤醒了\n============\n\(message)"
    case 3:
      return "\(messager)号玩家： \(message)"
    case 4:
      return "\(messager)号玩家 \(characterName) \(message)"
    case 5:
      return "\(message)"
    case 6:
      return "\(messager)号玩家 \(characterName) 死亡"
    case 7:
      return "\(messager)号玩家 被添加进游戏"
    case 8:
      return "------------游戏开始了------------"
    case 9:
      return "------------第一晚开始了------------"
    case 10:
      return "------------白天开始了------------"
    case 11:
      return "------------晚上开始了------------"
    case 12:
      return "\(messager)号玩家 \(characterName) 复活"
    case 13:
      return "恶魔得知伪装: \(message)"
    case 14:
      return "\(messager)号玩家 \(characterName) \(message)，来源为：\(source)"
    default:
      return ""
    }
  }
}
