//
//  AllCharacterInfosView.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/23/25.
//

import SwiftUI
import UIKit

// MARK: - Image used by normal view and export view

struct CharacterDisplayImage: View {
  let urlString: String
  let exportImages: [String: UIImage]?
  
  var body: some View {
    Group {
      if let image = exportImages?[urlString] {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
      } else {
        CachedImageView(urlString: urlString)
      }
    }
  }
}


// MARK: - Character Card

struct CharacterInfoCard: View {
  let character: Character
  let characterNameColor: Color
  let exportImages: [String: UIImage]?
  
  var body: some View {
    HStack(alignment: .top) {
      CharacterDisplayImage(
        urlString: character.imageURL,
        exportImages: exportImages
      )
      .frame(width: 40, height: 40)
      .padding()
      
      VStack(alignment: .leading, spacing: 4) {
        Text(character.name)
          .font(.system(size: 25, design: .rounded))
          .fontWeight(.bold)
          .foregroundColor(characterNameColor)
          .frame(maxWidth: .infinity, alignment: .leading)
          .lineLimit(nil)
          .fixedSize(horizontal: false, vertical: true)
        
        Text(character.ability)
          .font(.system(size: 23, design: .rounded))
          .fontWeight(.semibold)
          .frame(maxWidth: .infinity, alignment: .leading)
          .lineLimit(nil)
          .fixedSize(horizontal: false, vertical: true)
      }
      .layoutPriority(1)
    }
  }
}


// MARK: - Vertical Role Title

struct CharacterRoleTitle: View {
  let characters: [String]
  let color: Color
  
  var body: some View {
    VStack {
      Spacer()
      
      ForEach(characters.indices, id: \.self) { index in
        Text(characters[index])
          .font(.system(size: 30, weight: .black, design: .rounded))
          .foregroundColor(color)
      }
      
      Spacer()
    }
    .frame(maxHeight: .infinity)
  }
}


// MARK: - Character Section

struct CharacterRoleSection: View {
  let titleCharacters: [String]
  let characters: [Character]
  let color: Color
  let exportImages: [String: UIImage]?
  
  private var middleIndex: Int {
    Int(ceil(Double(characters.count) / 2.0))
  }
  
  var body: some View {
    if characters.count > 0 {
      HStack(alignment: .top, spacing: 8) {
        CharacterRoleTitle(characters: titleCharacters, color: color)
        
        if characters.count == 1 {
          CharacterInfoCard(
            character: characters[0],
            characterNameColor: color,
            exportImages: exportImages
          )
          .padding(.bottom, 10)
          .frame(maxHeight: .infinity, alignment: .top)
          .layoutPriority(1)
        } else {
          VStack {
            ForEach(0..<middleIndex, id: \.self) { index in
              CharacterInfoCard(
                character: characters[index],
                characterNameColor: color,
                exportImages: exportImages
              )
              .padding(.bottom, 10)
            }
          }
          .frame(maxHeight: .infinity, alignment: .top)
          .layoutPriority(1)
          
          VStack {
            ForEach(middleIndex..<characters.count, id: \.self) { index in
              CharacterInfoCard(
                character: characters[index],
                characterNameColor: color,
                exportImages: exportImages
              )
              .padding(.bottom, 10)
            }
          }
          .frame(maxHeight: .infinity, alignment: .top)
          .layoutPriority(1)
        }
      }
      
      Rectangle()
        .fill(Color.black)
        .frame(height: 4)
        .padding(.vertical, 30)
    }
  }
}


// MARK: - Night Order Column

struct NightOrderColumn: View {
  let topText: String
  let bottomText: String
  let orders: [OrderInfo]
  let isExporting: Bool
  let exportImages: [String: UIImage]?
  
