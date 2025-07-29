import SwiftUI

//https://holyswift.app/how-to-create-an-circular-text-in-swiftui/

struct CircularTextView: View {
    @State var letterWidths: [Int:Double] = [:]
    
    var lettersOffset: [(offset: Int, element: Character)] {
        return Array(barbellWeight.text.enumerated())
    }
    var radius: Double
    let barbellWeight: BarbellWeight
    
    var body: some View {
        ZStack {
            ForEach(lettersOffset, id: \.offset) { index, letter in
                VStack {
                    Text(String(letter))
                        .font(.system(size: barbellWeight.font, design: .monospaced))
                        .foregroundColor(.white)
                        .kerning(5)
                        .background(LetterWidthSize())
                        .onPreferenceChange(WidthLetterPreferenceKey.self, perform: { width in
                            letterWidths[index] = width
                        })
                    Spacer()
                }
                .rotationEffect(fetchAngle(at: index))
            }
        }
        .frame(width: 2.5 * CGFloat(barbellWeight.value), height: 2.5 * CGFloat(barbellWeight.value))
        .rotationEffect(.degrees(125))
    }
    
    private func fetchAngle(at letterPosition: Int) -> Angle {
        let times2pi: (Double) -> Double = { $0 * 2 * .pi }
        let circumference = times2pi(radius)
        let finalAngle = times2pi(letterWidths.filter{$0.key <= letterPosition}.map(\.value).reduce(0, +) / circumference)
        return .radians(finalAngle)
    }
}

struct WidthLetterPreferenceKey: PreferenceKey {
    static var defaultValue: Double = 0
    static func reduce(value: inout Double, nextValue: () -> Double) {
        value = nextValue()
    }
}

struct LetterWidthSize: View {
    var body: some View {
        GeometryReader { geometry in // using this to get the width of EACH letter
            Color
                .clear
                .preference(key: WidthLetterPreferenceKey.self,
                            value: geometry.size.width)
        }
    }
}

