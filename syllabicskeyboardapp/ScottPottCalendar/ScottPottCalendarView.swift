//
//  ScottPottCalendarView.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 5/27/25.
//
import Foundation
import MoonKit
import SwiftUI
import SunKit
import CoreLocation

struct ScottPottCalendarView: View {
    @State private var today = LunasolarDate.from()
    @State private var timeSinceSunset: String = "--:--:--"
    @State private var timer: Timer?
    @StateObject private var locationManager = LocationManager()
    @StateObject private var sunManager = SunPhaseManager()


    var body: some View {
        VStack(spacing: 16) {
            Text(today.moonPhase.emoji)
                .font(.system(size: 200))

            Text(today.formatted)
                .font(.title)
                .bold()

            Text("\(today.moonName)")
                .font(.system(size: 64))
                .bold()
            
            Text("\(today.moonNameEnglish)")
                .font(.system(size: 32))

            if let upcomingShift = nextSeasonalLunasolarDate() {
                VStack(spacing: 4) {
                    Text("Next Seasonal Shift")
                        .font(.headline)
                    Text("\(upcomingShift.formatted) – \(upcomingShift.holidays.joined(separator: ", "))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top)
            }
            
            Text(today.culturalContext)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            if !today.holidays.isEmpty {
                VStack(spacing: 8) {
                    Text("Important Days")
                        .font(.headline)

                    ForEach(today.holidays, id: \.self) { holiday in
                        Text("• \(holiday)")
                            .font(.body)
                    }
                }
                .padding(.top)
            }
        }
        Spacer()

        // ⏳ Add sunset countdown display in bottom-left
                    HStack {
                        //Text("⏳ Since Sunset: \(sunManager.timeSinceSunset)")
                      //  Spacer()
                        SunsetProgressBarView()
                            .font(.footnote)
                            .padding(.leading)
                        Spacer()
                    }
               .padding(.bottom)
        Spacer()

        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Gregorian: \(formatDate(for: .gregorian))")
                Text("Chinese: \(formatDate(for: .chinese))")
                Text("Ethiopian: \(formatDate(for: .ethiopicAmeteMihret))")
                Text("Persian: \(formatDate(for: .persian))")
            }
            .font(.caption2)
            .foregroundColor(.gray)
            .padding([.leading, .bottom], 12)
            
            Spacer()
        }
        .padding()
        .onAppear {
            today = LunasolarDate.from()
            sunManager.startTrackingSunset()
        }
        .onDisappear {
                timer?.invalidate()
            }
    }
}
#Preview {
    ScottPottCalendarView()
}

// MARK: - Helper Functions

func formattedDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yy"
    return formatter.string(from: date)
}
