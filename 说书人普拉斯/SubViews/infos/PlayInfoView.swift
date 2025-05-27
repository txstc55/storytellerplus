//
//  PlayInfo.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/23/25.
//

import SwiftUI

struct PlayInfo: View {
  @Binding var playName: String
  @Binding var playAuthor: String
  var body: some View {
    HStack {
      Spacer()
      Text(playName)
        .font(.system(size: 20, design: .rounded))
        .fontWeight(.bold)
      +
      Text(" by ")
        .font(.system(size: 20, design: .rounded))
        .fontWeight(.semibold)
        .foregroundColor(.black.opacity(0.8))
      +
      Text(playAuthor)
        .font(.system(size: 20, design: .rounded))
        .fontWeight(.bold)
    }
    .lineLimit(1)
    .truncationMode(.tail)
  }
}
