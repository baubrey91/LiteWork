import SwiftUI

struct WeightView: View {
    let weights: [BarbellWeight] = [.fortyFive, .thirtyFive, .twentyFive, .ten, .five]

    @State private var barbell: [BarbellWeight] = []
    @State private var barbellWidth: CGFloat = 220

    @State private var weight: Double = 0 {
        didSet {
            calculateBarbell()
        }
    }

    var body: some View {
        VStack(spacing: 24) {

            Text("Weight: \(Int(self.weight))")
            // Barbell with selected weights
            HStack(spacing: 4) {
                Rectangle()
                    .frame(width: 10, height: 40)
                    .foregroundColor(.black) // bar
                
                ForEach(barbell, id: \.self) { weight in
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: 20, height: CGFloat(weight.value * 2))
                        .foregroundColor(weight.color)
                        .onTapGesture {
                            self.weight -= weight.value
                        }
                }
                
                Rectangle()
                    .frame(width: barbellWidth, height: 20)
                    .foregroundColor(.black) // bar
            }
            .frame(height: 120)
            .animation(.easeInOut, value: barbell)

            // Row of selectable weights
            HStack(spacing: 16) {
                ForEach(weights, id: \.self) { barbellWeight in
                    Button(action: {
                        guard self.weight + barbellWeight.value <= 400 else { return }
                        self.weight += barbellWeight.value
                    }) {
                        WeightPlateView(weight: barbellWeight)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding()
        Slider(
            value: $weight,
            in: 0...400,
            step: 5
        )
        .onChange(of: weight) { _, _ in self.calculateBarbell() }
        .accentColor(.red)
        .padding()
    }

    private func calculateBarbell() {
        let possiblePlates: [BarbellWeight] = [.fortyFive, .thirtyFive, .twentyFive, .ten, .five]
        var remainingWeight = weight
        var result: [BarbellWeight] = []

        //TODO: - Crashes if clicking too fast
        for plate in possiblePlates {
            let count = Int(remainingWeight / plate.value)
            guard count > 0 else { continue }
            for _ in 0..<count {
                result.append(plate)
            }
            remainingWeight = (remainingWeight - (Double(count) * plate.value)).rounded(toPlaces: 2)
        }
        self.barbell = result
        
        barbellWidth = CGFloat(220 - (result.count * 20))
    }
}

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

struct WeightPlateView: View {
    
    let weight: BarbellWeight
    let size: CGFloat

    init(weight: BarbellWeight) {
        self.weight = weight
        self.size = 2.5 * CGFloat(weight.value)
    }

    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            ZStack(alignment: .center) {
                // Plate background
                Circle()
                    .fill(weight.color)
                    .frame(width: size, height: size)
                
                // Inner hole
                Circle()
                    .fill(Color.black)
                    .frame(width: size * 0.25, height: size * 0.25)
                
                if [.fortyFive, .thirtyFive, .twentyFive].contains(weight) {
                    CircularTextView(radius: 45, barbellWeight: weight)
                }
            }
            Spacer()
            Text("\(Int(weight.value))")
                .font(.caption)
                .fontWeight(.medium)
        }
    }

    // MARK: - Curved Text Function
    func curvedText(text: String, radius: CGFloat, startAngle: Double, isBottom: Bool = false) -> some View {
        let characters = Array(text)
        let anglePerChar = 180.0 / Double(characters.count)
        return ZStack {
            ForEach(0..<characters.count, id: \.self) { i in
                let angle = startAngle + anglePerChar * Double(i) - 90
                let angleInRadians = Angle(degrees: angle).radians

                Text(String(characters[i]))
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                    .position(x: size / 2 + radius * cos(angleInRadians),
                              y: size / 2 + radius * sin(angleInRadians))
                    .rotationEffect(Angle(degrees: isBottom ? angle + 180 : angle))
            }
        }
    }
}
