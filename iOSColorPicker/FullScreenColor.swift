import SwiftUI

struct FullScreenColor: View {
    var body: some View {
        LinearGradient(colors: [.red, .green], startPoint: .bottom, endPoint: .top)
            .edgesIgnoringSafeArea(.all)
    }
}

struct FullScreenColor_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenColor()
    }
}
