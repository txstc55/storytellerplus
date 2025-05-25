//import SwiftUI
//
//struct RecorderView: View {
//  @StateObject private var recorder = AudioRecorder()
//
//  @State private var isRecording = false
//  @State private var transcriptionResult = "Press record to start..."
//  @State private var isTranscribing = false
//
//  var body: some View {
//    VStack(spacing: 20) {
//      Text("🎙 Whisper Recorder")
//        .font(.title)
//        .fontWeight(.bold)
//
//      TextEditor(text: .constant(isTranscribing ? "Transcribing..." : transcriptionResult))
//        .frame(height: 200)
//        .padding()
//        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
//
//      Button(action: handleButtonPress) {
//        Text(isRecording ? "🛑 Stop" : "🎤 Record")
//          .font(.headline)
//          .frame(width: 200, height: 50)
//          .background(isRecording ? Color.red : Color.green)
//          .foregroundColor(.white)
//          .cornerRadius(12)
//      }
//    }
//    .padding()
//  }
//
//  private func handleButtonPress() {
//    if isRecording {
//      recorder.stopRecording()
//      isRecording = false
//      isTranscribing = true
//      transcriptionResult = "Transcribing..."
//
//      Task {
//        do {
//          let samples = try recorder.getAudioSamplesAsFloat()
//          print("Audio samples: \(samples.count) frames")
//          let segments = try await transcribeAudio(audioFrames: samples)
//          let fullText = segments.map(\.text).joined(separator: " ")
//          await MainActor.run {
//            transcriptionResult = fullText
//            isTranscribing = false
//          }
//        } catch {
//          await MainActor.run {
//            transcriptionResult = "❌ Transcription failed: \(error.localizedDescription)"
//            isTranscribing = false
//          }
//        }
//      }
//    } else {
//      transcriptionResult = "Recording..."
//      recorder.startRecording()
//      isRecording = true
//    }
//  }
//}
//
//#Preview {
//  RecorderView()
//}
//
