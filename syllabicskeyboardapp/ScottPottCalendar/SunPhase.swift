//
//  SunPhase.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 5/29/25.
//

import Foundation
import SunKit
import CoreLocation
import SwiftUI

class SunPhaseManager: ObservableObject {
    @Published var timeSinceSunset: String = "00:00:00"
    @Published var progressToNextSunset: Double = 0.0
    
    private var timer: Timer?
    private var lastSunsetTime: Date?
    private var nextSunsetTime: Date?

    func startTrackingSunset(for location: CLLocation = CLLocation(latitude: 35.2271, longitude: -80.8431)) {
        let now = Date()
        let timeZone = TimeZone.current
        var sun = Sun(location: location, timeZone: timeZone)
        sun.setDate(now)

        if now >= sun.sunset {
            lastSunsetTime = sun.sunset
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: now)!
            sun.setDate(tomorrow)
            nextSunsetTime = sun.sunset
        } else {
            let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: now)!
            sun.setDate(yesterday)
            lastSunsetTime = sun.sunset
            sun.setDate(now)
            nextSunsetTime = sun.sunset
        }

        startTimer()
    }

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.update()
        }
    }

    private func update() {
        guard let sunset = lastSunsetTime else { return }

        let now = Date()
        let interval = now.timeIntervalSince(sunset)
        self.timeSinceSunset = formatTime(interval)

        if let next = nextSunsetTime {
            let total = next.timeIntervalSince(sunset)
            let progress = min(max(now.timeIntervalSince(sunset) / total, 0), 1)
            self.progressToNextSunset = progress
        }
    }

    private func formatTime(_ interval: TimeInterval) -> String {
        let hours = Int(interval) / 3600
        let minutes = (Int(interval) % 3600) / 60
        let seconds = Int(interval) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
struct SunsetProgressView: View {
    @StateObject private var sunManager = SunPhaseManager()
    
    var body: some View {
        VStack {
            Text("Since last sunset:")
            Text(sunManager.timeSinceSunset)
                .font(.largeTitle)
                .monospacedDigit()
        }
        .onAppear {
            sunManager.startTrackingSunset()
        }
    }
}
