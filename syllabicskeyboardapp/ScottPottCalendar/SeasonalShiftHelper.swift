//
//  SeasonalShiftHelper.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 5/28/25.
//
import Foundation

struct SeasonalShift {
    let name: String
    let date: Date
}

func nextSeasonalLunasolarDate(from today: Date = Date()) -> LunasolarDate? {
    let calendar = Calendar(identifier: .gregorian)
    let year = calendar.component(.year, from: today)

    let gregorianShifts: [(String, DateComponents)] = [
        ("🌱 Spring Equinox", DateComponents(year: year, month: 3, day: 20)),
        ("🌞 Summer Solstice", DateComponents(year: year, month: 6, day: 21)),
        ("🍂 Autumn Equinox", DateComponents(year: year, month: 9, day: 22)),
        ("❄️ Winter Solstice", DateComponents(year: year, month: 12, day: 21))
    ]

    let futureShifts: [(date: Date, luna: LunasolarDate)] = gregorianShifts.compactMap { name, components in
        guard let shiftDate = calendar.date(from: components), shiftDate >= today else { return nil }

        let luna = LunasolarDate.from(today: shiftDate)
        
        return (
            shiftDate,
            LunasolarDate(
                day: luna.day,
                month: luna.month,
                year: luna.year,
                moonPhase: luna.moonPhase,
                moonName: luna.moonName,
                moonNameEnglish: luna.moonNameEnglish,
                culturalContext: luna.culturalContext,
                holidays: luna.holidays + [name]
            )
        )
    }

    return futureShifts.sorted(by: { $0.date < $1.date }).first?.luna
}
