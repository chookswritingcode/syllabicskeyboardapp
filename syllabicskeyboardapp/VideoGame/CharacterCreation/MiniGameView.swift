//
//  MiniGameView.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 5/26/25.
//
import SwiftUI

// MARK: - Enums (Music, band, dodem)
enum MusicalAptitude: String, CaseIterable {
    case drum = "Drum"
    case flute = "Flute"
    case rattle = "Rattle"

    var emoji: String {
        switch self {
        case .drum: return "🥁"
        case .flute: return "🎼"
        case .rattle: return "🔔"
        }
    }
}
enum DrumType: String, CaseIterable {
    case waterDrum = "Water Drum"
    case handDrum = "Hand Drum"
    case powwowDrum = "Powwow Drum"
}
enum FluteType: String, CaseIterable {
    case forestFlute = "Forest Flute"
    case loveFlute = "Love Flute"
    case grandfatherFlute = "Grandfather Flute"
}
enum RattleType: String, CaseIterable {
    case rawhide = "Rawhide Rattle"
    case gourd = "Gourd Rattle"
    case turtle = "Turtle Rattle"
}

enum PotawatomiBand: String, CaseIterable {
    case citizen = "Citizen Potawatomi"
    case pokagon = "Pokagon Band"
    case prairie = "Prairie Band"
    case hannahville = "Hannahville"
    case forestCounty = "Forest County"
    case gunLake = "Gun Lake Band"
    case nottawaseppi = "Nottawaseppi"
    case walpole = "Walpole Island"
    case wikwemikong = "Wikwemikong"

    var emoji: String {
        switch self {
        case .citizen: return "🧭"
        case .pokagon: return "⛺️"
        case .prairie: return "🌾"
        case .hannahville: return "🏕"
        case .forestCounty: return "🌲"
        case .gunLake: return "💧"
        case .nottawaseppi: return "🏞"
        case .walpole: return "🦅"
        case .wikwemikong: return "🎉"
        }
    }
}
enum Dodem: String, CaseIterable {
    case makwa = "Makwa (Bear)"
    case waabizheshi = "Waabizheshi (Marten)"
    case mko = "Mko (Wolf)"
    case ajijaak = "Ajijaak (Crane)"
    case maang = "Maang (Loon)"
    case name = "Name (Sturgeon)"
    case bneshi = "Bneshi (Bird)"
    case wawashkesh = "Wawashkesh (Deer)"
    case mshike = "Mshike (Turtle)"
    case animki = "Animki (Thunderbird)"
    case awaazisii = "Awaazisii (Catfish)"

    var emoji: String {
        switch self {
        case .makwa: return "🐻"
        case .waabizheshi: return "🦫"
        case .mko: return "🐺"
        case .ajijaak: return "🗣"
        case .maang: return "🦆"
        case .name: return "🐟"
        case .bneshi: return "🐦"
        case .wawashkesh: return "🦌"
        case .mshike: return "🐢"
        case .animki: return "🌩"
        case .awaazisii: return "🐡"
        }
    }
}

enum Gear: String, CaseIterable {
    case pipeOfPeace = "Pipe of Peace"
    case totems = "Totems"
    case wampumBelt = "Wampum Belt"
    case talkingStick = "Talking Stick"
    case visionPowder = "Vision Powder"
    case waterGourd = "Water Gourd"
    case shakingTent = "Shaking Tent"
    case altarStones = "Altar Stones"

    var emoji: String {
        switch self {
        case .pipeOfPeace: return "🪶"
        case .totems: return "🪵"
        case .wampumBelt: return "💠"
        case .talkingStick: return "🗣️"
        case .visionPowder: return "🌫"
        case .waterGourd: return "🫙"
        case .shakingTent: return "⛺️"
        case .altarStones: return "🪨"
        }
    }
}

struct PotawatomiBandDetail {
    let name: PotawatomiBand
    let location: String
    let history: String
    let contributions: String
}