  var body: some View {
    VStack(alignment: .leading) {
      Spacer()
        .frame(height: 200)
      
      Text(topText)
        .font(.system(size: 20, weight: .black, design: .rounded))
        .padding(.bottom, -5)
      
      Text(bottomText)
        .font(.system(size: 20, weight: .black, design: .rounded))
      
      ForEach(orders.indices, id: \.self) { index in
        let nightReminder = orders[index]
        
        CharacterDisplayImage(
          urlString: nightReminder.imageURL,
          exportImages: exportImages
        )
        .frame(width: 40, height: 40)
      }
      
      if !isExporting {
        Spacer()
      }
    }
    .frame(width: 50)
    .frame(maxHeight: isExporting ? nil : .infinity)
  }
}


// MARK: - Reusable Layout

struct AllCharacterInfosLayout: View {
  let playableCharacters: [Character]
  let travelersInPlay: [Character]
  let fabledInPlay: [Character]
  let useScrollView: Bool
  let isExporting: Bool
  let exportImages: [String: UIImage]?
  
  private var townsfolks: [Character] {
    playableCharacters.filter { $0.team == "townsfolk" }
  }
  
  private var outsiders: [Character] {
    playableCharacters.filter { $0.team == "outsider" }
  }
  
  private var minions: [Character] {
    playableCharacters.filter { $0.team == "minion" }
  }
  
  private var demons: [Character] {
    playableCharacters.filter { $0.team == "demon" }
  }
  
  private var travelers: [Character] {
    travelersInPlay
  }
  
  private var officialTravelers: [Character] {
    let travelersNames = travelersInPlay.map { $0.name }
    return playableCharacters.filter {
      $0.team == "traveler" && !travelersNames.contains($0.name)
    }
  }
  
  private var firstNightOrders: [OrderInfo] {
    let combined = playableCharacters
      .enumerated()
      .filter { $0.element.firstNightOrder != 0 }
      .map {
        OrderInfo(
          order: $0.element.firstNightOrder,
          reminder: $0.element.firstNightReminder,
          playerID: $0.offset,
          imageURL: $0.element.imageURL,
          characterName: $0.element.name,
          team: $0.element.team
        )
      } + ([爪牙信息, 恶魔信息])
    
    return combined.sorted { $0.order < $1.order }
  }
  
  private var otherNightOrders: [OrderInfo] {
    let combined = playableCharacters
      .enumerated()
      .filter { $0.element.otherNightOrder != 0 }
      .map {
        OrderInfo(
          order: $0.element.otherNightOrder,
          reminder: $0.element.otherNightReminder,
          playerID: $0.offset,
          imageURL: $0.element.imageURL,
          characterName: $0.element.name,
          team: $0.element.team
        )
      }
    
    return combined.sorted { $0.order < $1.order }
  }
  
  var body: some View {
    Group {
      if useScrollView {
        ScrollView(showsIndicators: false) {
          content
        }
      } else {
        content
      }
    }
    .frame(width: 900)
    .fixedSize(horizontal: false, vertical: isExporting)
    .padding(.horizontal, 30)
    .background(Color.mainbg)
  }
  
  private var content: some View {
    HStack(alignment: .top, spacing: 20) {
      NightOrderColumn(
        topText: "首个",
        bottomText: "夜晚",
        orders: firstNightOrders,
        isExporting: isExporting,
        exportImages: exportImages
      )
      
      VStack(spacing: 0) {
        CharacterRoleSection(
          titleCharacters: ["镇", "民"],
          characters: townsfolks,
          color: Color.townsfolk,
          exportImages: exportImages
        )
        
        CharacterRoleSection(
          titleCharacters: ["外", "来", "者"],
          characters: outsiders,
          color: Color.outsider,
          exportImages: exportImages
        )
        
        CharacterRoleSection(
          titleCharacters: ["爪", "牙"],
          characters: minions,
          color: Color.minion,
          exportImages: exportImages
        )
        
        CharacterRoleSection(
          titleCharacters: ["恶", "魔"],
          characters: demons,
          color: Color.demon,
          exportImages: exportImages
        )
        
        CharacterRoleSection(
          titleCharacters: ["剧", "本", "传", "奇", "角", "色"],
          characters: fabledInPlay,
          color: Color.fabled,
          exportImages: exportImages
        )
        
        CharacterRoleSection(
          titleCharacters: ["剧", "本", "旅", "行", "者"],
          characters: travelers,
          color: Color.traveler,
          exportImages: exportImages
        )
        
        CharacterRoleSection(
          titleCharacters: ["官", "方", "旅", "行", "者"],
          characters: officialTravelers,
          color: Color.traveler,
          exportImages: exportImages
        )
      }
      .frame(maxHeight: .infinity)
      .layoutPriority(1)
      
      NightOrderColumn(
        topText: "其他",
        bottomText: "夜晚",
        orders: otherNightOrders,
        isExporting: isExporting,
        exportImages: exportImages
      )
    }
  }
}


