//
//  InventoryView.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 5/27/25.
//
import SwiftUI

struct InventoryView: View {
    @State private var startGame = false
    let band: PotawatomiBand
    let dodem: Dodem
    let role: Role
    let gears: [Gear]
    let aptitude: MusicalAptitude
    let instrument: String
    let grandfatherStats: GrandfatherStats
    let globalStats: GlobalStats

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("🌌 Your Journey Begins")
                    .font(.largeTitle)
                    .bold()
                
                Group {
                    Text("Band: \(band.emoji) \(band.rawValue)")
                    Text("Clan: \(dodem.emoji) \(dodem.rawValue)")
                    
                    if let profile = dodemRoles[dodem] {
                        Text("Peacetime Role: \(profile.peacetimeEmoji) \(profile.peacetime)")
                        Text("Wartime Role: \(profile.wartimeEmoji) \(profile.wartime)")
                        Text(profile.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    Text("Musical Aptitude: \(aptitude.emoji) \(aptitude.rawValue)")
                    Text("Instrument: \(instrument)")
                    Text(instrumentDescription(for: instrument))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Group {
                        Text("Grandfather Teachings")
                            .font(.headline)
                        
                        Text("Wisdom: \(grandfatherStats.wisdom)")
                        Text("Love: \(grandfatherStats.love)")
                        Text("Respect: \(grandfatherStats.respect)")
                        Text("Bravery: \(grandfatherStats.bravery)")
                        Text("Honesty: \(grandfatherStats.honesty)")
                        Text("Humility: \(grandfatherStats.humility)")
                        Text("Truth: \(grandfatherStats.truth)")
                        
                        Divider()
                        
                        Text("Global Stats")
                            .font(.headline)
                        
                        Text("Spiritual Power: \(globalStats.spiritualPower)")
                        Text("Community Trust: \(globalStats.communityTrust)")
                        Text("Physical Resilience: \(globalStats.physicalResilience)")
                        Text("Ancestral Connection: \(globalStats.ancestralConnection)")
                    }
                    .font(.body)
                    .fixedSize(horizontal: false, vertical: true)
                    
                    ForEach(gears, id: \.self) { gear in
                        Text("Sacred Item: \(gear.emoji) \(gear.rawValue)")
                        Text(gearDescription(for: gear))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .font(.title2)
                
                Spacer()
                
                Button("Begin Your Journey") {
                                startGame = true
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .fullScreenCover(isPresented: $startGame) {
                                GameView()
                            }
                
                
            }
            .padding()
        }
    }
}
