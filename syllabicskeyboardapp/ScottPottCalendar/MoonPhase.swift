//
//  MoonPhase.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 5/27/25.
//
import Foundation
import MoonKit

enum MoonPhase: String, CaseIterable {
    case newMoon = "New Moon"
    case waxingCrescent = "Waxing Crescent"
    case firstQuarter = "First Quarter"
    case waxingGibbous = "Waxing Gibbous"
    case fullMoon = "Full Moon"
    case waningGibbous = "Waning Gibbous"
    case lastQuarter = "Last Quarter"
    case waningCrescent = "Waning Crescent"
    case unknown = "Unknown"

    // Convert from MoonKit string
    static func from(moonKitPhase: String) -> MoonPhase {
        switch moonKitPhase {
        case "New Moon": return .newMoon
        case "Waxing Crescent": return .waxingCrescent
        case "First Quarter": return .firstQuarter
        case "Waxing Gibbous": return .waxingGibbous
        case "Full Moon": return .fullMoon
        case "Waning Gibbous": return .waningGibbous
        case "Last Quarter": return .lastQuarter
        case "Waning Crescent": return .waningCrescent
        default: return .unknown
        }
    }

    // Emoji for each phase
    var emoji: String {
        switch self {
        case .newMoon: return "🌑"
        case .waxingCrescent: return "🌒"
        case .firstQuarter: return "🌓"
        case .waxingGibbous: return "🌔"
        case .fullMoon: return "🌕"
        case .waningGibbous: return "🌖"
        case .lastQuarter: return "🌗"
        case .waningCrescent: return "🌘"
        case .unknown: return "🌚"
        }
    }

    // Optional: Approximate fallback if only day is known (used earlier)
    static func phase(forDay day: Int) -> MoonPhase {
        switch day {
        case 1: return .newMoon
        case 2...5: return .waxingCrescent
        case 6...10: return .firstQuarter
        case 11...14: return .waxingGibbous
        case 15: return .fullMoon
        case 16...20: return .waningGibbous
        case 21...24: return .lastQuarter
        case 25...29: return .waningCrescent
        default: return .newMoon
        }
    }
}
