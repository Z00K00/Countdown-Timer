//
//  CountdownCell.swift
//  myFirstRealApp
//
//  Created by Kraig Larson on 2/28/24.
//

import SwiftUI

struct CountdownCell: View {
    @EnvironmentObject var timeManager: TimeManager
    
    @Binding var countdownDetails: CountdownDetails
    let onDelete: () -> Void
    @State var isPaused = false
    
    var seconds: Int {
        secondsToHoursMinutesSeconds(countdownDetails.timer).seconds
    }
    
    var minutes: Int {
        secondsToHoursMinutesSeconds(countdownDetails.timer).minutes
    }
    
    var hours: Int {
        secondsToHoursMinutesSeconds(countdownDetails.timer).hours
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(countdownDetails.name)
                    .font(.title)
                Button(action: onDelete, label: {
                    Image(systemName: "minus.circle.fill")
                })
                .foregroundStyle(Color.red)
            }
            HStack {
                Text("\(hours) Hours")
                Text("\(minutes) Minutes")
                Text("\(seconds) Seconds")
            }
            
            if isPaused {
                Button("Start Countdown") {
                    print("Start Countdown")
//                    resetCountdown()
                    isPaused = false
                }
            } else {
                Button("Pause Countdown") {
                    print("Pause Countdown")
                    isPaused = true
                }
            }
        }
        .onReceive(timeManager.secondTimer, perform: { _ in
//            print("Update Countdown")
            if !isPaused {
                countdownDetails.timer -= 1
            }
        })
    }
    
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (hours: Int, minutes: Int, seconds: Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func resetCountdown() {
        countdownDetails.timer = 180
    }
}

struct CountdownDetails: Identifiable {
    let id = UUID()
    var timer: Int
    let name: String
    let color: Color
}