// MARK: - Mini Game View
struct MiniGameView: View {
    @State private var selectedBand: PotawatomiBand? = nil
    @State private var selectedDodem: Dodem? = nil
    @State private var selectedRole: Role? = nil
    //below selected gear enables multioples to be selected and stored
    @State private var selectedGears: Set<Gear> = []
    @State private var gearSelectionWarning: Bool = false
    //
    @State private var selectedAptitude: MusicalAptitude? = nil
    @State private var selectedDrum: DrumType? = nil
    @State private var selectedFlute: FluteType? = nil
    @State private var selectedRattle: RattleType? = nil
    
    @State private var selectedGrandfatherStats: GrandfatherStats? = nil
    @State private var selectedGlobalStats: GlobalStats? = nil
    
    var body: some View {
       // let bandDetail: PotawatomiBandDetail? = selectedBand.flatMap{ bandDetails[$0] }
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    Text("🪶 Choose your band and dodem")
                        .font(.largeTitle)
                        .bold()
                    // Band Selection (should always show)
                    BandSelectionView(
                        selectedBand: $selectedBand,
                        selectedGlobalStats: $selectedGlobalStats
                    )
                    
                    // 1. Band information
                    BandDetailView(
                        selectedBand: selectedBand,
                        bandDetail: selectedBand.flatMap { bandDetails[$0] }
                    )
                    // 2. Dodem
                    if selectedBand != nil {
                        DodemSelectionsView(
                            selectedDodem: $selectedDodem,
                            selectedRole: $selectedRole,
                            selectedAptitude: $selectedAptitude,
                            selectedGears: $selectedGears,
                            selectedGrandfatherStats: $selectedGrandfatherStats
                        )
                    }
                    
                    /* 3. Role
                    if selectedDodem != nil {
                        RoleView(selectedRole: $selectedRole)
                    }*/
                    // 4. Musical Aptitude
                    MusicalAptitudeView(
                        selectedAptitude: selectedAptitude,
                        selectedDodem: selectedDodem,
                        selectedDrum: $selectedDrum,
                        selectedFlute: $selectedFlute,
                        selectedRattle: $selectedRattle
                    )
                    // 5. Gear
                    if selectedAptitude != nil {
                        SacredItemGridView(
                            selectedGears: $selectedGears,
                            gearSelectionWarning: $gearSelectionWarning
                        )
                    }
                    
                    // Final Navigation
                    if let band = selectedBand,
                       let dodem = selectedDodem,
                       let role = selectedRole,
                       let aptitude = selectedAptitude,
                       let instrument = (
                           selectedDrum?.rawValue ??
                           selectedFlute?.rawValue ??
                           selectedRattle?.rawValue
                       ),
                       let grandfatherStats = selectedGrandfatherStats,
                       let globalStats = selectedGlobalStats,
                       !selectedGears.isEmpty {

                        CompletionButtonView(
                            band: band,
                            dodem: dodem,
                            role: role,
                            aptitude: aptitude,
                            instrument: instrument,
                            gears: Array(selectedGears),
                            grandfatherStats: grandfatherStats,
                            globalStats: globalStats
                        )
                    }
                }
                .padding()
            }
        }}
    //helper function for autoassigning music aptitude based on dodem moved to its own file
}

// MARK: - Supporting Models

enum Role: String, CaseIterable {
    case firekeeper = "Firekeeper"
    case trailwatcher = "Trailwatcher"
    case medicineGatherer = "Medicine Gatherer"
    case protector = "Protector"

    var emoji: String {
        switch self {
        case .firekeeper: return "🔥"
        case .trailwatcher: return "🧰"
        case .medicineGatherer: return "🌿"
        case .protector: return "🪣"
        }
    }
}





// MARK: - Selectable Card

