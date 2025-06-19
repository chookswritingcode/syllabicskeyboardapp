//
//  MythologyView.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 5/28/25.
//
import SwiftUI

private func entityRowView(for entity: MythEntity) -> some View {
    VStack(alignment: .leading, spacing: 4) {
        Text(entity.name)
            .font(.headline)
        Text(entity.category.capitalized)
            .font(.subheadline)
            .foregroundColor(.secondary)
    }
}


struct MythologyView: View {
    @ObservedObject var data = MythologyData()
    @State private var searchText: String = ""

    var filteredEntities: [MythEntity] {
        if searchText.isEmpty {
            return data.entities
        } else {
            return data.entities.filter { entity in
                entity.name.localizedCaseInsensitiveContains(searchText) ||
                entity.category.localizedCaseInsensitiveContains(searchText) ||
                entity.type.rawValue.localizedCaseInsensitiveContains(searchText) ||
                entity.tags.contains(where: { $0.localizedCaseInsensitiveContains(searchText) })
            }
        }
    }

    var body: some View {
        NavigationView {
            content
                .searchable(text: $searchText, prompt: "Search by name, tag, type, or category")
                .navigationTitle("Potawatomi Mythology")
        }
    }

    private var content: some View {
        List {
            ForEach(MythEntity.MythEntityType.allCases, id: \.self) { type in
                section(for: type)
            }
        }
    }

    private func section(for type: MythEntity.MythEntityType) -> some View {
        let entitiesOfType = filteredEntities.filter { $0.type == type }

        return Section(header: Text(type.displayName).font(.headline)) {
            ForEach(entitiesOfType) { entity in
                NavigationLink(destination: MythDetailView(entity: entity)) {
                    entityRowView(for: entity)
                }
            }
        }
    }

}

extension MythEntity.MythEntityType {
    var displayName: String {
        switch self {
        case .person: return "People"
        case .place: return "Places"
        case .thing: return "Sacred Objects"
        case .society: return "Societies"
        }
    }
}

struct MythDetailView: View {
    let entity: MythEntity

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text(entity.name)
                    .font(.largeTitle)
                    .bold()

                Text(entity.description)
                    .font(.body)

                if !entity.tags.isEmpty {
                    Text("Tags: " + entity.tags.joined(separator: ", "))
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }

                Divider()

                VStack(alignment: .leading, spacing: 8) {
                    Text("Game Usage")
                        .font(.headline)

                    if let gameUses = entity.gameUses {
                        Text("Encounter Type: \(gameUses.encounterType.rawValue.capitalized)")
                        if let abilities = gameUses.abilitiesGranted, !abilities.isEmpty {
                            Text("Abilities Granted: \(abilities.joined(separator: ", "))")
                        }
                        Text("Possible Traits: \(gameUses.possibleTraits.joined(separator: ", "))")
                    }
                }
            }
            .padding()
        }
        .navigationTitle(entity.name)
    }
}
