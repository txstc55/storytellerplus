//
//  ContentView.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/18/25.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers
struct ContentView: View {
  //  @Environment(\.modelContext) private var modelContext
  //  @Query private var items: [Item]
  @State private var viewNumber = 0
  @State private var loadLast = false
  @State private var isFileImporterPresented = false
  @State private var jsonArray: [[String: Any]] = []
  let startDate = Date() // for the animation effect
  var body: some View {
    
    ZStack{
      TimelineView(.periodic(from: .now, by: 1.0 / 15.0)) { context in
        let time = Float(context.date.timeIntervalSince(startDate))
        ZStack{
          Color.white
            .colorEffect(ShaderLibrary.dotPatternShader(
              .float(80),
              .float(1),
              .float(time)))
            .edgesIgnoringSafeArea(.all)
        }
      }
//      Color.mainbg
//        .edgesIgnoringSafeArea(.all)
        
      ZStack{
        if viewNumber == 0 {
          VStack{
            Spacer()
            Button(action: {
              isFileImporterPresented = true
              loadLast = false
            }){
              Text("上传JSON")
                .font(.system(size: 20,  design: .rounded))
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.black)
                .padding(.horizontal, 10)
                .padding(.vertical, 3)
                .frame(width: 150)
                .background(.white.opacity(0.5))
                .cornerRadius(30)
                .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 3))
            }
            Button(action: {
              loadLast = true
              viewNumber = 1
            }){
              Text("返回小镇")
                .font(.system(size: 20,  design: .rounded))
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.black)
                .padding(.horizontal, 10)
                .padding(.vertical, 3)
                .frame(width: 150)
                .background(.white.opacity(0.5))
                .cornerRadius(30)
                .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 3))
                
            }
            .padding(.top, 20)
            Spacer()
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .transition(.opacity)
          .fileImporter(
            isPresented: $isFileImporterPresented,
            allowedContentTypes: [.json],
            allowsMultipleSelection: false
          ) { result in
            switch result {
            case .success(let urls):
              if let selectedFile = urls.first {
                readJSON(from: selectedFile)
              }
            case .failure(let error):
              print("Failed to import file: \(error.localizedDescription)")
            }
          }
        }else if viewNumber == 1{
          StoryTellerView(currentView: $viewNumber, loadLast: $loadLast, playJSON: jsonArray)
            .transition(.opacity)
        }
      } // end of inner zstack
      .animation(.easeInOut(duration: 0.5), value: viewNumber)
      
    }// end of the outer zstack
    .preferredColorScheme(.light)
    
  }
  private func readJSON(from url: URL) {
    guard url.startAccessingSecurityScopedResource() else {
      print("Could not access the security-scoped resource.")
      return
    }
    defer { url.stopAccessingSecurityScopedResource() }
    do {
      let data = try Data(contentsOf: url)
      if let array = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
        jsonArray = array
        print("JSON Array Loaded")
        viewNumber = 1
      } else {
        print("Expected an array of dictionaries at top level.")
      }
    } catch {
      print("Failed to read JSON: \(error.localizedDescription)")
    }
  }
  
}

#Preview {
  ContentView()
//    .modelContainer(for: Item.self, inMemory: true)
}
