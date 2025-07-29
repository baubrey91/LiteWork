import SwiftData
import Foundation

@Model
final class Workout {
    var date: Date
    var name: String
    var reps: Int
    var weight: Double
    
    init(date: Date, name: String, reps: Int, weight: Double) {
        self.date = date
        self.name = name
        self.reps = reps
        self.weight = weight
    }
}

extension Workout {
    static let mockBenchPress = [
        Workout(date: getMockDate(daysAgo: 1), name: "Bench Press", reps: 5, weight: 145),
        Workout(date: getMockDate(daysAgo: 3), name: "Bench Press", reps: 6, weight: 155),
        Workout(date: getMockDate(daysAgo: 5), name: "Bench Press", reps: 5, weight: 155),
        Workout(date: getMockDate(daysAgo: 7), name: "Bench Press", reps: 5, weight: 135),
        Workout(date: getMockDate(daysAgo: 9), name: "Bench Press", reps: 3, weight: 120),
        Workout(date: getMockDate(daysAgo: 11), name: "Bench Press", reps: 5, weight: 125),
        Workout(date: getMockDate(daysAgo: 13), name: "Bench Press", reps: 4, weight: 120),
        Workout(date: getMockDate(daysAgo: 15), name: "Bench Press", reps: 3, weight: 115),
        Workout(date: getMockDate(daysAgo: 17), name: "Bench Press", reps: 5, weight: 115),
        Workout(date: getMockDate(daysAgo: 40), name: "Bench Press", reps: 5, weight: 145),
        Workout(date: getMockDate(daysAgo: 43), name: "Bench Press", reps: 6, weight: 155),
        Workout(date: getMockDate(daysAgo: 45), name: "Bench Press", reps: 5, weight: 155),
        Workout(date: getMockDate(daysAgo: 47), name: "Bench Press", reps: 5, weight: 135),
        Workout(date: getMockDate(daysAgo: 49), name: "Bench Press", reps: 3, weight: 120),
        Workout(date: getMockDate(daysAgo: 51), name: "Bench Press", reps: 5, weight: 125),
        Workout(date: getMockDate(daysAgo: 53), name: "Bench Press", reps: 4, weight: 120),
        Workout(date: getMockDate(daysAgo: 55), name: "Bench Press", reps: 3, weight: 115),
        Workout(date: getMockDate(daysAgo: 57), name: "Bench Press", reps: 5, weight: 115),
        Workout(date: getMockDate(daysAgo: 401), name: "Bench Press", reps: 5, weight: 145),
        Workout(date: getMockDate(daysAgo: 403), name: "Bench Press", reps: 6, weight: 155),
        Workout(date: getMockDate(daysAgo: 405), name: "Bench Press", reps: 5, weight: 155),
        Workout(date: getMockDate(daysAgo: 407), name: "Bench Press", reps: 5, weight: 135),
        Workout(date: getMockDate(daysAgo: 409), name: "Bench Press", reps: 3, weight: 120),
        Workout(date: getMockDate(daysAgo: 411), name: "Bench Press", reps: 5, weight: 125),
        Workout(date: getMockDate(daysAgo: 413), name: "Bench Press", reps: 4, weight: 120),
        Workout(date: getMockDate(daysAgo: 415), name: "Bench Press", reps: 3, weight: 115),
        Workout(date: getMockDate(daysAgo: 417), name: "Bench Press", reps: 5, weight: 115)
    ]
}
