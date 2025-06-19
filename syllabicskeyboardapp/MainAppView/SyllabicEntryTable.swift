//
//  SyllabicEntryTable.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 5/30/25.
//
import SwiftUI

struct SyllabicEntryTable: Identifiable {
    let id = UUID()
    let symbol: String
    let sound: String
    let group: String
}

struct SyllabicsGridView: View {
    let entries: [SyllabicEntryTable] = [
        // Vowels
        .init(symbol: "ᐊ", sound: "a- but", group: "Vowels"),
        .init(symbol: "ᐃ", sound: "i- hit", group: "Vowels"),
        .init(symbol: "ᐅ", sound: "o- boat", group: "Vowels"),
        .init(symbol: "ᐁ", sound: "e- meh", group: "Vowels"),
        
        // Long Vowels (with combining dot above)
        .init(symbol: "ᐊ̇", sound: "aa- bat", group: "Long Vowels"),
        .init(symbol: "ᐃ̇", sound: "ii- see", group: "Long Vowels"),
        .init(symbol: "ᐅ̇", sound: "oo- rude", group: "Long Vowels"),
        .init(symbol: "ᐁ̇", sound: "ee- may", group: "Long Vowels"),
        .init(symbol: "ᐊᔭ", sound: "ay- eye", group: "Long Vowels"),
        
        // Stops
        .init(symbol: "ᐸ", sound: "pa/ba", group: "Stops"),
        .init(symbol: "ᑕ", sound: "ta/da", group: "Stops"),
        .init(symbol: "ᑲ", sound: "ka/ga", group: "Stops"),
        
        // Fricatives
        .init(symbol: "ᓴ", sound: "sa/za", group: "Fricatives"),
        .init(symbol: "ᔕ", sound: "sha/zha", group: "Fricatives"),
        .init(symbol: "ᕙ", sound: "fa/va", group: "Fricatives"),
        .init(symbol: "ᕦ", sound: "tha/Tha", group: "Fricatives"),
        
        // Nasals
        .init(symbol: "ᒪ", sound: "ma", group: "Nasals"),
        .init(symbol: "ᓇ", sound: "na", group: "Nasals"),
        
        // Approximants
        .init(symbol: "ᔭ", sound: "ya", group: "Approximants"),
        .init(symbol: "ᓚ", sound: "la", group: "Approximants"),
        .init(symbol: "ᕋ", sound: "ra", group: "Approximants"),
        
        // Affricates
        .init(symbol: "ᒐ", sound: "cha/ja", group: "Affricates"),
        
        // Finals
        .init(symbol: "ᐤ", sound: "w", group: "Finals"),
        .init(symbol: "ᖅ", sound: "q", group: "Finals"),
        .init(symbol: "ᖕ", sound: "ng", group: "Finals"),
        .init(symbol: "ᐦ", sound: "h", group: "Finals"),
    ]

    let displayOrder = [
        "Vowels", "Long Vowels",
        "Stops", "Nasals", "Fricatives", "Affricates", "Approximants",
        "Finals"
    ]

    var grouped: [String: [SyllabicEntryTable]] {
        Dictionary(grouping: entries, by: \.group)
    }

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                ForEach(displayOrder, id: \.self) { group in
                    if let section = grouped[group] {
                        Text(group)
                            .font(.title3)
                            .bold()
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, alignment: .leading, spacing: 12) {
                            ForEach(section) { entry in
                                HStack {
                                    Text(entry.symbol)
                                        .font(.system(size: 28))
                                        .frame(width: 40, alignment: .leading)
                                    Text(entry.sound)
                                        .font(.system(size: 18))
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.top)
        }
        .navigationTitle("Syllabic Sounds")
    }
}
