//
//  CCViewHelpers.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 6/2/25.
//
import SwiftUI

//MARK: - BandSelectionView Initial view displaying a horizontal scroll selection list
struct BandSelectionView: View {
    @Binding var selectedBand: PotawatomiBand?
    @Binding var selectedGlobalStats: GlobalStats?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Choose Your Potawatomi Band")
                .font(.headline)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(PotawatomiBand.allCases, id: \.self) { band in
                        SelectableCard(title: band.rawValue, emoji: band.emoji, isSelected: selectedBand == band) {
                            selectedBand = band
                            selectedGlobalStats = defaultGlobalStats[band]
                        }
                    }
                }
            }
        }
    }
}

//MARK: - BandDetailView Display for information about selected Band
struct BandDetailView: View {
    let selectedBand: PotawatomiBand?
    let bandDetail: PotawatomiBandDetail?

    var body: some View {
        if let band = selectedBand {
            VStack(alignment: .leading, spacing: 8) {
                Text("Band: \(band.emoji) \(band.rawValue)")
                    .font(.title2).bold()

                if let detail = bandDetail {
                    Text("📍 Location: \(detail.location)")
                    Text("📖 History: \(detail.history)")
                    Text("⭐ Contributions: \(detail.contributions)")
                } else {
                    Text("No additional information available for this band.")
                }

                Divider()
            }
        }
    }
}
//MARK: - DodemSelectionsView
struct DodemSelectionsView: View {
    @Binding var selectedDodem: Dodem?
    @Binding var selectedRole: Role?
    @Binding var selectedAptitude: MusicalAptitude?
    @Binding var selectedGears: Set<Gear>
    @Binding var selectedGrandfatherStats: GrandfatherStats?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Choose Your Dodem (Clan)")
                .font(.headline)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(Dodem.allCases, id: \.self) { dodem in
                        SelectableCard(title: dodem.rawValue, emoji: dodem.emoji, isSelected: selectedDodem == dodem) {
                            selectedDodem = dodem

                            if let defaultGears = dodemDefaultGears[dodem] {
                                selectedGears = Set(defaultGears)
                            }
                            // Auto-assign Role
                            if let profile = dodemAssignments[dodem] {
                                selectedRole = profile.defaultRole
                            }

                            // Auto-assign Musical Aptitude
                            if let aptitude = dodemToAptitude[dodem] {
                                selectedAptitude = aptitude
                            }
                            selectedGrandfatherStats = defaultGrandfatherStats[dodem]
                        }
                    }
                }
            }
        }
    }
}
//MARK: - RoleView Displays Automatically assigned Role based on Dodem selection
struct RoleView: View {
    @Binding var selectedRole: Role?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Your Role (Based on Clan)")
                .font(.headline)

            Text("You may keep the assigned role or choose another.")
                .font(.caption)
                .foregroundColor(.gray)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(Role.allCases, id: \.self) { role in
                        SelectableCard(title: role.rawValue, emoji: role.emoji, isSelected: selectedRole == role) {
                            selectedRole = role
                        }
                    }
                }
            }
        }
    }
}





//MARK: - CompletionButtonView Final display of stats and completion button
struct CompletionButtonView: View {
    let band: PotawatomiBand
    let dodem: Dodem
    let role: Role
    let aptitude: MusicalAptitude
    let instrument: String
    let gears: [Gear]
    let grandfatherStats: GrandfatherStats
    let globalStats: GlobalStats

    var body: some View {
        NavigationLink(destination:
            InventoryView(
                band: band,
                dodem: dodem,
                role: role,
                gears: gears,
                aptitude: aptitude,
                instrument: instrument,
                grandfatherStats: grandfatherStats,
                globalStats: globalStats
            )
        ) {
            Text("Complete Your Character")
                .font(.title2)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green.opacity(0.7))
                .cornerRadius(12)
        }
        .padding(.top)
    }
}

