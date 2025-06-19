//
//  KeyboardInstructionsView.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 5/30/25.
//
import  SwiftUI

struct KeyboardInstructionsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("How to Enable the Keyboard")
                    .font(.title2)
                    .bold()

                Text("""
                1. Open the **Settings** app  
                2. Tap **General > Keyboard > Keyboards**  
                3. Tap **Add New Keyboard…**  
                4. Select **Bodewadmiiwiibiian**  
                5. Tap it again and enable **Allow Full Access**
                """)
                .font(.body)

                Button("Open Settings") {
                    if let url = URL(string: UIApplication.openSettingsURLString),
                       UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                }
                .buttonStyle(.bordered)
            }
            .padding()
        }
        .navigationTitle("Setup Instructions")
    }
}
