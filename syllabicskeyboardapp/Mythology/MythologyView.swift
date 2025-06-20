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
    @State private var selectedType: MythEntity.MythEntityType?
    @State private var selectedCategory: String?
    @State private var selectedTag: String?

    private var allCategories: [String] {
        Array(Set(data.entities.map { $0.category })).sorted()
    }

    private var allTags: [String] {
        Array(Set(data.entities.flatMap { $0.tags })).sorted()
    }

    var filteredEntities: [MythEntity] {
        data.entities.filter { entity in
            (searchText.isEmpty ||
                entity.name.localizedCaseInsensitiveContains(searchText) ||
                entity.category.localizedCaseInsensitiveContains(searchText) ||
                entity.type.rawValue.localizedCaseInsensitiveContains(searchText) ||
                entity.tags.contains(where: { $0.localizedCaseInsensitiveContains(searchText) })) &&
            (selectedType == nil || entity.type == selectedType) &&
            (selectedCategory == nil || entity.category == selectedCategory) &&
            (selectedTag == nil || entity.tags.contains(selectedTag!))
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
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Picker("Type", selection: $selectedType) {
                        Text("All").tag(MythEntity.MythEntityType?.none)
                        ForEach(MythEntity.MythEntityType.allCases, id: \.self) { type in
                            Text(type.displayName).tag(Optional(type))
                        }
                    }
                    .pickerStyle(.menu)

                    Picker("Category", selection: $selectedCategory) {
                        Text("All").tag(String?.none)
                        ForEach(allCategories, id: \.self) { category in
                            Text(category.capitalized).tag(Optional(category))
                        }
                    }
                    .pickerStyle(.menu)

                    Picker("Tag", selection: $selectedTag) {
                        Text("All").tag(String?.none)
                        ForEach(allTags, id: \.self) { tag in
                            Text(tag.capitalized).tag(Optional(tag))
                        }
                    }
                    .pickerStyle(.menu)
                }
            }

            ForEach(MythEntity.MythEntityType.allCases, id: \.self) { type in
                section(for: type)
            }
        }
    }

    private func section(for type: MythEntity.MythEntityType) -> some View {
        let entitiesOfType = filteredEntities.filter { $0.type == type }

        return Group {
            if !entitiesOfType.isEmpty {
                Section(header: Text(type.displayName).font(.headline)) {
                    ForEach(entitiesOfType) { entity in
                        NavigationLink(destination: MythDetailView(entity: entity)) {
                            entityRowView(for: entity)
                        }
                    }
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
