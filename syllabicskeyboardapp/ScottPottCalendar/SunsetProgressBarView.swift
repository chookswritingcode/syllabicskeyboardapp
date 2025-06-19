//
//  SunsetProgressBarView.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 5/29/25.
//
import SwiftUI

struct SunsetProgressBarView: View {
    @StateObject private var sunManager = SunPhaseManager()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Since last sunset: \(sunManager.timeSinceSunset)")
                .font(.subheadline)

            ProgressView(value: sunManager.progressToNextSunset)
                .progressViewStyle(LinearProgressViewStyle())
                .scaleEffect(x: 1, y: 3, anchor: .center)
                .padding(.trailing)

          //  Text(String(format: "%.0f%% of sunset cycle passed", sunManager.progressToNextSunset * 100))
           //     .font(.caption)
           //     .foregroundColor(.secondary)
        }
        .padding()
        .onAppear {
            sunManager.startTrackingSunset()
        }
    }
}
