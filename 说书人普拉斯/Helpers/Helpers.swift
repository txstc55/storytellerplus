//
//  Helpers.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/22/25.
//

func assignCharacter(to index: Int, character: Character, playersAssignedCharacters: inout [Character], notPresentedGoodCharacters: inout [Character]) {
  if index < playersAssignedCharacters.count {
    playersAssignedCharacters[index] = character
  }
  if index > 20 {
    notPresentedGoodCharacters[index - 21] = character
  }
}

func getImageURL(name: String, characters: [Character]) -> String{
  for character in characters{
    if character.name == name{
      return character.imageURL
      
    }
  }
  return ""
}


struct GameSaveData: Codable {
  let playName: String
  let playAuthor: String
  let gameState: Int
  let characters: [Character]
  
  let playersAssignedCharacters: [Character]
  let playersIsAlive: [Bool]
  let playersHasDeathVote: [Bool]
  let aliveCount: Int
  
  let playableCharacters: [Character]
  let travelers: [Character]
  let fabled: [Character]
  let notPresentedGoodCharacters: [Character]
  
  let jinxList: [Jinx]
  let allReminders: [Reminder]
  let playersStates: [[Reminder]]
  
  let currentSelectedPlayerID: Int
  let selectNewCharacter: Bool
  
  let currentSelectedPlayerIDForReminder: Int
  let selectNewReminder: Bool
  let selectedReminderIndex: Int
  
  let allLogs: [GameLogEntry]
  let firstNightOrder: Bool
  let currentlyAwakePlayerIndex: Int
  
  let selectedFabledCharacters: [Character]
}


func loadGameData(
  from playJSON: [[String: Any]],
  characters: inout [Character],
  playableCharacters: inout [Character],
  travelers: inout [Character],
  fabled: inout [Character],
  allReminders: inout [Reminder],
  jinxList: inout [Jinx],
  playName: inout String,
  playAuthor: inout String,
  alertMessage: inout String,
  showAlert: inout Bool
) {
  for jsonItem in playJSON {
    guard let id = jsonItem["id"] as? String else { continue }
    
    if id == "_meta" {
      playName = (jsonItem["name"] as? String).flatMap { $0.isEmpty ? nil : $0 } ?? "无名剧本"
      playAuthor = (jsonItem["author"] as? String).flatMap { $0.isEmpty ? nil : $0 } ?? "无名作者"
      let statusList = jsonItem["status"] as? [[String: String]] ?? []
      for status in statusList {
        let name = status["name"] ?? ""
        let description = status["skill"] ?? ""
        if !name.isEmpty && !description.isEmpty {
          jinxList.append(Jinx(name: name, imageURL: "", type: 0, description: description))
        }
      }
      
    } else if id.contains("_meta") {
      let jinx = Jinx(
        name: jsonItem["name"] as? String ?? "",
        imageURL: jsonItem["image"] as? String ?? "",
        type: 1,
        description: jsonItem["ability"] as? String ?? ""
      )
      jinxList.append(jinx)
      
    } else {
      guard let name = jsonItem["name"] as? String else {
        alertMessage = "ID: \(id) 角色名称缺失"
        showAlert = true
        continue
      }
      guard let ability = jsonItem["ability"] as? String else {
        alertMessage = "ID: \(id) 角色能力缺失"
        showAlert = true
        continue
      }
      
      let firstNight = (jsonItem["firstNight"] as? Double)
      ?? (jsonItem["firstNight"] as? Int).map(Double.init)
      ?? 0
      let otherNight = (jsonItem["otherNight"] as? Double)
      ?? (jsonItem["otherNight"] as? Int).map(Double.init)
      ?? 0
      
      let firstNightReminder = jsonItem["firstNightReminder"] as? String ?? ""
      let otherNightReminder = jsonItem["otherNightReminder"] as? String ?? ""
      let setup = jsonItem["setup"] as? Bool ?? false
      
      guard let team = jsonItem["team"] as? String else {
        alertMessage = "ID: \(id) 角色阵营缺失"
        showAlert = true
        continue
      }
      
      let imageURL = jsonItem["image"] as? String ?? ""
      
      let character = Character(
        id: id,
        name: name,
        ability: ability,
        firstNightOrder: firstNight,
        otherNightOrder: otherNight,
        firstNightReminder: firstNightReminder,
        otherNightReminder: otherNightReminder,
        setup: setup,
        team: team,
        imageURL: imageURL
      )
      
      switch team {
      case "fabled":
        fabled.append(character)
      case "traveler":
        travelers.append(character)
        playableCharacters.append(character)
      default:
        playableCharacters.append(character)
      }
      
      characters.append(character)
      
      let reminders = (jsonItem["reminders"] as? [String] ?? []).map {
        Reminder(from: name, effect: $0, isGlobal: false)
      }
      let remindersGlobal = (jsonItem["remindersGlobal"] as? [String] ?? []).map {
        Reminder(from: name, effect: $0, isGlobal: true)
      }
      
      allReminders.append(contentsOf: reminders)
      allReminders.append(contentsOf: remindersGlobal)
    }
  }
  
  // Add default characters and reminders
  characters.append(contentsOf: [善良, 邪恶, 爪牙, 恶魔])
  
  // now we check for all the character names
  let characterNames = characters.map { $0.name }
  let fabledCharacterNames = fabled.map { $0.name }
  playableCharacters.append(contentsOf: travlerCharactersGlobal.filter { !characterNames.contains($0.name) })
  characters.append(contentsOf: travlerCharactersGlobal.filter { !characterNames.contains($0.name) }) // add the global traveler characters if the name doesnt exist already
  characters.append(contentsOf: fabledCharactersGlobal.filter { !fabledCharacterNames.contains($0.name) }) // we add the global fabled characters if the name doesnt exist already
  allReminders.append(contentsOf: [善良标记, 邪恶标记])
  allReminders.append(contentsOf: travelerRemindersGlobal)
  allReminders.append(contentsOf: fabledRemindersGlobal)
}