struct SelectableCard: View {
    let title: String
    let emoji: String
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            VStack(spacing: 8) {
                Text(emoji).font(.largeTitle)
                Text(title).font(.subheadline)
            }
            .padding()
            .background(isSelected ? Color.blue.opacity(0.7) : Color.gray.opacity(0.2))
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Inventory View moved to its own file

// MARK: - Band Dictionary
let bandDetails: [PotawatomiBand: PotawatomiBandDetail] = [
    .citizen: PotawatomiBandDetail(
        name: .citizen,
        location: "Shawnee, Oklahoma",
        history: "Descendants of the Mission Band, relocated from the Great Lakes to Kansas and then Oklahoma during Indian Removal.",
        contributions: "Built the Cultural Heritage Center and revitalized traditional crafts and language."
    ),
    .pokagon: PotawatomiBandDetail(
        name: .pokagon,
        location: "Southwest Michigan and Northern Indiana",
        history: "Named for Chief Pokagon, who resisted removal. Remained in Michigan through legal diplomacy.",
        contributions: "Prominent in language revitalization and ecological knowledge."
    ),
    .prairie: PotawatomiBandDetail(
        name: .prairie,
        location: "Mayetta, Kansas",
        history: "Relocated from the Great Lakes region. Known as the Prairie People.",
        contributions: "Maintain a buffalo herd and continue ceremonial traditions tied to the land."
    ),
    .hannahville: PotawatomiBandDetail(
        name: .hannahville,
        location: "Upper Peninsula, Michigan",
        history: "Formed by Potawatomi who avoided relocation. Land was granted in 1913.",
        contributions: "Focused on education, governance, and inter-tribal collaboration."
    ),
    .forestCounty: PotawatomiBandDetail(
        name: .forestCounty,
        location: "Forest County, Wisconsin",
        history: "Settled there in the 1880s, federally recognized in 1913.",
        contributions: "Strong investment in language education and environmental programs."
    ),
    .gunLake: PotawatomiBandDetail(
        name: .gunLake,
        location: "Bradley, Michigan",
        history: "Named after Chief Match-e-be-nash-she-wish. Federally recognized in 1999.",
        contributions: "Known for natural resource protection and community leadership."
    ),
    .nottawaseppi: PotawatomiBandDetail(
        name: .nottawaseppi,
        location: "Athens, Michigan",
        history: "Returned to ancestral territory after escaping removal. Recognized in 1995.",
        contributions: "Founded a tribal court, health center, and community development projects."
    ),
    .walpole: PotawatomiBandDetail(
        name: .walpole,
        location: "Walpole Island, Ontario, Canada",
        history: "Unceded territory with Ojibwe, Odawa, and Potawatomi peoples.",
        contributions: "Champions of Indigenous conservation and bobwhite quail restoration."
    ),
    .wikwemikong: PotawatomiBandDetail(
        name: .wikwemikong,
        location: "Manitoulin Island, Ontario, Canada",
        history: "An unceded territory that resisted land cession treaties.",
        contributions: "Hosts one of Canada's largest powwows and a cultural arts center."
    )
]
// MARK: - Dodem Dictionary
struct ClanProfile {
    let defaultRole: Role
    //let defaultTrait: Trait
}

let dodemAssignments: [Dodem: ClanProfile] = [
    .makwa: ClanProfile(defaultRole: .protector),
    .waabizheshi: ClanProfile(defaultRole: .trailwatcher),
    .mko: ClanProfile(defaultRole: .protector),
    .ajijaak: ClanProfile(defaultRole: .firekeeper),
    .maang: ClanProfile(defaultRole: .firekeeper),
    .name: ClanProfile(defaultRole: .medicineGatherer),
    .bneshi: ClanProfile(defaultRole: .trailwatcher),
    .wawashkesh: ClanProfile(defaultRole: .medicineGatherer),
    .mshike: ClanProfile(defaultRole: .protector),
    .animki: ClanProfile(defaultRole: .firekeeper),
    .awaazisii: ClanProfile(defaultRole: .trailwatcher)
]
let dodemToAptitude: [Dodem: MusicalAptitude] = [
    .makwa: .drum,
    .waabizheshi: .rattle,
    .mko: .rattle,
    .ajijaak: .flute,
    .maang: .flute,
    .name: .drum,
    .bneshi: .flute,
    .wawashkesh: .rattle,
    .mshike: .drum,
    .animki: .drum,
    .awaazisii: .flute
]


#Preview {
    MiniGameView()
}
