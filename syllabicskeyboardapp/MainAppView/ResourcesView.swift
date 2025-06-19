//
//  ResourcesView.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 5/30/25.
//
import  SwiftUI

struct ResourcesView: View {
    var body: some View {
        List {
            Section(header: Text("Potawatomi Language Resources")) {
                Link("Citizen Potawatomi Dictionary", destination: URL(string: "https://www.potawatomidictionary.com")!)
                Link("Pokagon Potawatomi Dictionary", destination: URL(string: "https://wiwkwebthegen.com/dictionary")!)
                Link("Kansas Potawatomi Dictionary", destination: URL(string: "https://www.kansasheritage.org/PBP/books/dicto/d_frame.html")!)
                Link("Citizen Potawatomi Nation Language Department", destination: URL(string: "https://www.potawatomi.org/language/")!)
                Link("Bodewadmimwen App (iOS)", destination: URL(string: "https://apps.apple.com/tr/app/bodwéwadmimwen/id1068491469")!)
                Link("Mango Languages App (iOS)", destination: URL(string: "https://apps.apple.com/us/app/mango-languages-learning/id443516516")!)
                Link("Gkendaso School", destination: URL(string: "https://learning.potawatomi.org")!)
                
            }

            Section(header: Text("Ojibwe Resources")) {
                Link("Ojibwe People's Dictionary", destination: URL(string: "https://ojibwe.lib.umn.edu/")!)
            }

            Section(header: Text("Syllabics Learning")) {
                Link("Canadian Syllabics Basic Principles", destination: URL(string: "https://en.wikipedia.org/wiki/Canadian_Aboriginal_syllabics#Basic_principles")!)
                Link("Learning Cree Syllabics", destination: URL(string: "https://www.tribaltrails.org/resources/cree-syllabics/")!)
                Link("Ojibwe Syllabics Wiki", destination: URL(string: "https://en.wikipedia.org/wiki/Ojibwe_writing_systems#Ojibwe_syllabics")!)
                Link("Inuktut Tusaalanga", destination: URL(string: "https://tusaalanga.ca/node/2516")!)
    
            }
            Section(header: Text("Cultural Resources")) {
                Link("Powwows Near Me", destination: URL(string: "https://www.powwows.com")!)
                Link("Great Lakes Algonquian syllabics", destination: URL(string: "https://en.wikipedia.org/wiki/Great_Lakes_Algonquian_syllabics")!)
                Link("Unicode Syllabic Chart", destination: URL(string: "https://www.unicode.org/charts/PDF/Unicode-9.0/U90-1400.pdf")!)
                Link("Other Syllabics Converters", destination: URL(string: "https://www.syllabics.net/convert/ojibwe")!)
            }
        }
        .navigationTitle("Language Resources")
    }
}
