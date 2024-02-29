//
//  ContentView.swift
//  myFirstRealApp
//
//  Created by Krajg Larson on 2/28/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var timeManager = TimeManager()
    @State var timers: [CountdownDetails] = []
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                ForEach($timers) { $timer in
                    CountdownCell(countdownDetails: $timer) {
                        timers.removeAll(where: { $0.id == timer.id })
                    }
                        .padding()
                        .background(timer.color)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
            }
            .toolbar(content: {
                Button {
                    timers.append(CountdownDetails(timer: 180, name: "Timer \(timers.count+1)", color: Color(red: .random(in: 0..<1), green: .random(in: 0..<1), blue: .random(in: 0..<1))))
                } label: {
                    Image(systemName: "plus")
                }
            })
        }
        .environmentObject(timeManager)
    }
}

class TimeManager: ObservableObject {
    @Published var secondTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
}

#Preview {
    ContentView()
}
