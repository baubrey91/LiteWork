import SwiftUI
import SwiftData

#Preview {
    AddExerciseView(type: ExerciseType.weighted, group: .upperBody)
}

struct ExerciseView: View {
    
    @Query private var exercises: [Exercise]
    @State private var showSheet = false

    init(exerciseGroup: ExerciseGroup) {
        _exercises = Query(
            filter: #Predicate<Exercise> { $0.group == exerciseGroup.rawValue },
            sort: \.name
          )
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        ForEach(exercises, id: \.self) { exercise in
                            NavigationLink(destination: DetailExerciseView(exercise: exercise)) {
                                Text("\(exercise.name)")
                            }
                        }
                    }
                    //Remove the grab from first!
//                    NavigationLink(destination: AddExerciseView(type: exercises.first!.type)) {
                    Button("Add Exercise") {
                        showSheet.toggle()
                    }
//                    }
                }
            }
        }
        .navigationTitle("Upper Body")
        .sheet(isPresented: $showSheet) {
            AddExerciseView(type: ExerciseType(rawValue: exercises.first!.type)!, group: ExerciseGroup(rawValue: exercises.first!.group)!)
        }
    }
}


struct AddExerciseView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var textInput: String = ""
    @State var type: ExerciseType
    @State var group: ExerciseGroup

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                
                .padding(20)
            }
            Spacer()
            VStack(spacing: 40) {
                HStack {
                    Text("Exercise name: ")
                    TextField("", text: $textInput)
                }
                HStack {
                    Picker("Type", selection: $type) {
                        ForEach(ExerciseType.allCases, id: \.self) { type in
                            Text("\(type.rawValue)").tag(type)
                        }
                    }
                    .pickerStyle(WheelPickerStyle()) // Using wheel style for a number picker
                    .frame(width: 400, height: 50)
//                    Text("Exercise type: ")
//                    TextField("", text: $type)
                }
                HStack {
                    Picker("Group", selection: $type) {
                        ForEach(ExerciseGroup.allCases, id: \.self) { group in
                            Text("\(group.rawValue)").tag(group)
                        }
                    }
                    .pickerStyle(WheelPickerStyle()) // Using wheel style for a number picker
                    .frame(width: 400, height: 50)
                }
                Button("Add") {
                    // TODO: Validate fields have been filled out
                    addNewExercise()
                }
            }
            Spacer()
        }
        .padding(20)
    }
    
    private func addNewExercise() {
        let exercise = Exercise(
            name: textInput,
            group: group,
            type: type
        )
        
        modelContext.insert(exercise)
        dismiss()
    }
}

//struct ExerciseListView: View {
//    var exercises: [String]
//    
//    var body: some View {
//    }
//}

struct CaloriesView: View {
    var body: some View {
        Text("Calories View")
    }
}
