import SwiftUI

#Preview {
    HomeView()
        .modelContainer(for: Exercise.self, inMemory: true)
}

struct HomeView: View {
    
    var body: some View {
            TabView {
                ExerciseView(exerciseGroup: .upperBody)
                    .tabItem {
                        Image("arm")
                        Text("Upper Body")
                    }
                ExerciseView(exerciseGroup: .lowerBody)
                    .tabItem {
                        Image("leg")
                        Text("Lower Body")
                    }
                ExerciseView(exerciseGroup: .calisthenicsCore)
                    .tabItem {
                        Image("pull_up")
                        Text("Calisthenics")
                    }
                ExerciseView(exerciseGroup: .cardio)
                    .tabItem {
                        Image(systemName: "figure.run.treadmill")
                        Text("Cardio")
                    }
                CaloriesView()
                    .tabItem {
                        Image("apple")
                        Text("Diet")
                    }
            }
    }
}
