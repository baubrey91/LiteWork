import SwiftUI

struct DetailExerciseView: View {
    
    @Environment(\.modelContext) private var modelContext
    var exercises: [Workout] = Workout.mockBenchPress
    
    @State private var reps = 1
    @State private var showAlert = false
    
    let calendar = Calendar.current
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    // TODO: Add 2.5 weight later this requires a Double value
    
    var exercise: Exercise
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ChartView()
                    WeightView()
           
                    Text("Reps:")
                    Picker("Sets", selection: $reps) {
                        ForEach(1..<16) { number in
                            Text("\(number)").tag(number)
                        }
                    }
                    .pickerStyle(WheelPickerStyle()) // Using wheel style for a number picker
                    .frame(width: 400, height: 50)
                    
                    Button("Add Set") {
                        addItem()
                    }
                }
            }
            .navigationTitle("\(exercise.name)")
            .toolbar {
                ToolbarItem(placement: .destructiveAction) {
                    Button(action: {
                        self.showAlert = true
                    }) {
                        Image(systemName: "trash")
                    }
                }
            }
        }
        .alert(
            "Are you sure you want to delete this exercise?",
            isPresented: $showAlert,
            actions: {
                Button(role: .destructive) {
                    self.deleteExercise()
                } label: {
                    Text("Delete")
                }
                Button("Cancel", role: .cancel) {}
            },
            message: {
                Text("This cannot be undone")
            }
        )
    }
    
    private func deleteExercise() {
        modelContext.delete(exercise)
    }
    
    private func addItem() {
        withAnimation {
            let workout = Workout(
                date: Date(),
                name: self.exercise.name,
                reps: self.reps,
                //TODO: Fix
                weight: 10
            )
            modelContext.insert(workout)
        }
    }
    
    //    private func deleteItems(offsets: IndexSet) {
    //        withAnimation {
    //            for index in offsets {
    //                modelContext.delete(exercises[index])
    //            }
    //        }
    //    }
}


final class DetailExerciseViewModel: ObservableObject {
    
}
