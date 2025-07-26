//
//  SaveConversation.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 7/17/25.
//
import SwiftUI


struct ConversationLogViewFixed: View{
  let playersAssignedCharacters: [Character]
  let allLogs: [GameLogEntry]
  var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      ForEach(allLogs.indices, id: \.self){index in
        let entry = allLogs[index]
        let type = entry.type
        if type == 0 || type == 3{
          HStack(spacing: 2){
            let isPlayer = (entry.messager - 1) < playersAssignedCharacters.count
            if isPlayer{
              Text("\(entry.messager)")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .frame(width: 40, height: 40)
                .overlay(Circle().stroke(Color.black, lineWidth: 2))
                .padding(.horizontal, 2)
              if (entry.characterName != ""){
                Text(entry.characterName)
                  .font(.system(size: 20, design: .rounded))
                  .fontWeight(.semibold)
                  .foregroundColor(.black)
                  .padding(.horizontal, 5)
                  .frame(height: 40)
                  .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                  .padding(.horizontal, 2)
              }
              Text(entry.message)
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding(.horizontal, 10)
                .frame(minHeight: 40)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
              Spacer()
            }else{
              Spacer()
              Text(entry.message)
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding(.horizontal, 10)
                .frame(minHeight: 40)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
              Text("说")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .frame(width: 40, height: 40)
                .overlay(Circle().stroke(Color.black, lineWidth: 2))
                .padding(.horizontal, 2)
            }
          }
          .padding(.vertical, 5)
        }else if type == 1 || type == 14 || type == 15{
          HStack(spacing: 2){
            Text("\(entry.messager)")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.semibold)
              .foregroundColor(.black)
              .frame(width: 40, height: 40)
              .overlay(Circle().stroke(Color.black, lineWidth: 2))
              .padding(.horizontal, 2)
            Text(entry.characterName)
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.semibold)
              .foregroundColor(.black)
              .padding(.horizontal, 5)
              .frame(height: 40)
              .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
              .padding(.horizontal, 2)
            Text("\(entry.message)，来源为：\(entry.source)")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.semibold)
              .foregroundColor(.black)
              .padding(.horizontal, 10)
              .frame(minHeight: 40)
              .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
            Spacer()
          }
          .padding(.vertical, 5)
        }else if type == 2{
          if entry.messager < 0 {
            HStack{
              Text("\(entry.characterName) 被唤醒了")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.horizontal, 5)
                .padding(.vertical, 5)
            }
            .frame(maxWidth: .infinity)
            .border(width: 2, edges: [.top, .bottom], color: .black)
            .padding(.vertical, 5)
          }else{
            HStack{
              Text("\(entry.messager)号玩家 \(entry.characterName) 被唤醒了")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.horizontal, 5)
                .padding(.vertical, 5)
            }
            .frame(maxWidth: .infinity)
            .border(width: 2, edges: [.top, .bottom], color: .black)
            .padding(.vertical, 10)
          }
        }else if type == 4{
          HStack{
            Text("\(entry.messager)号玩家 \(entry.characterName) \(entry.message)")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.black)
              .padding(.horizontal, 5)
              .padding(.vertical, 5)
          }
          .frame(maxWidth: .infinity)
          .border(width: 2, edges: [.top, .bottom], color: .black)
          .padding(.vertical, 5)
        }else if type == 6{
          HStack(spacing: 2){
            Text("\(entry.messager)")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.semibold)
              .foregroundColor(.black)
              .frame(width: 40, height: 40)
              .overlay(Circle().stroke(Color.black, lineWidth: 2))
              .padding(.horizontal, 2)
            Text(entry.characterName)
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.semibold)
              .foregroundColor(.black)
              .padding(.horizontal, 5)
              .frame(height: 40)
              .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
              .padding(.horizontal, 2)
            Text("死亡")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.red)
              .padding(.horizontal, 10)
              .frame(minHeight: 40)
              .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: 2))
            Spacer()
          }
          .padding(.vertical, 5)
        }else if type == 7{
          HStack(spacing: 2){
            Text("\(entry.messager)")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.semibold)
              .foregroundColor(.black)
              .frame(width: 40, height: 40)
              .overlay(Circle().stroke(Color.black, lineWidth: 2))
              .padding(.horizontal, 2)
            Text("进入游戏")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.blue)
              .padding(.horizontal, 10)
              .frame(minHeight: 40)
              .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
            Spacer()
          }
          .padding(.vertical, 5)
        }else if type == 8{
          HStack{
            Text("游戏开始")
              .font(.system(size: 30, design: .rounded))
              .fontWeight(.black)
              .foregroundColor(.black)
              .padding(.horizontal, 2)
              .padding(.vertical, 10)
          }
          .frame(maxWidth: .infinity)
          .border(width: 3, edges: [.top, .bottom], color: .black)
          .padding(.vertical, 15)
        }else if type == 9{
          HStack{
            Text("进入第1个夜晚")
              .font(.system(size: 30, design: .rounded))
              .fontWeight(.black)
              .foregroundColor(.black)
              .padding(.horizontal, 2)
              .padding(.vertical, 10)
          }
          .frame(maxWidth: .infinity)
          .border(width: 3, edges: [.top, .bottom], color: .black)
          .padding(.vertical, 15)
        }else if type == 10{
          HStack{
            let dayCount = allLogs.prefix(index + 1).filter { $0.type == 10 }.count
            Text("进入第\(dayCount)个白天")
              .font(.system(size: 30, design: .rounded))
              .fontWeight(.black)
              .foregroundColor(.black)
              .padding(.horizontal, 2)
              .padding(.vertical, 10)
          }
          .frame(maxWidth: .infinity)
          .border(width: 3, edges: [.top, .bottom], color: .black)
          .padding(.vertical, 15)
        }else if type == 11{
          HStack{
            let nightCount = allLogs.prefix(index + 1).filter { $0.type == 11 }.count
            Text("进入第\(nightCount+1)个夜晚")
              .font(.system(size: 30, design: .rounded))
              .fontWeight(.black)
              .foregroundColor(.black)
              .padding(.horizontal, 2)
              .padding(.vertical, 10)
          }
          .frame(maxWidth: .infinity)
          .border(width: 3, edges: [.top, .bottom], color: .black)
          .padding(.vertical, 15)
        }else if type == 12{
          HStack(spacing: 2){
            Text("\(entry.messager)")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.semibold)
              .foregroundColor(.black)
              .frame(width: 40, height: 40)
              .overlay(Circle().stroke(Color.black, lineWidth: 2))
              .padding(.horizontal, 2)
            Text(entry.characterName)
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.semibold)
              .foregroundColor(.black)
              .padding(.horizontal, 5)
              .frame(height: 40)
              .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
              .padding(.horizontal, 2)
            Text("复活")
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.green)
              .padding(.horizontal, 10)
              .frame(minHeight: 40)
              .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 2))
            Spacer()
          }
          .padding(.vertical, 5)
        }else if type == 13{
          HStack{
            Text("恶魔得知伪装: \(entry.message)")
              .font(.system(size: 25, design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.black)
              .padding(.horizontal, 2)
              .padding(.vertical, 10)
          }
          .frame(maxWidth: .infinity)
          .border(width: 3, edges: [.top, .bottom], color: .black)
          .padding(.vertical, 10)
        }
      }
    }
    .background(Color.mainbg)
  }
}


@MainActor func exportGameLog(width: CGFloat, playersAssignedCharacters: [Character], allLogs: [GameLogEntry]){
  let captureView = ConversationLogViewFixed(playersAssignedCharacters: playersAssignedCharacters, allLogs: allLogs)
    .frame(width: width)
  
  let renderer = ImageRenderer(content: captureView)
  renderer.scale = UIScreen.main.scale
  
  if let image = renderer.uiImage {
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    print("✅ Image saved to photo album.")
  } else {
    print("❌ Failed to render image.")
  }
}
