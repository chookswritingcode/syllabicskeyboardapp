//
//  CCDictionary.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 6/2/25.
//

import Foundation


//MARK: - 7 Main STATS
//stores dnd like stats based on the 7 Grandfathers
struct GrandfatherStats {
    var wisdom: Int
    var love: Int
    var respect: Int
    var bravery: Int
    var honesty: Int
    var humility: Int
    var truth: Int
}
//additional stats for intereacting with the environment
struct GlobalStats {
    var spiritualPower: Int
    var communityTrust: Int
    var physicalResilience: Int
    var ancestralConnection: Int
}

//optional use of both stat structs in one container for easier calls
struct CharacterStats {
    var grandfather: GrandfatherStats
    var global: GlobalStats
}

import Foundation

// MARK: - Grandfather Teachings by Dodem

let defaultGrandfatherStats: [Dodem: GrandfatherStats] = [
    .makwa: GrandfatherStats(wisdom: 65, love: 60, respect: 80, bravery: 90, honesty: 70, humility: 50, truth: 65),
    .waabizheshi: GrandfatherStats(wisdom: 70, love: 65, respect: 75, bravery: 80, honesty: 65, humility: 60, truth: 70),
    .mko: GrandfatherStats(wisdom: 60, love: 55, respect: 75, bravery: 85, honesty: 70, humility: 55, truth: 65),
    .ajijaak: GrandfatherStats(wisdom: 85, love: 60, respect: 70, bravery: 65, honesty: 80, humility: 65, truth: 85),
    .maang: GrandfatherStats(wisdom: 80, love: 60, respect: 75, bravery: 60, honesty: 70, humility: 70, truth: 80),
    .name: GrandfatherStats(wisdom: 90, love: 60, respect: 80, bravery: 55, honesty: 75, humility: 85, truth: 90),
    .bneshi: GrandfatherStats(wisdom: 75, love: 80, respect: 70, bravery: 60, honesty: 65, humility: 60, truth: 75),
    .wawashkesh: GrandfatherStats(wisdom: 70, love: 75, respect: 80, bravery: 65, honesty: 70, humility: 75, truth: 70),
    .mshike: GrandfatherStats(wisdom: 85, love: 65, respect: 90, bravery: 50, honesty: 75, humility: 90, truth: 85),
    .animki: GrandfatherStats(wisdom: 80, love: 55, respect: 70, bravery: 85, honesty: 80, humility: 60, truth: 90),
    .awaazisii: GrandfatherStats(wisdom: 75, love: 80, respect: 70, bravery: 60, honesty: 60, humility: 85, truth: 70)
]

// MARK: - Global Stats by Potawatomi Band

let defaultGlobalStats: [PotawatomiBand: GlobalStats] = [
    .citizen: GlobalStats(spiritualPower: 70, communityTrust: 60, physicalResilience: 65, ancestralConnection: 55),
    .pokagon: GlobalStats(spiritualPower: 75, communityTrust: 75, physicalResilience: 60, ancestralConnection: 80),
    .prairie: GlobalStats(spiritualPower: 60, communityTrust: 65, physicalResilience: 80, ancestralConnection: 65),
    .hannahville: GlobalStats(spiritualPower: 65, communityTrust: 70, physicalResilience: 70, ancestralConnection: 70),
    .forestCounty: GlobalStats(spiritualPower: 80, communityTrust: 60, physicalResilience: 60, ancestralConnection: 85),
    .gunLake: GlobalStats(spiritualPower: 70, communityTrust: 80, physicalResilience: 65, ancestralConnection: 75),
    .nottawaseppi: GlobalStats(spiritualPower: 65, communityTrust: 85, physicalResilience: 60, ancestralConnection: 70),
    .walpole: GlobalStats(spiritualPower: 90, communityTrust: 75, physicalResilience: 75, ancestralConnection: 95),
    .wikwemikong: GlobalStats(spiritualPower: 85, communityTrust: 80, physicalResilience: 70, ancestralConnection: 90)
]

