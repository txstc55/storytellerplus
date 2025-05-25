//
//  Transcriber.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/23/25.
//

import Foundation
import SwiftWhisper
//let modelURL = Bundle.main.url(forResource: "ggml-medium-q8_0", withExtension: "bin")
//let whisper = Whisper(fromFileURL: modelURL)
var modelURL: URL? {
  Bundle.main.url(forResource: "ggml-medium-q5_0", withExtension: "bin")
}

var whisper: Whisper? = nil

func transcribeAudio(audioFrames: [Float]) async throws -> [Segment] {
  if whisper == nil {
    guard let url = modelURL else {
      print("⚠️ Whisper model file not found in bundle.")
      return [] // or throw a custom error if needed
    }
    whisper = Whisper(fromFileURL: url)
    print("✅ Loaded model from: \(url)")
  }

  guard let whisper = whisper else {
    print("⚠️ Whisper model could not be initialized.")
    return []
  }

  return try await whisper.transcribe(audioFrames: audioFrames)
}
