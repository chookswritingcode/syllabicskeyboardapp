import Foundation
import MoonKit

let scottPottBirthYear = 1998

struct LunasolarDate: Identifiable {
    let id = UUID()
    let day: Int
    let month: Int
    let year: Int
    let moonPhase: MoonPhase
    let moonName: String
    let moonNameEnglish: String
    let culturalContext: String
    let holidays: [String]
    
    var formatted: String {
        String(format: "%02d/%02d/%02d", day, month, year)
    }
}
    extension LunasolarDate {
        static func from(today date: Date = Date()) -> LunasolarDate {
            let calendar = Calendar(identifier: .gregorian)
            let yearComponent = calendar.component(.year, from: date)
           // let dayOfYear = calendar.ordinality(of: .day, in: .year, for: date) ?? 1

            let age = yearComponent - scottPottBirthYear
            let isLeapMoonYear = (age % 3 == 0)
            let moonsThisYear = isLeapMoonYear ? 13 : 12
           // let daysPerMoon = 30

            let clampedMoon = min(scottPottMoonIndex(for: date), moonsThisYear)
         //   let moonIndex = ((dayOfYear - 1) / daysPerMoon) + 1
         //   let clampedMoon = min(moonIndex, moonsThisYear)

            // 🌙 Use MoonKit
            let moon = Moon(date)
            let moonPhase = MoonPhase.from(moonKitPhase: moon.info.phase?.rawValue ?? "Unknown")
            let dayOfMoon = min(Int(moon.info.age ?? 0), 30)

        //  let moonAge = moon.info.age // optional, but available

            // 🌓 Assign moon name logic
            let moonEntry = (dayOfMoon == 15)
                ? MoonName.fullMoonName(forMonth: clampedMoon)
                : MoonName.newMoonName(forMonth: clampedMoon)

            let moonName = moonEntry.syllabic
            let moonNameEnglish = moonEntry.english

            let context = MoonName.culturalContext(forMonth: clampedMoon, day: dayOfMoon)

            // 🔆 Equinox/Solstice
            let dateComponents = calendar.dateComponents([.month, .day], from: date)
            let equinoxAndSolsticeRanges: [String: ClosedRange<Int>] = [
                "Spring Equinox": 319...321,
                "Summer Solstice": 620...622,
                "Autumn Equinox": 921...923,
                "Winter Solstice": 1220...1222
            ]

            let compactDate = (dateComponents.month ?? 0) * 100 + (dateComponents.day ?? 0)
            let holidays = equinoxAndSolsticeRanges.compactMap { name, range in
                range.contains(compactDate) ? name : nil
            }
        //    let calendar = Calendar.current
          //  let dateComponents = calendar.dateComponents([.month, .day], from: date)


         /*   let foundHolidays = equinoxAndSolsticeRanges.compactMap { (name, range) in
                if let m = dateComponents.month, let d = dateComponents.day, range.contains((m, d)) {
                    return name
                }
                return nil
            }
            */

            
            return LunasolarDate(
                day: dayOfMoon,  // or clamp it to 30 if needed
                month: clampedMoon,  // already calculated earlier
                year: age,
                moonPhase: moonPhase,
                moonName: moonName,
                moonNameEnglish: moonNameEnglish,
                culturalContext: context,
                holidays: holidays
            )
        }
        static func scottPottMoonIndex(for date: Date) -> Int {
            let calendar = Calendar(identifier: .gregorian)
            let year = calendar.component(.year, from: date)

            // Approx Spring Equinox
            guard let springEquinox = calendar.date(from: DateComponents(year: year, month: 3, day: 20)) else {
                return 1
            }

            // Find first New Moon *after* spring equinox
            var currentDate = springEquinox
            while true {
                let moon = Moon(currentDate)
                if moon.info.phase?.rawValue == "New Moon" {
                    break
                }
                guard let nextDay = calendar.date(byAdding: .day, value: 1, to: currentDate) else { break }
                currentDate = nextDay
            }

            let startOfScottPottYear = currentDate
            let daysSinceStart = calendar.dateComponents([.day], from: startOfScottPottYear, to: date).day ?? 0
            return max(1, (daysSinceStart / 30) + 1)
        }
    }
//MARK: - Function for converting to other calendar systems
func formatDate(for calendarIdentifier: Calendar.Identifier, date: Date = Date()) -> String {
    let calendar = Calendar(identifier: calendarIdentifier)
    let components = calendar.dateComponents([.year, .month, .day], from: date)

    let year = components.year ?? 0
    let month = components.month ?? 0
    let day = components.day ?? 0

    return String(format: "%02d/%02d/%04d", day, month, year)
}
