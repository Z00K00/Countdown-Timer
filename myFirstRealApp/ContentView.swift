//
//  ContentView.swift
//  myFirstRealApp
//
//  Created by Kraig Larson on 2/28/24.
//

import SwiftUI

struct ContentView: View {
    let secondTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var countdown: Int = 180
    @State var isPaused = true
    
    var seconds: Int {
        secondsToHoursMinutesSeconds(countdown).seconds
    }    
    
    var minutes: Int {
        secondsToHoursMinutesSeconds(countdown).minutes
    }
    
    var hours: Int {
        secondsToHoursMinutesSeconds(countdown).hours
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(hours) Hours")
                Text("\(minutes) Minutes")
                Text("\(seconds) Seconds")
            }
            
            if isPaused {
                Button("Start Countdown") {
                    print("Start Countdown")
                    resetCountdown()
                    isPaused = false
                }
            } else {
                Button("Pause Countdown") {
                    print("Pause Countdown")
                    isPaused = true
                }
            }
        }
        .onReceive(secondTimer, perform: { _ in
//            print("Update Countdown")
            if !isPaused {
                countdown -= 1
            }
        })
    }
    
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (hours: Int, minutes: Int, seconds: Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func resetCountdown() {
        countdown = 180
    }
}

//struct CountdownDetails {}

#Preview {
    ContentView()
}
