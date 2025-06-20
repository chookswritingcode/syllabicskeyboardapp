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
        let set = Set(data.entities.map { $0.category })
        return Array(set).sorted()
    }

    private var allTags: [String] {
        let set = Set(data.entities.flatMap { $0.tags })
        return Array(set).sorted()
    }

    var filteredEntities: [MythEntity] {
        data.entities.filter { entity in
            let matchesSearch: Bool = {
                if searchText.isEmpty { return true }
                return entity.name.localizedCaseInsensitiveContains(searchText) ||
                    entity.category.localizedCaseInsensitiveContains(searchText) ||
                    entity.type.rawValue.localizedCaseInsensitiveContains(searchText) ||
                    entity.tags.contains(where: { $0.localizedCaseInsensitiveContains(searchText) })
            }()

            let matchesType = selectedType == nil || entity.type == selectedType
            let matchesCategory = selectedCategory == nil || entity.category == selectedCategory
            let matchesTag = selectedTag == nil || entity.tags.contains(selectedTag!)

            return matchesSearch && matchesType && matchesCategory && matchesTag
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
        VStack {
            filterView
            List {
                ForEach(MythEntity.MythEntityType.allCases, id: \.self) { type in
                    section(for: type)
                }
            }
        }
    }

    private var filterView: some View {
        VStack(alignment: .leading) {
            Picker("Type", selection: $selectedType) {
                Text("All Types").tag(MythEntity.MythEntityType?.none)
                ForEach(MythEntity.MythEntityType.allCases, id: \.self) { type in
                    Text(type.displayName).tag(type as MythEntity.MythEntityType?)
                }
            }
            .pickerStyle(.menu)

            Picker("Category", selection: $selectedCategory) {
                Text("All Categories").tag(String?.none)
                ForEach(allCategories, id: \.self) { category in
                    Text(category.capitalized).tag(category as String?)
                }
            }
            .pickerStyle(.menu)

            Picker("Tag", selection: $selectedTag) {
                Text("All Tags").tag(String?.none)
                ForEach(allTags, id: \.self) { tag in
                    Text(tag.capitalized).tag(tag as String?)
                }
            }
            .pickerStyle(.menu)
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    private func section(for type: MythEntity.MythEntityType) -> some View {
        let entitiesOfType = filteredEntities.filter { $0.type == type }

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
