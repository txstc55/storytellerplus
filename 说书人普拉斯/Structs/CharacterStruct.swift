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

let 笑匠 = Character(id: "笑匠", name: "笑匠", ability: "每个白天，你要选择一名玩家：一名其他玩家会在当晚改变角色。", firstNightOrder: 0, otherNightOrder: 1.5, firstNightReminder: "", otherNightReminder: "用一个不同的角色标记替换任意一个玩家的角色标记。唤醒那名玩家，依次向他展示“你是”提示标记和新的角色标记，然后让他们重新入睡。", setup: false, team: "traveler", imageURL: "https://www.bloodstar.xyz/p/SerraEvelyn/yueyeyueyouji/4_yueyeyueyouji.png")

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
  刁民,
  笑匠
]

let travelerRemindersGlobal = [
  Reminder(from: "窃贼", effect: "负票", team: 4, isGlobal: false),
  Reminder(from: "官员", effect: "3票", team: 4, isGlobal: false),
  Reminder(from: "主教", effect: "提名善良方", team: 4, isGlobal: false),
  Reminder(from: "主教", effect: "提名邪恶方", team: 4, isGlobal: false),
  Reminder(from: "法官", effect: "失去能力", team: 4, isGlobal: false),
  Reminder(from: "学徒", effect: "是学徒", team: 4, isGlobal: false),
  Reminder(from: "拾骨人", effect: "重获能力", team: 4, isGlobal: false),
  Reminder(from: "拾骨人", effect: "失去能力", team: 4, isGlobal: false),
  Reminder(from: "流莺", effect: "死亡", team: 4, isGlobal: false),
  Reminder(from: "咖啡师", effect: "清醒且健康", team: 4, isGlobal: false),
  Reminder(from: "咖啡师", effect: "行动两次", team: 4, isGlobal: false),
  Reminder(from: "地精", effect: "同伴", team: 4, isGlobal: false),
  Reminder(from: "刁民", effect: "醉酒", team: 4, isGlobal: false),
  Reminder(from: "笑匠", effect: "不是我", team: 4, isGlobal: false),
//  Reminder(from: "善良", effect: "善良", isGlobal: true),
//  Reminder(from: "邪恶", effect: "邪恶", isGlobal: true)
]

