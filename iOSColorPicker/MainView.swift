import SwiftUI

struct MainView: View {
    @State private var showPicker = false;
    
    @State private var multiColor = MultiColor([], mode: .horizontal)
    @State private var exampleColor = Color.clear
    
    @State private var mode = MultiColor.Mode.horizontal

    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    Section("My Implementation") {
                        Button {
                            showPicker = true
                        } label: {
                            IndicatorLine(multiColor)
                        }
                        Menu {
                            Picker("Select Mode", selection: $mode) {
                                ForEach(MultiColor.Mode.allCases, id: \.self) {
                                    Text($0.rawValue)
                                }
                            }.onChange(of: mode) { mode in
                                multiColor.mode = mode
                            }
                        } label: {
                            Text("   Select Mode")
                        }
                        NavigationLink("   See in full screen") {
                            FullScreenColor(color: multiColor)
                        }.disabled(multiColor.colors.isEmpty)
                    }
                    
                    Section("Default Implementation") {
                        ColorPicker(selection: $exampleColor) {
                            Text("Default")
                        }
                        NavigationLink("See in full screen") {
                            FullScreenColor(color: .init(exampleColor))
                        }
                    }
                }
                HalfSheet(isPresented: $showPicker, height: 170) {
                    ColorSelectionView(selection: $multiColor, isPresented: $showPicker)
                }
            }
            .navigationTitle("Some Colors")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
    }
}
