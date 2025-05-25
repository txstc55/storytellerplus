import AVFoundation

class AudioRecorder: NSObject, ObservableObject {
  private var recorder: AVAudioRecorder?
  
  // Store all audio file URLs
  @Published private(set) var audioURLs: [URL] = []
  
  // Current recording target URL
  private var currentRecordingURL: URL?
  
  func startRecording() {
    AVAudioSession.sharedInstance().requestRecordPermission { granted in
      if granted {
        DispatchQueue.main.async {
          self.startRecordingInternal()
        }
      } else {
        print("Microphone permission denied")
      }
    }
  }
  
  private func startRecordingInternal() {
    let session = AVAudioSession.sharedInstance()
    do {
      try session.setCategory(.playAndRecord, mode: .default)
      try session.setActive(true)
      
      // Generate a unique filename
      let timestamp = Int(Date().timeIntervalSince1970)
      let filename = "recording-\(timestamp).wav"
      let url = FileManager.default.temporaryDirectory.appendingPathComponent(filename)
      currentRecordingURL = url
      
      let settings: [String: Any] = [
        AVFormatIDKey: Int(kAudioFormatLinearPCM),
        AVSampleRateKey: 16000,
        AVNumberOfChannelsKey: 1,
        AVLinearPCMBitDepthKey: 16,
        AVLinearPCMIsFloatKey: false
      ]
      
      recorder = try AVAudioRecorder(url: url, settings: settings)
      recorder?.record()
      print("Recording started: \(filename)")
    } catch {
      print("Recording failed: \(error)")
    }
  }
  
  func stopRecording() {
    recorder?.stop()
    if let url = currentRecordingURL {
      audioURLs.append(url)
      print("Recording saved to: \(url.lastPathComponent)")
    }
    currentRecordingURL = nil
  }
  
  func getLatestAudioURL() -> URL? {
    return audioURLs.last
  }
  
  func getAudioSamplesAsFloat(from url: URL) throws -> [Float] {
    let file = try AVAudioFile(forReading: url)
    
    let processingFormat = AVAudioFormat(commonFormat: .pcmFormatFloat32,
                                         sampleRate: 16000,
                                         channels: 1,
                                         interleaved: false)!
    
    let converter = AVAudioConverter(from: file.processingFormat, to: processingFormat)!
    let frameCount = AVAudioFrameCount(file.length)
    
    guard let outputBuffer = AVAudioPCMBuffer(pcmFormat: processingFormat, frameCapacity: frameCount) else {
      throw NSError(domain: "Audio", code: -1, userInfo: [NSLocalizedDescriptionKey: "Buffer allocation failed"])
    }
    
    try converter.convert(to: outputBuffer, error: nil) { inNumPackets, outStatus in
      outStatus.pointee = .haveData
      
      do {
        let inputBuffer = AVAudioPCMBuffer(pcmFormat: file.processingFormat, frameCapacity: inNumPackets)!
        try file.read(into: inputBuffer)
        return inputBuffer
      } catch {
        print("Error reading input buffer for conversion: \(error)")
        return nil
      }
    }
    
    guard let floatChannelData = outputBuffer.floatChannelData else {
      throw NSError(domain: "Audio", code: -2, userInfo: [NSLocalizedDescriptionKey: "No float channel data"])
    }
    
    let frameLength = Int(outputBuffer.frameLength)
    let floatBuffer = UnsafeBufferPointer(start: floatChannelData[0], count: frameLength)
    return Array(floatBuffer)
  }
}