let 善良 = Character(id: "善良", name: "善良", ability: "你是善良的。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "misc", imageURL: "https://oss.gstonegames.com/data_file/clocktower/web/icons/good.png")

let 邪恶 = Character(id: "邪恶", name: "邪恶", ability: "你是邪恶的。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "misc", imageURL: "https://oss.gstonegames.com/data_file/clocktower/web/icons/evil.png")

let 善良标记 = Reminder(from: "善良", effect: "善良", team: 0, isGlobal: true)
let 邪恶标记 = Reminder(from: "邪恶", effect: "邪恶", team: 3, isGlobal: true)


let teamCounts: [Int: [Int]] = [5: [3, 0, 1, 1, 0], 6: [3, 1, 1, 1, 0], 7: [5, 0, 1, 1, 0], 8: [5, 1, 1, 1, 0], 9: [5, 2, 1, 1, 0], 10: [7, 0, 2, 1, 0], 11: [7, 1, 2, 1, 0], 12: [7, 2, 2, 1, 0], 13: [9, 0, 3, 1, 0], 14: [9, 1, 3, 1, 0], 15: [9, 2, 3, 1, 0], 16: [9, 2, 3, 1, 1], 17: [9, 2, 3, 1, 2], 18: [9, 2, 3, 1, 3], 19: [9, 2, 3, 1, 4], 20: [9, 2, 3, 1, 5]]


let defaultCharacter = Character(id: " ", name: "", ability: "", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "", imageURL: "")

let 爪牙 = Character(id: "爪牙", name: "爪牙", ability: "你是邪恶的。", firstNightOrder: 20, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "misc", imageURL: "https://clocktower-wiki.gstonegames.com/images/thumb/8/85/Mi.png/180px-Mi.png")
let 恶魔 = Character(id: "恶魔", name: "恶魔", ability: "你是邪恶的。", firstNightOrder: 30, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "misc", imageURL: "https://clocktower-wiki.gstonegames.com/images/thumb/1/18/Di.png/180px-Di.png")


let 天使 = Character(id: "天使", name: "天使", ability: "对新玩家的死亡负最大责任的人，可能会遭遇一些不好的事情。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "fabled", imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/angel.png")

let 佛教徒 = Character(id: "佛教徒", name: "佛教徒", ability: "每个白天的前两分钟老玩家不能发言。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "fabled", imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/buddhist.png")

let 灯神 = Character(id: "灯神", name: "灯神", ability: "使用灯神的相克规则。所有玩家都会知道其内容。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "fabled", imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/djinn.png")

let 末日预言者 = Character(id: "末日预言者", name: "末日预言者", ability: "如果大于等于四名玩家存活，每名当前存活的玩家可以公开要求你杀死一名与他阵营相同的玩家（每名玩家限一次）。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "fabled", imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/doomsayer.png")

let 公爵夫人 = Character(id: "公爵夫人", name: "公爵夫人", ability: "每个白天，三名玩家可以一起拜访你。当晚*，他们会得知他们之中有几个是邪恶的，但其中一人的信息是错的。", firstNightOrder: 0, otherNightOrder: 1.5, firstNightReminder: "", otherNightReminder: "", setup: false, team: "fabled", imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/duchess.png")


let 骗人精 = Character(id: "骗人精", name: "骗人精", ability: "每局游戏限一次，一名善良玩家可能会得知“有问题”的信息。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "fabled", imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/fibbin.png")


let 小提琴手 = Character(id: "小提琴手", name: "小提琴手", ability: "每局游戏限一次，恶魔可以秘密选择一名对立阵营的玩家，所有玩家要表决：这两名玩家中谁的阵营获胜。（平局邪恶阵营获胜）", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "fabled", imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/fiddler.png")

let 地狱藏书员 = Character(id: "地狱藏书员", name: "地狱藏书员", ability: "当说书人宣布安静时，仍在说话的玩家可能会遭遇一些不好的事情。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "fabled", imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/hells_librarian.png")

let 革命者 = Character(id: "革命者", name: "革命者", ability: "公开声明一对邻座玩家本局游戏一直保持同一阵营。每局游戏限一次，他们中的一人可能被当作其他的角色/阵营。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "fabled", imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/revolutionary.png")

let 哨兵 = Character(id: "哨兵", name: "哨兵", ability: "在初始设置时，可能会额外增加或减少一个外来者。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "fabled", imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/sentinel.png")

let 圣洁之魂 = Character(id: "圣洁之魂", name: "圣洁之魂", ability: "游戏过程中邪恶玩家的总数最多能比初始设置多一名。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "fabled", imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/spirit_of_ivory.png")

let 暴风捕手 = Character(id: "暴风捕手", name: "暴风捕手", ability: "游戏开始时，你要宣布一个善良角色。如果该角色在场，他只能死于处决，但所有邪恶玩家会在首个夜晚得知他是哪一名玩家。", firstNightOrder: 2.05, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "fabled", imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/stormcatcher.png")

let 玩具匠 = Character(id: "玩具匠", name: "玩具匠", ability: "恶魔可以在夜晚选择放弃攻击（每局游戏至少一次）。邪恶玩家照常获取初始信息。", firstNightOrder: 1.9, otherNightOrder: 45, firstNightReminder: "", otherNightReminder: "", setup: false, team: "fabled", imageURL: "https://oss.gstonegames.com/data_file/clocktower/role_icon/toymaker.png")

//let 园丁 = Character(id: "园丁", name: "园丁", ability: "由说书人来为一名或更多玩家派发角色。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "fabled", imageURL: "https://oss.gstonegames.com/data_file/clocktower/upload/202304/c_4546410162861_275f00e6.jpg")
let 私货商人 = Character(id: "私货商人", name: "私货商人", ability: "这个剧本包含有自制角色或自制规则。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "fabled", imageURL: "https://oss.gstonegames.com/data_file/clocktower/upload/1689518692_197011_1078.png")

let 麒麟 = Character(id: "麒麟", name: "麒麟", ability: "在游戏的最后一天，最幸运的玩家身上会发生一些好的事情。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "fabled", imageURL: "https://oss.gstonegames.com/data_file/clocktower/web/icons/qilin.png")

let 摆渡人 = Character(id: "摆渡人", name: "摆渡人", ability: "在游戏的最后一天，所有已死亡玩家会重新获得投票标记。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "fabled", imageURL: "https://oss.gstonegames.com/data_file/clocktower/upload/202310/c_5466274308961_88a6d609.jpg")

let 赦令承旨 = Character(id: "赦令承旨", name: "赦令承旨", ability: "解除所有角色能力在进行选择时的限制条件。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "fabled", imageURL: "https://oss.gstonegames.com/data_file/clocktower/upload/202403/c_4414831380171_0a601ac6.jpg")

let 印度教教徒 = Character(id: "印度教教徒", name: "印度教教徒", ability: "最先死亡的四名玩家会立即以相同阵营的旅行者转世重生。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "fabled", imageURL: "https://patchwiki.biligame.com/images/jbzlbwgwjcygf/e/ef/kqlms0w8wp372gvh76lov0c08e6z8m3.png")

let 遗忘之门 = Character(id: "遗忘之门", name: "遗忘之门", ability: "玩家不知道自己的角色和阵营。当他们死亡时才会得知这些信息。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "fabled", imageURL: "https://www.bloodstar.xyz/p/SerraEvelyn/jubushiyi/30_jubushiyi.png")

let 异术士 = Character(id: "异术士", name: "异术士", ability: "一名或多名玩家各自拥有一个目标。当达成目标后，他会获得一条正确信息。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "fabled", imageURL: "https://www.bloodstar.xyz/p/SerraEvelyn/zhixianrenwu/_zhixianrenwu.png")

let 教皇 = Character(id: "教皇", name: "教皇", ability: "会有重复的善良角色在场。他们也可能是恶魔的伪装。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "fabled", imageURL: "https://patchwiki.biligame.com/images/jbzlbwgwjcygf/b/bc/irnsk5kjolajz8gldu0kbdgmf95z9zp.png")

let 首席律师 = Character(id: "首席律师", name: "首席律师", ability: "每个被提名者要选择一名玩家：在投票前，只有他可以发言，并且他要“疯狂”地证明被提名者是善良的，否则他可能死亡。", firstNightOrder: 0, otherNightOrder: 0, firstNightReminder: "", otherNightReminder: "", setup: false, team: "fabled", imageURL: "https://clocktower-wiki.gstonegames.com/images/thumb/9/97/Bootlegger.png/200px-Bootlegger.png")

let fabledCharactersGlobal: [Character] = [
  天使,
  佛教徒,
  灯神,
  地狱藏书员,
  公爵夫人,
  骗人精,
  小提琴手,
  末日预言者,
  革命者,
  哨兵,
  圣洁之魂,
  暴风捕手,
  玩具匠,
  私货商人,
  麒麟,
  摆渡人,
  赦令承旨,
  印度教教徒,
  遗忘之门,
  异术士,
  教皇,
  首席律师
]

let fabledRemindersGlobal = [
  Reminder(from: "天使", effect: "庇护", team: 5, isGlobal: false, playerId: -2),
  Reminder(from: "天使", effect: "不好的事", team: 5, isGlobal: false, playerId: -2),
  Reminder(from: "地狱藏书员", effect: "不好的事", team: 5, isGlobal: false, playerId: -2),
  Reminder(from: "公爵夫人", effect: "访客", team: 5, isGlobal: false, playerId: -2),
  Reminder(from: "公爵夫人", effect: "错误信息", team: 5, isGlobal: false, playerId: -2),
  Reminder(from: "骗人精", effect: "失去能力", team: 5, isGlobal: false, playerId: -2),
  Reminder(from: "革命者", effect: "被当作其他", team: 5, playerId: -2),
  Reminder(from: "圣洁之魂", effect: "禁止邪恶", team: 5, isGlobal: false, playerId: -2),
  Reminder(from: "暴风捕手", effect: "仅死于处决", team: 5, isGlobal: false, playerId: -2),
  Reminder(from: "印度教教徒", effect: "转世重生", team: 5, isGlobal: false, playerId: -2),
  Reminder(from: "异术士", effect: "目标", team: 5, isGlobal: false, playerId: -2),
]
//let 庇护 = Reminder(from: "天使", effect: "庇护", isGlobal: false)
//let 不好的事 = Reminder(from: "天使", effect: "不好的事", isGlobal: false)
//let 不好的事 = Reminder(from: "地狱藏书员", effect: "不好的事", isGlobal: false)
//let 访客 = Reminder(from: "公爵夫人", effect: "访客", isGlobal: false)
//let 错误信息 = Reminder(from: "公爵夫人", effect: "错误信息", isGlobal: false)
//let 失去能力 = Reminder(from: "骗人精", effect: "失去能力", isGlobal: false)
