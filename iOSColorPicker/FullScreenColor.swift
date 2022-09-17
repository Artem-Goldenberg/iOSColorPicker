import SwiftUI

struct FullScreenColor: View {
    let color: MultiColor
    var body: some View {
        color.view.edgesIgnoringSafeArea(.all)
    }
}

struct FullScreenColor_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenColor(color: MultiColor([.green, .blue], mode: .horizontal))
    }
}
