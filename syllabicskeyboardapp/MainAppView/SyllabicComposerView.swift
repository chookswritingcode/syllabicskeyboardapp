//
//  SyllabicComposerView.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 5/30/25.
//
import SwiftUI

struct SyllabicComposerView: View {
    @State private var input = ""
    @State private var output = ""

    var body: some View {
        VStack(spacing: 20) {
           //Text("Syllabic Composer")
             //   .font(.title)
              //  .bold()

            TextField("Type Potawatomi here (e.g. ndishnikaaz)", text: $input)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .onChange(of: input) {
                    output = transliterateToSyllabics(input)
                }

            Text(output)
                .font(.system(size: 28))
                .frame(maxWidth: .infinity, minHeight: 80)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)

            Button(action: {
                UIPasteboard.general.string = output
            }) {
                Label("Copy Output", systemImage: "doc.on.doc")
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Syllabic Composer")
    }
}
