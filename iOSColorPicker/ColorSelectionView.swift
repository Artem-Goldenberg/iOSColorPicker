import SwiftUI

private struct ColorSample {
    private(set) var color: Color
    var isSelected: Bool
    
    init(color: Color) {
        self.color = color
        isSelected = false
    }
}

struct ColorSelectionView: View {
    @State private var samples = Color.allColors.map(ColorSample.init)
    
    var body: some View {
        let amount = samples.count
        return VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                VStack {
                    HStack {
                        colorViews(for: 0..<(amount / 2))
                    }
                    HStack {
                        colorViews(for: (amount / 2)..<amount)
                    }
                }
            }
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 80, style: .continuous)
                        .fill(.gray.opacity(0.2))
                        .frame(height: 50, alignment: .top)
                    Text("Apply")
                        .foregroundColor(.black)
                        .font(.title3)
                }
            }
        }
    }
    
    @ViewBuilder
    private func colorViews(for range: Range<Int>) -> some View {
        ForEach(range, id: \.self) {
            colorView(for: $0)
        }
    }
    
    @ViewBuilder
    private func colorView(for index: Int) -> some View {
        Button {
            withAnimation {
                samples[index].isSelected.toggle()
            }
        } label: {
            Circle()
                .strokeBorder(samples[index].isSelected ? .yellow : .blue, lineWidth: 4)
                .background(Circle().fill(samples[index].color))
                .frame(width: 50, height: 40)
        }
    }
}

private extension Color {
    static var allColors: [Color] {
        [
            .brown,
            .blue,
            .gray,
            .red,
            .yellow,
            .green,
            .black,
            .white,
            .cyan,
            .indigo,
            .mint,
            .orange,
            .purple,
            .teal
        ]
    }
}

struct ColorSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelectionView()
    }
}
