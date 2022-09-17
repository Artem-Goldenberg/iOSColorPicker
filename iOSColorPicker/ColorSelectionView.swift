import SwiftUI

private struct ColorSample {
    private(set) var color: Color
    var isSelected: Bool
    
    init(color: Color, isSelected: Bool) {
        self.color = color
        self.isSelected = isSelected
    }
    
    init(color: Color) {
        self.init(color: color, isSelected: false)
    }
}

struct ColorSelectionView: View {
    @State private var samples = Color.allColors.map(ColorSample.init)
    
    @Binding var multiColor: MultiColor
    @Binding var isPresented: Bool
    
    private lazy var colorToSample: (Color) -> ColorSample = { color in
        if multiColor.colors.contains(where: { $0 == UIColor(color) }) {
            return ColorSample(color: color, isSelected: true)
        }
        return ColorSample(color: color)
    }
    
    init(selection: Binding<MultiColor>, isPresented: Binding<Bool>) {
        self._multiColor = selection
        self._isPresented = isPresented
    }
    
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
            }.onAppear {
                // выбираем все цвета из списка
                multiColor.colors.forEach {
                    changeSelection(of: $0, to: true)
                }
            }
            doneButton
        }
    }
    
    @ViewBuilder
    private func colorViews(for range: Range<Int>) -> some View {
        ForEach(range, id: \.self) {
            colorSelectButton(for: $0)
        }
    }
    
    @ViewBuilder
    private func colorSelectButton(for index: Int) -> some View {
        Button {
            // если кнопка этого цвета нажата и цвет в нашем списке значит он уже был выбран
            // ранее и повторное нажатие убирает его
            if let found = multiColor.colors.firstIndex(of: UIColor(samples[index].color)) {
                multiColor.colors.remove(at: found)
            }
            
            withAnimation {
                samples[index].isSelected.toggle()
            }
            
            // если цвет был выбран, то добавляем его в список
            if samples[index].isSelected {
                multiColor.colors.append(UIColor(samples[index].color))
                // если список стал слишком большой, то удаляем первый элемент из списка
                // и убираем с него выбор
                if multiColor.colors.count > 3 {
                    let colorToDeselect = multiColor.colors.removeFirst()
                    changeSelection(of: colorToDeselect, to: false, animated: true)
                }
            }
        } label: {
            Circle()
                .strokeBorder(samples[index].isSelected ? .yellow : .blue, lineWidth: 4)
                .background(Circle().fill(samples[index].color))
                .frame(width: 50, height: 40)
        }
    }
    
    var doneButton: some View {
        Button {
            isPresented = false
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 80, style: .continuous)
                    .fill(.gray.opacity(0.2))
                    .frame(height: 50, alignment: .top)
                Text("Done")
                    .foregroundColor(.black)
                    .font(.title3)
            }
        }
    }
    
    private func changeSelection(of color: UIColor, to value: Bool, animated: Bool = false) {
        guard let found = samples.firstIndex(where: { UIColor($0.color) == color })
        else { return }
        if animated {
            withAnimation {
                samples[found].isSelected = value
            }
        } else {
            samples[found].isSelected = value
        }
    }
}

private extension Color {
    static var allColors: [Color] {
        [
            .red,
            .yellow,
            .orange,
            .purple,
            .green,
            .blue,
            .cyan,
            .mint,
            .indigo,
            .teal,
            .brown,
            .gray,
            .black,
            .white
        ]
    }
}
