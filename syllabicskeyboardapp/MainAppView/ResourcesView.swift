//
//  ResourcesView.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 5/30/25.
//
import SwiftUI

struct ResourcesView: View {
    @State private var selectedURL: URL?
    @State private var showWebView = false

    var body: some View {
        List {
            Section(header: Text("Potawatomi Language Resources")) {
                Button("Citizen Potawatomi Dictionary") {
                    selectedURL = URL(string: "https://www.potawatomidictionary.com")!
                    showWebView = true
                }
                Button("Pokagon Potawatomi Dictionary") {
                    selectedURL = URL(string: "https://wiwkwebthegen.com/dictionary")!
                    showWebView = true
                }
                Button("Kansas Potawatomi Dictionary") {
                    selectedURL = URL(string: "https://www.kansasheritage.org/PBP/books/dicto/d_frame.html")!
                    showWebView = true
                }
                Button("Citizen Potawatomi Nation Language Department") {
                    selectedURL = URL(string: "https://www.potawatomi.org/language/")!
                    showWebView = true
                }
                Button("Bodewadmimwen App (iOS)") {
                    selectedURL = URL(string: "https://apps.apple.com/tr/app/bodwéwadmimwen/id1068491469")!
                    showWebView = true
                }
                Button("Mango Languages App (iOS)") {
                    selectedURL = URL(string: "https://apps.apple.com/us/app/mango-languages-learning/id443516516")!
                    showWebView = true
                }
                Button("Gkendaso School") {
                    selectedURL = URL(string: "https://learning.potawatomi.org")!
                    showWebView = true
                }

            }

            Section(header: Text("Ojibwe Resources")) {
                Button("Ojibwe People's Dictionary") {
                    selectedURL = URL(string: "https://ojibwe.lib.umn.edu/")!
                    showWebView = true
                }
            }

            Section(header: Text("Syllabics Learning")) {
                Button("Canadian Syllabics Basic Principles") {
                    selectedURL = URL(string: "https://en.wikipedia.org/wiki/Canadian_Aboriginal_syllabics#Basic_principles")!
                    showWebView = true
                }
                Button("Learning Cree Syllabics") {
                    selectedURL = URL(string: "https://www.tribaltrails.org/resources/cree-syllabics/")!
                    showWebView = true
                }
                Button("Ojibwe Syllabics Wiki") {
                    selectedURL = URL(string: "https://en.wikipedia.org/wiki/Ojibwe_writing_systems#Ojibwe_syllabics")!
                    showWebView = true
                }
                Button("Inuktut Tusaalanga") {
                    selectedURL = URL(string: "https://tusaalanga.ca/node/2516")!
                    showWebView = true
                }

            }
            Section(header: Text("Cultural Resources")) {
                Button("Powwows Near Me") {
                    selectedURL = URL(string: "https://www.powwows.com")!
                    showWebView = true
                }
                Button("Great Lakes Algonquian syllabics") {
                    selectedURL = URL(string: "https://en.wikipedia.org/wiki/Great_Lakes_Algonquian_syllabics")!
                    showWebView = true
                }
                Button("Unicode Syllabic Chart") {
                    selectedURL = URL(string: "https://www.unicode.org/charts/PDF/Unicode-9.0/U90-1400.pdf")!
                    showWebView = true
                }
                Button("Other Syllabics Converters") {
                    selectedURL = URL(string: "https://www.syllabics.net/convert/ojibwe")!
                    showWebView = true
                }
            }
        }
        .navigationTitle("Language Resources")
        .sheet(isPresented: $showWebView) {
            if let url = selectedURL {
                NavigationView {
                    WebView(url: url)
                        .navigationTitle(Text(url.host ?? "Web"))
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
}
