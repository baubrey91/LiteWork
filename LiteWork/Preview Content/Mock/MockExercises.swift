import Foundation

struct MasterExerciseList {
    static let UpperBody: [String] = ["Bench Press",
                                      "Incline Press",
                                      "Bicep Curl",
                                      "Seated Bicep Curl",
                                      "Rows",
                                      "Lateral Pulldown",
                                      "Tricep Pulldown",
                                      "Shoulder Raises"
    ]
    
    static let LowerBody: [String] = ["Calf Presses",
                                      "Incline Machine",
                                      "Squat Walk",
                                      "Leg Extension",
                                      "Leg Curl",
                                      "Hip Abducter Inner",
                                      "Hip Abducter Outter",
                                      "Deadlift",
                                      "Squats"
    ]
    
    static let CalisenthenicAbs: [String] = ["Pull Ups",
                                           "L Sits",
                                           "Russian Twists",
                                           "Plank",
                                           "Side Plank",
                                           "Crunches",
                                           "Farmers Walk",
                                           "Side Crunches"
    ]
}


func getMockDate(daysAgo: Int) -> Date {
    return Calendar.current.date(byAdding: .day, value: -daysAgo, to: Date())!
}
