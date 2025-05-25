//
//  CharaceterStruct.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/21/25.
//

struct Character: Equatable, Hashable, Codable {
  var id: String
  var name: String
  var ability: String
  var firstNightOrder: Double = 0
  var otherNightOrder: Double = 0
  var firstNightReminder: String = ""
  var otherNightReminder: String = ""
  var setup: Bool = false // do we need special setup for this character
  var team: String = ""
  var imageURL: String = ""
}


let 乞丐 = Character(id: "乞丐", name: "乞丐", ability: "你只能使用投票标记投票。死亡的玩家可以将他的投票标记给你，如果他这么做，你会得知他的阵营。你不会中毒和醉酒。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "traveler", imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/beggar.png")

let 替罪羊 = Character(id: "替罪羊", name: "替罪羊", ability: "如果你的阵营的一名玩家被处决，你可能会代替他被处决。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "traveler", imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/scapegoat.png")

let 枪手 = Character(id: "枪手", name: "枪手", ability: "每个白天，当首次投票被统计后，你可以选择一名刚投过票的玩家：他死亡。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "traveler", imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/gunslinger.png")

let 窃贼 = Character(
  id: "窃贼",
  name: "窃贼",
  ability: "每个夜晚，你要选择除你以外的一名玩家：明天白天他的投票会被算作负数。",
  firstNightOrder: 1.1,
  otherNightOrder: 1.1,
  firstNightReminder: "窃贼指向一名玩家。将负票标记放在那名玩家旁。",
  otherNightReminder: "窃贼指向一名玩家。将负票标记放在那名玩家旁。",
  setup: false,
  team: "traveler",
  imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/thief.png"
)

let 官员 = Character(
  id: "官员",
  name: "官员",
  ability: "每个夜晚，你要选择除你以外的一名玩家：明天白天，他的投票算作三票。",
  firstNightOrder: 1.0,
  otherNightOrder: 1,
  firstNightReminder: "官员指向一名玩家。将三票标记放在那名玩家旁。",
  otherNightReminder: "官员指向一名玩家。将三票标记放在那名玩家旁。",
  setup: false,
  team: "traveler",
  imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/bureaucrat.png"
)

let 巫毒师 = Character(id: "巫毒师", name: "巫毒师", ability: "只有你和死亡的玩家可以投票，且投票不需要使用投票标记。忽略票数需要过半的要求。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "traveler", imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/voudon.png")

let 主教 = Character(id: "主教", name: "主教", ability: "只有说书人可以发起提名。每个白天说书人至少要提名一名你对立阵营的玩家。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "traveler", imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/bishop.png")

let 法官 = Character(id: "法官", name: "法官", ability: "每局游戏限一次，如果其他玩家发起了提名，你可以选择让本次提名直接执行处决或让投票无效。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "traveler", imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/judge.png")

let 女舍监 = Character(id: "女舍监", name: "女舍监", ability: "每个白天，你可以选择至多三对玩家交换座位。玩家不能离开座位私聊。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "traveler", imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/matron.png")

let 学徒 = Character(
  id: "学徒",
  name: "学徒",
  ability: "在你的首个夜晚，如果你是善良的，你会获得一个镇民角色的能力；如果你是邪恶的，你会获得一个爪牙角色的能力。",
  firstNightOrder: 1.2,
  otherNightOrder: 0,
  firstNightReminder: "对学徒展示一个镇民或爪牙标记。在魔典中，用那个角色标记代替学徒标记，并在一旁标识该玩家是学徒。",
  otherNightReminder: "",
  setup: false,
  team: "traveler",
  imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/apprentice.png"
)


let 怪咖 = Character(id: "怪咖", name: "怪咖", ability: "如果你表现得很有趣，当天你不能被流放。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "traveler", imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/deviant.png")

let 集骨者 = Character(
  id: "集骨者",
  name: "集骨者",
  ability: "每局游戏限一次，在夜晚时*，你可以选择一名死亡的玩家：他重新获得能力直到下个黄昏。",
  firstNightOrder: 0,
  otherNightOrder: 1.4,
  firstNightReminder: "",
  otherNightReminder: "集骨者选择不使用能力，或指向一名死亡玩家。放置恢复能力标记提示，并且该玩家当晚可能会因此醒来并使用能力。",
  setup: false,
  team: "traveler",
  imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/bone_collector.png"
)

let 屠夫 = Character(id: "屠夫", name: "屠夫", ability: "每个白天，首次处决后，你可以再次发起提名。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "traveler", imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/butcher.png")

let 流莺 = Character(
  id: "流莺",
  name: "流莺",
  ability: "每个夜晚*，你要选择一名存活的玩家：如果他同意，你会得知他的角色，但是你们两个可能同时死亡。",
  firstNightOrder: 0,
  otherNightOrder: 1.3,
  firstNightReminder: "",
  otherNightReminder: "流莺选择一名玩家，将其唤醒，那名玩家选择同意或拒绝。如果同意，将他的角色标记展示给流莺看。然后说书人可以决定两名玩家是否会一起死去。",
  setup: false,
  team: "traveler",
  imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/harlot.png"
)

