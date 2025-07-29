
enum BarbellWeight {
    case fortyFive
    case thirtyFive
    case twentyFive
    case ten
    case five
    case none
    
    var value: Double {
        switch self {
        case .fortyFive: 45
        case .thirtyFive: 35
        case .twentyFive: 25
        case .ten: 10
        case .five: 5
        case .none: 0
        }
    }
    
    var color: Color {
        switch self {
        case .fortyFive: .red
        case .thirtyFive: .yellow
        case .twentyFive: .orange
        case .ten: .blue
        case .five: .green
        case .none: .gray
        }
    }
    
    var font: CGFloat {
        switch self {
        case .fortyFive: 13
        case .thirtyFive: 11
        case .twentyFive: 9
        default:
            fatalError()
        }
    }
    
    var text: String {
        switch self {
        case .fortyFive: "BARBELL • BARBELL • "
        case .thirtyFive: "BARBELL  •  BARBELL  •  "
        case .twentyFive: "BARBELL   •   BARBELL   •   "
        default:
            fatalError()
            
        }
    }
}
