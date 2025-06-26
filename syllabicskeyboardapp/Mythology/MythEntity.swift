//
//  MythEntity.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 5/28/25.
//
// TYPES: person, place, society, thing
// CATEGORIES: ancestor, creator_spirit, cursed_entity, cursed_object, earth_spirit, evil_entity, giant_helper, leader_spirit, legendary_helper, medicine_society, sacred_object, sky_spirit, spirit, spirit_group, spiritual_practice, village, vision_society, water_being, water_spirit
// TAGS: afterlife, ancestral, bear, bird, canoes, chant, creation, curse, dance, earth, evil, feast, feminine, furry, giant, god, goose, great_spirit, healing, heaven, history, humor, hunt, initiation, lake, leadership, life, mother, murder, music, performance, permission, punishment, rebirth, secrecy, shadow_people, sickness, skeleton, sky, spirit, starvation, stone, teaching, tradition, transformation, trickster, vision, wampum, warrior, water, weapon, western, winter, wisdom, women


import Foundation

struct MythEntity: Codable, Identifiable {
    let id: String
    let name: String
    let type: MythEntityType
    let category: String
    let tags: [String]
    let description: String
    let loreImportance: Int?
    let gameUses: GameUses?

    enum CodingKeys: String, CodingKey {
        case id, name, type, category, tags, description
        case loreImportance = "lore_importance"
        case gameUses = "game_uses"
    }

    enum MythEntityType: String, Codable, CaseIterable {
        case person
        case place
        case thing
        case society
    }


    struct GameUses: Codable {
        let encounterType: EncounterType
        let possibleTraits: [String]
        let abilitiesGranted: [String]?

        enum EncounterType: String, Codable {
            case mentor
            case enemy
            case ritual
            case story
            case challenge
            case ghost
            case item
            case location
        }
    }
}

final class MythologyData: ObservableObject {
    @Published var entities: [MythEntity] = []

    init() {
        load()
    }

    func load() {
        guard let url = Bundle.main.url(forResource: "updated_potawatomi_mythology", withExtension: "json") else {
            print("Mythology JSON file not found")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([MythEntity].self, from: data)
            self.entities = decoded
        } catch {
            print("Error loading mythology data: \(error)")
        }
    }
} 

// Example SwiftUI usage in a view
// List(mythologyData.entities) { entity in
//     Text(entity.name)
// }
