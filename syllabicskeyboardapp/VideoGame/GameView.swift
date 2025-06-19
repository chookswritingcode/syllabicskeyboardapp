import SwiftUI
import SpriteKit

struct GameView: View {
    @StateObject private var coordinator = GameSceneCoordinator()

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ZStack(alignment: .topTrailing) {
                    // Top half: SpriteKit view
                    SpriteView(scene: coordinator.scene)
                        .frame(height: geometry.size.height * 0.5)

                    // Menu button in corner
                    Button(action: {
                        // Implement menu logic
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .padding()
                            .background(Color.white.opacity(0.7))
                            .clipShape(Circle())
                    }
                    .padding()
                }

                // Bottom half: controls
                HStack {
                    // D-Pad
                    VStack(spacing: 10) {
                        Button { coordinator.move(.up) }    label: { arrow("up") }
                        HStack(spacing: 10) {
                            Button { coordinator.move(.left) }  label: { arrow("left") }
                            Spacer().frame(width: 20)
                            Button { coordinator.move(.right) } label: { arrow("right") }
                        }
                        Button { coordinator.move(.down) }  label: { arrow("down") }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)

                    // Action buttons
                    VStack(spacing: 30) {
                        Button(action: {
                            // Action 1 logic
                        }) {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 90, height: 90)
                                .overlay(Text("ᐃ").bold().foregroundColor(.white))
                        }

                        Button(action: {
                            // Action 2 logic
                        }) {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 90, height: 90)
                                .overlay(Text("ᑎ").bold().foregroundColor(.white))
                                
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                }
                .frame(height: geometry.size.height * 0.5)
            }
        }
    }

    func arrow(_ direction: String) -> some View {
        Image(systemName: "arrowtriangle.\(direction).fill")
            .font(.title)
            .padding(12)
            .background(Color.gray.opacity(0.2))
            .clipShape(Circle())
    }
}
