import SwiftUI

struct IndicatorLine: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 85, style: .continuous)
            .foregroundColor(.gray)
            .padding(8)
    }
}

struct IndicatorLine_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorLine()
    }
}