let 咖啡师 = Character(
  id: "咖啡师",
  name: "咖啡师",
  ability: "每个夜晚，直至下个黄昏，由说书人二选一：1）一名玩家解除并免受醉酒和中毒影响，且会得知正确信息；2）一名玩家的能力可以生效两次。该玩家会得知是哪个效果。",
  firstNightOrder: 1.3,
  otherNightOrder: 1.2,
  firstNightReminder: "说书人选择一名玩家唤醒，并告诉他触发了咖啡师的什么效果。",
  otherNightReminder: "说书人选择一名玩家唤醒，并告诉他触发了咖啡师的什么效果。",
  setup: false,
  team: "traveler",
  imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/barista.png"
)

let 侏儒 = Character(id: "侏儒", name: "侏儒", ability: "所有玩家得知一名与你阵营相同的玩家。你可以杀死提名他的玩家。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "traveler", imageURL: "https://oss.gstonegames.com/data_file/clocktower/upload/202411/c_2576281040371_3babe7fd.jpg")

let 黑帮 = Character(id: "黑帮", name: "黑帮", ability: "每个白天限一次，你可以杀死与你邻近的两名存活的玩家中的一名，但需要另一边那个存活的玩家同意。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "traveler", imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/gangster.png")

let 叫花子 = Character(id: "叫花子", name: "叫花子", ability: "每个白天限一次，你可以公开选择一名其他玩家，让他选择一个非恶魔角色：你可能会获得这个角色的能力，直到下个黎明。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "traveler", imageURL: "https://oss.gstonegames.com/data_file/clocktower/upload/202310/c_4509255308961_63a95d5b.jpg")

let 刁民 = Character(
  id: "刁民",
  name: "刁民",
  ability: "曾在白天粗暴地打断过你的发言的玩家之一会在当晚醉酒，即使你已死亡。",
  firstNightOrder: 0,
  otherNightOrder: 0,
  firstNightReminder: "",
  otherNightReminder: "",
  setup: false,
  team: "traveler",
  imageURL: "https://oss.gstonegames.com/data_file/clocktower/upload/202404/c_8385231943171_9383f742.jpg"
)

let travlerCharactersGlobal: [Character] = [
  乞丐,
  替罪羊,
  枪手,
  窃贼,
  官员,
  巫毒师,
  主教,
  法官,
  女舍监,
  学徒,
  怪咖,
  集骨者,
  屠夫,
  流莺,
  咖啡师,
  侏儒,
  黑帮,
  叫花子,
  刁民
]

let travelerRemindersGlobal = [
  Reminder(from: "窃贼", effect: "负票", isGlobal: false),
  Reminder(from: "官员", effect: "3票", isGlobal: false),
  Reminder(from: "主教", effect: "提名善良方", isGlobal: false),
  Reminder(from: "主教", effect: "提名邪恶方", isGlobal: false),
  Reminder(from: "法官", effect: "失去能力", isGlobal: false),
  Reminder(from: "学徒", effect: "是学徒", isGlobal: false),
  Reminder(from: "拾骨人", effect: "重获能力", isGlobal: false),
  Reminder(from: "拾骨人", effect: "失去能力", isGlobal: false),
  Reminder(from: "流莺", effect: "死亡", isGlobal: false),
  Reminder(from: "咖啡师", effect: "清醒且健康", isGlobal: false),
  Reminder(from: "咖啡师", effect: "行动两次", isGlobal: false),
  Reminder(from: "地精", effect: "同伴", isGlobal: false),
  Reminder(from: "刁民", effect: "醉酒", isGlobal: false),
//  Reminder(from: "善良", effect: "善良", isGlobal: true),
//  Reminder(from: "邪恶", effect: "邪恶", isGlobal: true)
]

let 善良 = Character(id: "善良", name: "善良", ability: "你是善良的。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "fabled", imageURL: "https://oss.gstonegames.com/data_file/clocktower/web/icons/good.png")

let 邪恶 = Character(id: "邪恶", name: "邪恶", ability: "你是邪恶的。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "fabled", imageURL: "https://oss.gstonegames.com/data_file/clocktower/web/icons/evil.png")

let 善良标记 = Reminder(from: "善良", effect: "善良", isGlobal: true)
let 邪恶标记 = Reminder(from: "邪恶", effect: "邪恶", isGlobal: true)


let teamCounts: [Int: [Int]] = [5: [3, 0, 1, 1, 0], 6: [3, 1, 1, 1, 0], 7: [5, 0, 1, 1, 0], 8: [5, 1, 1, 1, 0], 9: [5, 2, 1, 1, 0], 10: [7, 0, 2, 1, 0], 11: [7, 1, 2, 1, 0], 12: [7, 2, 2, 1, 0], 13: [9, 0, 3, 1, 0], 14: [9, 1, 3, 1, 0], 15: [9, 2, 3, 1, 0], 16: [9, 2, 3, 1, 1], 17: [9, 2, 3, 1, 2], 18: [9, 2, 3, 1, 3], 19: [9, 2, 3, 1, 4], 20: [9, 2, 3, 1, 5]]


let defaultCharacter = Character(id: " ", name: "", ability: "", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "", imageURL: "")

let 爪牙 = Character(id: "爪牙", name: "爪牙", ability: "你是邪恶的。", firstNightOrder: 20, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "minion", imageURL: "https://clocktower-wiki.gstonegames.com/images/thumb/8/85/Mi.png/180px-Mi.png")
let 恶魔 = Character(id: "恶魔", name: "恶魔", ability: "你是邪恶的。", firstNightOrder: 30, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "demon", imageURL: "https://clocktower-wiki.gstonegames.com/images/thumb/1/18/Di.png/180px-Di.png")


