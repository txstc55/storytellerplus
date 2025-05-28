//
//  TimerView.swift
//  说书人普拉斯
//
//  Created by Xuan Tang on 5/27/25.
//

import SwiftUI

struct TimerView: View{
  @Binding var gameState: Int
  @State private var gameStartTime = Date()
  @State private var currentDate = Date()
  @State private var dayTimeStart = Date()
  @State private var nightTimeStart = Date()
  @State private var timerTimeStart = Date() // for the timer
  @State private var previousTimerElapsed: TimeInterval = 0 // for the timer
  @State private var timerStopped = true // if we are using the timer
  private var timeElapsed: TimeInterval {
    currentDate.timeIntervalSince(gameStartTime)
  }
  private var timeElapsedDay: TimeInterval {
    currentDate.timeIntervalSince(dayTimeStart)
  }
  private var timeElapsedNight: TimeInterval {
     currentDate.timeIntervalSince(nightTimeStart)
  }
  
  private var timerElapsed: TimeInterval {
    previousTimerElapsed +
    currentDate.timeIntervalSince(timerTimeStart)
  }
  
  @State private var formatter = DateComponentsFormatter()
  
  
  // Format time interval into HH:mm:ss
  func formattedTimeElapsed(timeElapsed: TimeInterval)-> String {
    return formatter.string(from: timeElapsed) ?? "00:00:00"
  }
  
  
  
  var body: some View{
    VStack{
      VStack{
        Text("游戏时长")
          .font(.system(size: 20, design: .rounded))
          .fontWeight(.bold)
          .foregroundColor(.black)
        if gameState == 0 {
          Text("00:00:00")
            .font(.system(size: 18, design: .monospaced))
            .fontWeight(.semibold)
            .foregroundColor(.black)
        }else{
          Text(formattedTimeElapsed(timeElapsed: timeElapsed))
            .font(.system(size: 18, design: .monospaced))
            .fontWeight(.semibold)
            .foregroundColor(.black)
        }
      }
      .frame(maxHeight: .infinity)
      VStack{
        if gameState == 1 || gameState == 3{
          Text("夜晚时长")
            .font(.system(size: 20, design: .rounded))
            .fontWeight(.bold)
            .foregroundColor(.black)
          Text(formattedTimeElapsed(timeElapsed: timeElapsedNight))
            .font(.system(size: 18, design: .monospaced))
            .fontWeight(.semibold)
            .foregroundColor(.black)
        }else if gameState == 2 {
          Text("白天时长")
            .font(.system(size: 20, design: .rounded))
            .fontWeight(.bold)
            .foregroundColor(.black)
          Text(formattedTimeElapsed(timeElapsed: timeElapsedDay))
            .font(.system(size: 18, design: .monospaced))
            .fontWeight(.semibold)
            .foregroundColor(.black)
        }
      }
      .frame(maxHeight: .infinity)
      VStack{
        Text("计时器")
          .font(.system(size: 20, design: .rounded))
          .fontWeight(.bold)
          .foregroundColor(.black)
        if timerStopped {
          Text(formattedTimeElapsed(timeElapsed: previousTimerElapsed))
            .font(.system(size: 18, design: .monospaced))
            .fontWeight(.semibold)
            .foregroundColor(.black)
        }else{
          Text(formattedTimeElapsed(timeElapsed: timerElapsed))
            .font(.system(size: 18, design: .monospaced))
            .fontWeight(.semibold)
            .foregroundColor(.black)
        }
      }
      .frame(maxHeight: .infinity)
    }
    .onAppear{
      formatter.allowedUnits = [.hour, .minute, .second]
      formatter.zeroFormattingBehavior = .pad
      if gameState != 0{
        gameStartTime = Date()
        if gameState == 1 || gameState == 3{
          nightTimeStart = Date()
        }else{
          dayTimeStart = Date()
        }
      }
      Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
        currentDate = Date()
      }
      timerStopped = true
    }
    .onChange(of: gameState) {_, newValue in
      if newValue == 1{
        gameStartTime = Date()
        nightTimeStart = Date()
      }else if newValue == 2{
        dayTimeStart = Date()
      }else if newValue == 3 {
        nightTimeStart = Date()
      }
      timerStopped = true
      previousTimerElapsed = 0 // reset the timer when game state changes
    }
    .onTapGesture(count: 1) {
      if timerStopped {
        timerTimeStart = Date()
        timerStopped = false
      }else{
        previousTimerElapsed = timerElapsed // record the previous elapsed time
        timerStopped = true
      }
    }
    .onTapGesture(count: 2) {
      previousTimerElapsed = 0
      timerTimeStart = Date()
    }
    .animation(.easeInOut(duration: 0.3), value: gameState)
  }
}

#Preview{
  TimerView(gameState: .constant(1))
}
