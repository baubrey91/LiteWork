import Foundation
import SwiftData

enum ExerciseGroup: String, Codable, CaseIterable {
    case upperBody
    case lowerBody
    case calisthenicsCore
    case cardio
}

enum ExerciseType: String, Codable, CaseIterable {
    case weighted
    case calisthenic
    case cardio
}

@Model
final class Exercise {
    var name: String
    var group: String
    var type: String
    
    init(name: String, group: ExerciseGroup, type: ExerciseType) {
        self.name = name
        self.group = group.rawValue
        self.type = type.rawValue
    }
}