//MARK: - Musical aptitude and instrument description banks
func aptitudeDescription(for dodem: Dodem) -> String {
    switch dodem {
    case .makwa:
        return "Makwa (Bear) clans are protectors and healers. The drum echoes the Earth’s heartbeat and is used in medicine ceremonies."
    case .waabizheshi:
        return "Waabizheshi (Marten) clans are agile warriors and scouts. Rattles accompany movement and are used in war and dance songs."
    case .mko:
        return "Mko (Wolf) clans are pathfinders and spiritual guardians. The rattle helps bridge the spirit world and the physical in healing rites."
    case .ajijaak:
        return "Ajijaak (Crane) clans lead with clarity and speech. The flute represents the upper voice—used for ceremonial communication and beauty."
    case .maang:
        return "Maang (Loon) clans reflect wisdom and judgment. The flute mirrors their thoughtful voice, used in prayer and internal ceremonies."
    case .name:
        return "Name (Sturgeon) clans are the deep memory of the people. The drum carries ancient knowledge and keeps the rhythm of the ancestors."
    case .bneshi:
        return "Bneshi (Bird) clans are dreamers and spiritual singers. The flute is their voice across realms and through visions."
    case .wawashkesh:
        return "Wawashkesh (Deer) clans nurture harmony and growth. Rattles reflect gentle rhythm, life cycles, and ceremonial motion."
    case .mshike:
        return "Mshike (Turtle) clans are grounded in law and creation. The drum gives structure and stability to teachings and ceremonies."
    case .animki:
        return "Animki (Thunderbird) clans are ceremonial leaders and spirit callers. The drum is the thunder’s voice—central to sacred work."
    case .awaazisii:
        return "Awaazisii (Catfish) clans carry quiet insight and emotion. The flute is their vessel—carrying feeling into prayer and reflection."
    }
}

func instrumentDescription(for name: String) -> String {
    switch name {
    case "Water Drum":
        return "A sacred drum with water inside, used in spiritual medicine ceremonies for its deep, resonant sound."
    case "Hand Drum":
        return "A personal drum used in prayer and everyday ceremony. Symbol of the heartbeat and spiritual persistence."
    case "Powwow Drum":
        return "A large drum shared by a circle of singers during powwows, representing collective unity and spirit."

    case "Forest Flute":
        return "A wooden flute carved from local forest trees. Used in nature to commune with spirits and ancestors."
    case "Love Flute":
        return "A deeply emotional instrument used for courtship and expressing heartfelt longing."
    case "Grandfather Flute":
        return "A ceremonial flute with low tones, used by elders and teachers to pass on songs and teachings."

    case "Rawhide Rattle":
        return "Made from dried hide and filled with seeds or stones. Used in singing and healing ceremonies."
    case "Gourd Rattle":
        return "Made from natural gourds. Common in harvest ceremonies and songs of abundance."
    case "Turtle Rattle":
        return "A sacred rattle symbolizing Turtle Island. Deeply tied to women’s ceremony and earth teachings."

    default:
        return "A traditional instrument used to carry sound, meaning, and memory across generations."
    }
}

//MARK: - Sacred items descriptions
func gearDescription(for item: Gear) -> String {
    switch item {
    case .pipeOfPeace:
        return "A sacred pipe used in council, ceremony, and prayer. Represents truth, peace, and commitment before Creator and community."
    case .totems:
        return "Symbolic representations of family lineage, spiritual allies, and sacred dreams. Often carried or carved as guides and protectors."
    case .wampumBelt:
        return "Beaded belts woven from shell. Used to record treaties, laws, and ancestral knowledge. Each belt is a living record."
    case .talkingStick:
        return "A ceremonial stick passed during council, giving each speaker respectful space to share. Embodies honesty and listening."
    case .visionPowder:
        return "A sacred blend used in vision quests or night ceremonies to invoke spirit guidance. Not recreational—highly respected."
    case .waterGourd:
        return "Used to carry sacred water to ceremonies, songs, and healing rituals. Often accompanied by prayer or song."
    case .shakingTent:
        return "A powerful ceremonial structure used to communicate with spirits. Rare and highly sacred. Used by specialized knowledge keepers."
    case .altarStones:
        return "Stones placed in sacred patterns on the ground to mark spirit presence, honor ancestors, or hold offerings during ceremony."
    }
}

