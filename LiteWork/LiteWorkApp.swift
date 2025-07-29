import SwiftUI
import SwiftData

@main
struct LiteWorkApp: App {
    
    private var sharedModelContainer: ModelContainer = {
        let schema = Schema([Exercise.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    init() {
        prePopulateDatabase()
    }

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: Exercise.self)
    }
    
    private func prePopulateDatabase() {
        // Remove raw string
        guard !UserDefaults.standard.bool(forKey: "DefaultWorkouts") else { return }
        UserDefaults.standard.set(true, forKey: "DefaultWorkouts")

        
        for exercise in MasterExerciseList.UpperBody {
            sharedModelContainer.mainContext.insert(Exercise(name: exercise, group: .upperBody, type: .weighted))
        }
        
        for exercise in MasterExerciseList.LowerBody {
            sharedModelContainer.mainContext.insert(Exercise(name: exercise, group: .lowerBody, type: .weighted))
        }
        
        for exercise in MasterExerciseList.CalisenthenicAbs {
            sharedModelContainer.mainContext.insert(Exercise(name: exercise, group: .calisthenicsCore, type: .calisthenic))
        }
        
        // TODO: Log erroring later
//        do {
//            try? sharedModelContainer.mainContext.save()
//        } catch {
//            print("error")
//        }
        

    }
}