// MARK: - Main View

struct AllCharacterInfosView: View {
  @Binding var playableCharacters: [Character]
  @Binding var showAllCharacterInfos: Bool
  @Binding var travelersInPlay: [Character]
  @Binding var fabledInPlay: [Character]
  
  @State private var isSavingImage: Bool = false
  
  var body: some View {
    ZStack {
      Color.mainbg
        .ignoresSafeArea(.all)
        .onTapGesture(count: 2) {
          showAllCharacterInfos = false
        }
      
      HStack {
        Spacer()
        
        AllCharacterInfosLayout(
          playableCharacters: playableCharacters,
          travelersInPlay: travelersInPlay,
          fabledInPlay: fabledInPlay,
          useScrollView: true,
          isExporting: false,
          exportImages: nil
        )
        
        Spacer()
      }
    }
    .overlay(alignment: .topTrailing) {
      Button {
        Task {
          await saveAllCharacterInfosAsImage()
        }
      } label: {
        ZStack {
          Image(systemName: "square.and.arrow.down")
            .font(.system(size: 26, weight: .medium))
            .foregroundColor(.primary)
            .opacity(isSavingImage ? 0 : 1)
          
          if isSavingImage {
            ProgressView()
          }
        }
        .padding(14)
        .background(.ultraThinMaterial)
        .clipShape(Circle())
      }
      .disabled(isSavingImage)
      .padding(.top, 20)
      .padding(.trailing, 20)
    }
  }
  
  @MainActor
  private func saveAllCharacterInfosAsImage() async {
    isSavingImage = true
    
    let images = await preloadExportImages()
    
    let exportView = AllCharacterInfosLayout(
      playableCharacters: playableCharacters,
      travelersInPlay: travelersInPlay,
      fabledInPlay: fabledInPlay,
      useScrollView: false,
      isExporting: true,
      exportImages: images
    )
    .frame(width: 960)
    .fixedSize(horizontal: false, vertical: true)
    .padding(.vertical, 30)
    .background(Color.mainbg)
    
    let renderer = ImageRenderer(content: exportView)
    renderer.scale = UIScreen.main.scale
    renderer.proposedSize = ProposedViewSize(width: 960, height: nil)
    
    guard let image = renderer.uiImage else {
      print("Failed to render all character infos image.")
      isSavingImage = false
      return
    }
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    isSavingImage = false
  }
  
  private func preloadExportImages() async -> [String: UIImage] {
    let urls = allImageURLStrings()
    var result: [String: UIImage] = [:]
    
    await withTaskGroup(of: (String, UIImage?).self) { group in
      for urlString in urls {
        group.addTask {
          guard let url = URL(string: urlString) else {
            return (urlString, nil)
          }
          
          do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let image = UIImage(data: data)
            return (urlString, image)
          } catch {
            return (urlString, nil)
          }
        }
      }
      
      for await (urlString, image) in group {
        if let image = image {
          result[urlString] = image
        }
      }
    }
    
    return result
  }
  
  private func allImageURLStrings() -> [String] {
    var urls: [String] = []
    
    urls += playableCharacters.map { $0.imageURL }
    urls += travelersInPlay.map { $0.imageURL }
    urls += fabledInPlay.map { $0.imageURL }
    urls += [爪牙信息.imageURL, 恶魔信息.imageURL]
    
    return Array(Set(urls)).filter { !$0.isEmpty }
  }
}
