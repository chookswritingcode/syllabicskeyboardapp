// TiledMapLoader.swift

import Foundation

class TiledMapLoader {
    static func loadMap(named mapName: String) -> TiledMap? {
        guard let url = Bundle.main.url(forResource: mapName, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("❌ Failed to load map file: \(mapName).json")
            return nil
        }

        let decoder = JSONDecoder()
        do {
            let map = try decoder.decode(TiledMap.self, from: data)
            return map
        } catch {
            print("❌ Error decoding map: \(error)")
            return nil
        }
    }
}
