import SwiftUI

struct MainView: View {
    @State private var showPicker = false;
    
    @State private var sampleColor = Color.clear
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    Section("My Implementation") {
                        Button {
                            showPicker.toggle()
                        } label: {
                            IndicatorLine()
                        }
                        NavigationLink("   See in full screen") {
                            FullScreenColor()
                        }.disabled(true)
                    }
                    
                    Section("Default Implementation") {
                        ColorPicker(selection: $sampleColor) {
                            Text("Default")
                        }
                        NavigationLink("See in full screen") {
                            FullScreenColor()
                        }.disabled(true)
                    }
                }
                HalfSheet(isPresented: $showPicker, height: 170) {
                    ColorSelectionView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
    }
}
