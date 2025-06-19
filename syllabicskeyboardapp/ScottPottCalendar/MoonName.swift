//
//  MoonName.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 5/27/25.
//
import Foundation
import MoonKit
import Foundation
//MARK: - Storing and accessing Moon Names
struct MoonNameEntry {
    let syllabic: String
    let english: String
}
/*
struct MoonName {
    static func newMoonName(forMonth index: Int) -> MoonNameEntry {
        let safeIndex = max(1, min(index, newMoonNames.count))
        return newMoonNames[safeIndex - 1]
    }

    static func fullMoonName(forMonth month: Int) -> String {
        return "Full Moon \(month)"
    }

    static func culturalContext(forMonth month: Int, day: Int) -> String {
        if day == 1 {
            return "This is the beginning of a new lunar cycle. Time to set intentions."
        } else if day == 15 {
            return "This is the full moon—traditionally a time for ceremonies and celebration."
        } else {
            return "This moon marks the rhythms of your path in the lunar cycle."
        }
    }
}
*/
//MARK: - Moon Name Library
struct MoonName {
    static func newMoonName(forMonth month: Int) -> MoonNameEntry {
        switch month {
        case 1: return MoonNameEntry(syllabic: "ᓯᔅᐸᑲᑐ", english: "Sugar Moon")
        case 2: return MoonNameEntry(syllabic: "ᐗᔅᑯᓀᓐ", english: "Flower Moon")
        case 3: return MoonNameEntry(syllabic: "ᐅᑌᒣᓐ", english: "Strawberry Moon")
        case 4: return MoonNameEntry(syllabic: "ᒥᓐᒣᓐ", english: "Blueberry Moon")
        case 5: return MoonNameEntry(syllabic: "ᒪᓄᒻᓀᑫᓐ", english: "Rice Moon")
        case 6: return MoonNameEntry(syllabic: "ᒪᓐᑌᓐ", english: "Corn Moon")
        case 7: return MoonNameEntry(syllabic: "ᓭᑫᒃ", english: "Harvest Moon")
        case 8: return MoonNameEntry(syllabic: "ᐸᓇᑴᓐ", english: "Falling Moon")
        case 9: return MoonNameEntry(syllabic: "ᑌᑾᑭᑭ", english: "Forest Moon")
        case 10: return MoonNameEntry(syllabic: "ᑲᔅᑌᑲᑎᓄ", english: "Cold Moon")
        case 11: return MoonNameEntry(syllabic: "ᒪᓂᑐᑭ", english: "Spirit Moon")
        case 12: return MoonNameEntry(syllabic: "ᒪᑾᑭ", english: "Bear Moon")
        case 13: return MoonNameEntry(syllabic: "ᑮᒌᒪᓂᑐᑭ", english: "Great Spirit Moon")
        default: return MoonNameEntry(syllabic: "?", english: "Unknown Moon")
        }
    }

    // Placeholder — you can expand this later
    static func fullMoonName(forMonth month: Int) -> MoonNameEntry {
        return MoonNameEntry(syllabic: "🌕", english: "Full Moon")
    }

    static func culturalContext(forMonth month: Int, day: Int) -> String {
        // Add real logic here if needed
        return "This moon marks an important seasonal moment."
    }
}
