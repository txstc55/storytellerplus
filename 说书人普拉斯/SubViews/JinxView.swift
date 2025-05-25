//
//  JinxView.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/23/25.
//
import SwiftUI
struct JinxView: View {
  @Binding var jinxList: [Jinx]
  var body: some View {
    ScrollView(showsIndicators: false) {
      ForEach(jinxList, id: \.name) { jinx in
        HStack{
          if jinx.type == 0 {
            Color.clear
              .frame(width: 50, height: 50)
          }else{
            CachedImageView(urlString: jinx.imageURL)
              .frame(width: 50, height: 50)
          }
          VStack(alignment: .leading){
            Text(jinx.name)
              .font(.system(size: 20, design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.black)
            Text(jinx.description)
              .font(.system(size: 15, design: .rounded))
              .fontWeight(.semibold)
              .foregroundColor(.black.opacity(0.8))
          }
          .padding(.top, 2)
          .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 5)
        
      }
      
    } // end of scroll for jinx
  }
}
