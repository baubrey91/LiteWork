import SwiftUI
import Charts

#Preview {
    ChartView()
}

enum TimeSelection: String, CaseIterable {
    case allTime = "All Time"
    case year = "Year"
    case month = "Month"
}

struct ChartView: View {
    
    @StateObject private var viewModel = ChartViewModel()
    
    var body: some View {
        
        Picker("Time Filter", selection: $viewModel.timeSelection) {
               ForEach(TimeSelection.allCases, id: \.self) { segment in
                   Text(segment.rawValue).tag(segment)
               }
           }
           .pickerStyle(SegmentedPickerStyle())
           .padding()
        Chart {
            let filteredExercises = viewModel.foo(timeSelection: viewModel.timeSelection)
            
            if let selectedViewDay = viewModel.selectedViewDay {
                RuleMark(x: .value("Selected Month", selectedViewDay.date, unit: .day))
                    .foregroundStyle(.secondary.opacity(0.3))
                    .annotation(
                        position: .top,
                        overflowResolution: .init(
                            x: .fit(to: .chart),
                            y: .disabled)
                    ) {
                        VStack {
                            Text(selectedViewDay.date,
                                 format: .dateTime.month(.wide))
                            Text("\(Int(selectedViewDay.weight))")
                        }
                        // TODO: Add opacity
                        .padding(8)
                        .background(.gray)
                        .cornerRadius(10)
                    }
              
            }
            ForEach(filteredExercises) { exercise in
                BarMark(
                    x: .value("Month", exercise.date, unit: .day),
                    y: .value("Weight", exercise.weight)
                )
                //                    .opacity(rawSelectedDate == nil || exercise.date == selectedViewDay?.date  ? 1.0 : 0.5)
            }
            RuleMark(y: .value("Goal", 250))
                .foregroundStyle(.red)
                .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                .annotation(alignment: .leading) {
                    Text("Goal")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
        }
        .frame(height: 200)
        .chartXSelection(value: $viewModel.rawSelectedDate.animation(.easeIn))
        //            .padding()
        .chartXSelection(value: $viewModel.rawSelectedDate)
        .chartXAxis {
            AxisMarks {
                AxisValueLabel()
                AxisGridLine()
            }
        }
    }
}


final class ChartViewModel: ObservableObject {
    @Published var rawSelectedDate: Date?
    @Published var timeSelection: TimeSelection = .allTime
    
    let exercises = Workout.mockBenchPress
    
    var selectedViewDay: Workout? {
        guard let rawSelectedDate else { return nil }
        return Workout.mockBenchPress.first {
            Calendar.current.isDate(rawSelectedDate, equalTo: $0.date, toGranularity: .day)
        }
    }
    
    func foo(timeSelection: TimeSelection) -> [Workout] {
        switch timeSelection {
        case .allTime:
            return exercises
        case .month:
            let threeHundredSixtyFiveDaysAgo = Date.now.addingTimeInterval(-365 * 24 * 60 * 60) // 365 days ago
            return Workout.mockBenchPress.filter { $0.date >= threeHundredSixtyFiveDaysAgo }
        case .year:
            let thirtyDaysAgo = Date.now.addingTimeInterval(-30 * 24 * 60 * 60) // 30 days ago
            return Workout.mockBenchPress.filter { $0.date >= thirtyDaysAgo }
        }
    }
}
