//
//  JinxStruct.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/21/25.
//

struct Jinx: Codable{
  var name: String
  var imageURL: String
  var type: Int = 1 // 1 for 相克规则 0 for 游戏状态
  var description: String
}
