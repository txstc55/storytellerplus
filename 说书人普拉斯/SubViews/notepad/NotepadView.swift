//
//  NotepadView.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/23/25.
//
import SwiftUI
import Flow
struct NotepadView: View {
  @Binding var playersAssignedCharacters: [Character]
  @Binding var playableCharacters: [Character]
  @Binding var showNotepad: Bool
  private var predefinedTagsWithPlayerInfo: [String] {
    var tags: [String] = []
    for i in 0..<playersAssignedCharacters.count {
      tags.append("\(i + 1)号")
      tags.append(playersAssignedCharacters[i].name)
    }
    return tags
  }
  
  private var predefinedTagsWithCharacterInfo: [String] {
    let assignedNames = Set(playersAssignedCharacters.map { $0.name })
    return playableCharacters
      .map { $0.name }
      .filter { !assignedNames.contains($0) }
  }
  private var predefinedTags: [String] {
    [
      "你是", "他是", "活着", "死亡", "邪恶", "善良",
      "镇民", "外来者", "爪牙", "旅行者", "恶魔", "中毒", "醉酒", "你被", "洗脑",
      "使用能力吗", "共边", "不共边", "左边", "右边", "不能说", "不可以", "不建议", "请选择", "选择", "?"
    ]
  }
  
  @State private var showPredefinedTags = true
  @State private var noteText: String = ""
  var body: some View {
    ZStack{
      Color.mainbg
        .edgesIgnoringSafeArea(.all)
        .onTapGesture(count: 2) {
          withAnimation(.easeInOut(duration: 0.3)) {
            showNotepad = false
          }
        }
      HStack(spacing: 0){
        if showPredefinedTags{
          VStack{
            ScrollView(showsIndicators: false){
              HFlow{
                ForEach(predefinedTagsWithPlayerInfo.indices, id: \.self) { index in
                  Text(predefinedTagsWithPlayerInfo[index])
                    .font(.system(size: 20, design: .monospaced))
                    .fontWeight(.semibold)
                    .padding(.vertical, 3)
                    .padding(.horizontal, 4)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                      .stroke(Color.black, lineWidth: 2))
                    .onTapGesture {
                      noteText += "\(predefinedTagsWithPlayerInfo[index]) "
                    }
                }
              }
              .padding(.horizontal, 10)
              .padding(.vertical, 20)
              Rectangle()
                .frame(height: 3)
              HFlow{
                ForEach(predefinedTagsWithCharacterInfo.indices, id: \.self) { index in
                  Text(predefinedTagsWithCharacterInfo[index])
                    .font(.system(size: 20, design: .monospaced))
                    .fontWeight(.semibold)
                    .padding(.vertical, 3)
                    .padding(.horizontal, 4)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                      .stroke(Color.black, lineWidth: 2))
                    .onTapGesture {
                      noteText += "\(predefinedTagsWithCharacterInfo[index]) "
                    }
                }
              }
              .padding(.horizontal, 10)
              .padding(.vertical, 20)
              
              Rectangle()
                .frame(height: 3)
              
              HFlow{
                ForEach(predefinedTags.indices, id: \.self) { index in
                  Text(predefinedTags[index])
                    .font(.system(size: 20, design: .monospaced))
                    .fontWeight(.semibold)
                    .padding(.vertical, 3)
                    .padding(.horizontal, 4)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                      .stroke(Color.black, lineWidth: 2))
                    .onTapGesture {
                      noteText += "\(predefinedTags[index]) "
                    }
                }
              }
              .padding(.horizontal, 10)
              .padding(.vertical, 20)
            }
            .frame(width: 200)
            
          }
          .border(width: 3, edges: [.trailing], color: .black)
          .transition(.move(edge: .leading))
        }
        VStack{
          VStack{
            Spacer()
            TextField("输入信息", text: $noteText,  axis: .vertical)
              .multilineTextAlignment(.center)
              .font(.system(size: 50, design: .rounded))
              .fontWeight(.bold)
            Spacer()
          }
          .padding(.horizontal, 10)
          
          HStack(spacing: 0){
            Text(showPredefinedTags ? "收起" : "预设")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.semibold)
              .padding()
              .frame(maxWidth: .infinity)
              .border(width: 3, edges: [.top], color: .black)
              .border(width: 1.5, edges: [.trailing], color: .black)
              .onTapGesture {
                withAnimation(.easeInOut(duration: 0.3)) {
                  showPredefinedTags.toggle()
                }
              }
            Text("清空")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.semibold)
              .frame(maxWidth: .infinity)
              .padding()
              .border(width: 3, edges: [.top], color: .black)
              .border(width: 1.5, edges: [.leading], color: .black)
              .onTapGesture {
                withAnimation(.easeInOut(duration: 0.3)) {
                  noteText = ""
                }
              }
          }
        }
        .frame(maxWidth: .infinity)
      }
      .frame(width: 800)
      .frame(maxHeight: 800)
      .clipShape(RoundedRectangle(cornerRadius: 20))
      .overlay(RoundedRectangle(cornerRadius: 20)
        .stroke(Color.black, lineWidth: 3))
      .padding(.vertical, 50)
      
      
    }
    .animation(.easeInOut(duration: 0.5), value: showPredefinedTags)
  }
}
