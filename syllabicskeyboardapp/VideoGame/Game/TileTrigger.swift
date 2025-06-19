//
//  TileTrigger.swift
//  syllabicskeyboardapp
//
//  Created by Carter Davidson on 6/3/25.
//


// TriggerHandler.swift - Handles triggers like transitions or zones

import SpriteKit

struct TileTrigger {
    let name: String
    let destination: String
    let frame: CGRect
}

class TriggerHandler {

    static func extractTriggers(from map: TiledMap) -> [TileTrigger] {
        var triggers: [TileTrigger] = []

        for layer in map.layers {
            if case .objectGroup(let group) = layer, group.name == "Triggers" {
                for object in group.objects {
                    if object.type == "transition" {
                        if let destination = object.properties?.first(where: { $0.name == "destination" })?.value {
                            let trigger = TileTrigger(
                                name: object.name,
                                destination: destination,
                                frame: object.frame
                            )
                            triggers.append(trigger)
                        }
                    }
                }
            }
        }

        return triggers
    }

    static func checkTriggers(at playerPosition: CGPoint, triggers: [TileTrigger]) -> TileTrigger? {
        for trigger in triggers {
            if trigger.frame.contains(playerPosition) {
                return trigger
            }
        }
        return nil
    }
}