//MARK: - Dodem roles and descriptions
struct RoleProfile {
    let peacetime: String
    let wartime: String
    let peacetimeEmoji: String
    let wartimeEmoji: String
    let description: String
}

let dodemRoles: [Dodem: RoleProfile] = [
    .makwa: RoleProfile(
        peacetime: "Healer & Mediator",
        wartime: "Warrior & Guardian",
        peacetimeEmoji: "🌿",
        wartimeEmoji: "🛡",
        description: "Bear Clan tends to the sick, mediates disputes, and protects the people when danger arises. Their wisdom comes from medicine and lived experience."
    ),
    .waabizheshi: RoleProfile(
        peacetime: "Messenger & Planner",
        wartime: "Scout & Tactician",
        peacetimeEmoji: "🪶",
        wartimeEmoji: "🕵️‍♂️",
        description: "Marten Clan is agile, clever, and fast. They plan community action in peacetime and scout ahead during conflict, always staying one step ahead."
    ),
    .mko: RoleProfile(
        peacetime: "Pathfinder & Guardian of the Sacred",
        wartime: "Hunter & Defender",
        peacetimeEmoji: "🌀",
        wartimeEmoji: "🏹",
        description: "Wolf Clan walks the spiritual and physical path. They preserve sacred knowledge and loyally defend their kin during times of struggle."
    ),
    .ajijaak: RoleProfile(
        peacetime: "Diplomat & Orator",
        wartime: "Council Leader",
        peacetimeEmoji: "🎙",
        wartimeEmoji: "⚖️",
        description: "Crane Clan speaks with balance and clarity. They guide political decisions and offer stabilizing leadership in times of war."
    ),
    .maang: RoleProfile(
        peacetime: "Historian & Storykeeper",
        wartime: "Signal Watcher",
        peacetimeEmoji: "📖",
        wartimeEmoji: "🔭",
        description: "Loon Clan remembers the law, stories, and origins. Their sharp eyes alert the people in times of danger and ceremony alike."
    ),
    .name: RoleProfile(
        peacetime: "Lawkeeper & Ancestor Voice",
        wartime: "Elder Strategist",
        peacetimeEmoji: "📜",
        wartimeEmoji: "♟️",
        description: "Sturgeon Clan holds long memory. They are slow to anger but guide both peacetime law and wartime strategy with ancestral perspective."
    ),
    .bneshi: RoleProfile(
        peacetime: "Artist & Musician",
        wartime: "Ceremonial Warrior",
        peacetimeEmoji: "🎶",
        wartimeEmoji: "🪘",
        description: "Bird Clan is the voice of joy, ceremony, and beauty. Their songs empower warriors and their presence uplifts the people."
    ),
    .wawashkesh: RoleProfile(
        peacetime: "Ceremonial Dancer & Peace Nurturer",
        wartime: "Ceremonial Protector",
        peacetimeEmoji: "🕊",
        wartimeEmoji: "🦌",
        description: "Deer Clan embodies grace, gentleness, and devotion to balance. Their strength in war is spiritual and symbolic."
    ),
    .mshike: RoleProfile(
        peacetime: "Knowledge Keeper & Earth Teacher",
        wartime: "Boundary Defender",
        peacetimeEmoji: "📚",
        wartimeEmoji: "🛑",
        description: "Turtle Clan teaches stability, law, and earth knowledge. In war, they endure and defend, forming the foundation of resistance."
    ),
    .animki: RoleProfile(
        peacetime: "Spiritual Leader & Dream Interpreter",
        wartime: "Spirit Warrior",
        peacetimeEmoji: "🔮",
        wartimeEmoji: "⚡️",
        description: "Thunderbird Clan works with vision and ceremony. Their energy calls the spirits into motion when it’s time to protect the people."
    ),
    .awaazisii: RoleProfile(
        peacetime: "Dream Keeper & Emotional Guide",
        wartime: "Silent Watcher",
        peacetimeEmoji: "💭",
        wartimeEmoji: "👁️‍🗨️",
        description: "Catfish Clan is deeply intuitive and spiritually sensitive. They move in quiet spaces, supporting emotional resilience and hidden defenses."
    )
]
