import SwiftUI

/// Модель для цвета
/// Передайте ей цвета которые хотите использовать
/// Есть два режима: горизонтальный и вертикальный
struct MultiColor {
    // Градиент с одним цветом это просто этот цвет
    // Поэтому можно все хранить в LinearGradient
    private let mode: Mode
    var colors: [UIColor]
    
    var view: LinearGradient {
        let (startPoint, endPoint) = mode.points
        return LinearGradient(colors: colors.map(Color.init), startPoint: startPoint , endPoint: endPoint)
    }
    
    init(_ colors: [UIColor], mode: Mode) {
        self.mode = mode
        self.colors = colors
    }
    
    init(_ color: Color) {
        self.init([UIColor(color)], mode: .horizontal)
    }
    
    enum Mode: String, CaseIterable {
        case horizontal
        case vertical
        
        var points: (start: UnitPoint, end: UnitPoint) {
            switch self {
            case .horizontal: return (.leading, .trailing)
            case .vertical: return (.top, .bottom)
            }
        }
    }
}

/// отдельный метод для `Shape` и для `View`
/// позволяют унифицировать использование класса для любого `View`

extension Shape {
    func multiColored(_ multiColor: MultiColor) -> some View {
        self.fill(multiColor.view)
    }
}

extension View {
    func multiColored(_ multiColor: MultiColor) -> some View {
        self.background(multiColor.view)
    }
}
