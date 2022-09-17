import SwiftUI

struct FullScreenColor: View {
    @Environment(\.dismiss) private var dismiss
    let color: MultiColor
    var body: some View {
        color.view
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem (placement: .navigation)  {
                    Button(action: dismiss.callAsFunction) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                }
            }
    }
}

struct FullScreenColor_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenColor(color: MultiColor([.green, .blue], mode: .horizontal))
    }
}
