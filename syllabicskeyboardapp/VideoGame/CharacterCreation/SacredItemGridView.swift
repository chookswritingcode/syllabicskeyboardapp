//
//  SacredItemGridView.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 5/27/25.
//
import SwiftUI

struct SacredItemGridView: View {
    @Binding var selectedGears: Set<Gear>
    @Binding var gearSelectionWarning: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Choose Up to 2 Sacred Items")
                .font(.headline)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(Gear.allCases, id: \.self) { gear in
                    SelectableCard(title: gear.rawValue, emoji: gear.emoji, isSelected: selectedGears.contains(gear)) {
                        if selectedGears.contains(gear) {
                            selectedGears.remove(gear)
                            gearSelectionWarning = false
                        } else if selectedGears.count < 2 {
                            selectedGears.insert(gear)
                            gearSelectionWarning = false
                        } else {
                            withAnimation {
                                gearSelectionWarning = true
                            }
                        }
                    }
                }
            }

            if gearSelectionWarning {
                Text("You can only select 2 sacred items.")
                    .font(.footnote)
                    .foregroundColor(.red)
            }
        }
        .padding(.horizontal)
    }
}
