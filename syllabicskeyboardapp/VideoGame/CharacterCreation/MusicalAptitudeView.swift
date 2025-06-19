//
//  MusicalAptitudeView.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 5/27/25.
//
import SwiftUI

struct MusicalAptitudeView: View {
    let selectedAptitude: MusicalAptitude?
    let selectedDodem: Dodem?
    @Binding var selectedDrum: DrumType?
    @Binding var selectedFlute: FluteType?
    @Binding var selectedRattle: RattleType?

    var body: some View {
        if let aptitude = selectedAptitude {
            VStack(alignment: .leading, spacing: 12) {
                Text("Musical Aptitude: \(aptitude.emoji) \(aptitude.rawValue)")
                    .font(.headline)

                if let dodem = selectedDodem {
                    Text(aptitudeDescription(for: dodem))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                }

                // Then continue with switch case for instrument selection...

                switch aptitude {
                case .drum:
                    Text("Choose Your Drum Type")
                    HStack(spacing: 16) {
                        ForEach(DrumType.allCases, id: \.self) { drum in
                            SelectableCard(title: drum.rawValue, emoji: "🥁", isSelected: selectedDrum == drum) {
                                selectedDrum = drum
                            }
                        }
                    }

                case .flute:
                    Text("Choose Your Flute Type")
                    HStack(spacing: 16) {
                        ForEach(FluteType.allCases, id: \.self) { flute in
                            SelectableCard(title: flute.rawValue, emoji: "🎼", isSelected: selectedFlute == flute) {
                                selectedFlute = flute
                            }
                        }
                    }

                case .rattle:
                    Text("Choose Your Rattle Type")
                    HStack(spacing: 16) {
                        ForEach(RattleType.allCases, id: \.self) { rattle in
                            SelectableCard(title: rattle.rawValue, emoji: "🔔", isSelected: selectedRattle == rattle) {
                                selectedRattle = rattle
                            }
                        }
                    }
                }
            }
        }
    }
}
