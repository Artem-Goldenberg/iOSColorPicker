import SwiftUI

struct HalfSheet<ContentType: View>: View {
    private let height: CGFloat
    private let threshold: CGFloat = 100
    
    let content: () -> ContentType
    @Binding var isPresented: Bool
    
    init(isPresented: Binding<Bool>, height: CGFloat,  @ViewBuilder content: @escaping () -> ContentType) {
        self._isPresented = isPresented
        self.height = height
        self.content = content
    }
    
    @GestureState private var currentOffset: CGFloat = 0
    
    private var offset: CGFloat {
        isPresented ? 0 : height
    }
    
    var body: some View {
        if isPresented {
            GeometryReader { geo in
                content()
                    .padding(.top)
                    .frame(height: height, alignment: .top)
                    .background(Color(.systemBackground))
                    .frame(height: geo.size.height, alignment: .bottom)
                    .offset(x: 0, y: max(currentOffset, 0))
                    .animation(.interactiveSpring(), value: isPresented)
                    .animation(.interactiveSpring(), value: currentOffset)
                    .gesture(
                        DragGesture()
                            .updating($currentOffset) { value, state, _ in
                                state = value.translation.height
                            }
                            .onEnded { value in
                                if value.translation.height > threshold {
                                    isPresented = false
                                }
                            }
                    )
            }
        }
    }
}
