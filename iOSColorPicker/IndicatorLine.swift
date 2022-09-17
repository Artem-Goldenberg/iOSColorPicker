import SwiftUI

struct IndicatorLine: View {
    let color: MultiColor
    init(_ color: MultiColor) {
        if color.colors.isEmpty {
            self.color = MultiColor(.gray)
        } else {
            self.color = color
        }
    }
    var body: some View {
        RoundedRectangle(cornerRadius: 85, style: .continuous)
            .multiColored(color)
            .padding(8)
    }
}
