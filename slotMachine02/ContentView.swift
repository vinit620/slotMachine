import SwiftUI

struct Hexagon: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let p1 = CGPoint(x: 0, y: 20)
            let p2 = CGPoint(x: 0, y: rect.height - 20)
            let p3 = CGPoint(x: rect.width / 2, y: rect.height)
            let p4 = CGPoint(x: rect.width, y: rect.height -  20)
            let p5 = CGPoint(x: rect.width, y: 20)
            let p6 = CGPoint(x: rect.width / 2, y: 0)
            
            path.move(to: p6)
            
            path.addArc(tangent1End: p1, tangent2End: p2, radius: 15)
            path.addArc(tangent1End: p2, tangent2End: p3, radius: 15)
            path.addArc(tangent1End: p3, tangent2End: p4, radius: 15)
            path.addArc(tangent1End: p4, tangent2End: p5, radius: 15)
            path.addArc(tangent1End: p5, tangent2End: p6, radius: 15)
            path.addArc(tangent1End: p6, tangent2End: p1, radius: 15)
            
        }
    }
}

enum Choice: Int, Identifiable {
    var id: Int { rawValue }
    case success, failure
}

struct ContentView: View {
    
    @State public var symbols = ["eating", "happy", "love", "scary", "sleeping"]
    @State public var numbers = [0, 1, 2, 3, 4]
    @State public var counter = 0
    @State private var showingAlert: Choice?
    
    var body: some View {
        ZStack {
            
            // Background Image
            Image("sunshine")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            // Body
            VStack {
                
                Spacer()
                
                // Title
                HStack {
                    Image("fire")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                    Text("SLOT MACHINE")
                        .font(.system(.largeTitle))
                        .fontWeight(.bold)
                    Image("fire")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                }
                .shadow(color: .orange,radius: 8, y: 8)
                
                Text("Remaining spin: \(10 - self.counter)")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                
                Spacer()
            
                
                HStack(spacing: 30) {
                    Hexagon()
                        .fill(Color.white.opacity(0.7))
                        .frame(width: 100, height:120, alignment: .center)
                        .overlay(Image(symbols[numbers[0]])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80)
                            .shadow(color: .gray, radius: 4, x: 4, y: 5)
                        )
                    Hexagon()
                        .fill(Color.white.opacity(0.7))
                        .frame(width: 100, height:120, alignment: .center)
                        .overlay(Image(symbols[numbers[1]])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80)
                            .shadow(color: .gray, radius: 4, x: 4, y: 5)
                        )
                    
                }
                
                Hexagon()
                    .fill(Color.white.opacity(0.7))
                    .frame(width: 100, height:120, alignment: .center)
                    .overlay(Image(symbols[numbers[2]])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80)
                        .shadow(color: .gray, radius: 4, x: 4, y: 5)
                    )

                HStack(spacing: 30) {
                    Hexagon()
                        .fill(Color.white.opacity(0.7))
                        .frame(width: 100, height:120, alignment: .center)
                        .overlay(Image(symbols[numbers[3]])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80)
                            .shadow(color: .gray, radius: 4, x: 4, y: 5)
                        )
                    Hexagon()
                        .fill(Color.white.opacity(0.7))
                        .frame(width: 100, height:120, alignment: .center)
                        .overlay(Image(symbols[numbers[4]])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80)
                            .shadow(color: .gray, radius: 4, x: 4, y: 5)
                        )
                    
                }
                
                Spacer()
                
                Button {
                    
                    // Randomize icon on screen
                    for i in 0..<self.numbers.count {
                        self.numbers[i] = Int.random(in: 0..<self.symbols.count)
                    }
                    self.counter += 1
                    
                    // Failure case
                    if self.counter > 10 {
                        self.showingAlert = .failure
                        self.counter = 0
                    }
                    
                    // Success case
                    if self.numbers[0]==self.numbers[1] && self.numbers[0]==self.numbers[2] && self.numbers[0]==self.numbers[3] && self.numbers[0]==self.numbers[4] {
                        self.showingAlert = .success
                        self.counter = 0
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 200, height: 50, alignment: .center)
                        .foregroundColor(Color("color"))
                        .shadow(color: .gray, radius: 4, y: 5)
                        .overlay(Text("Spin")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color(.black))
                        )
                }
                
                Spacer()

            }
            .alert(item: $showingAlert) { alert -> Alert in
                switch alert {
                case .success:
                    return Alert(title: Text("Yahh! You won"), message: Text("Born with the charm"), dismissButton: .cancel())
                case .failure:
                    return Alert(title: Text("Ooopppsss!"), message: Text("Better luck next time"), dismissButton: .cancel())
                }
            }
        }
    }
}
