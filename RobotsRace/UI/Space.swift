import SwiftUI

struct Space: View {

    let color: Color

    var body: some View {
        Circle()
            .foregroundColor(color)
    }
}

extension Space {
    init(node: NodeState) {
        switch node {
        case .empty: self.init(color: Colors.gray)
        case .target: self.init(color: Colors.orange)
        case .robotA: self.init(color: Colors.lightGreen)
        case .robotATrail: self.init(color: Colors.green)
        case .robotB: self.init(color: Colors.lightPurple)
        case .robotBTrail: self.init(color: Colors.purple)
        }
    }
}

struct Space_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ForEach([Colors.gray, Colors.green, Colors.lightGreen, Colors.lightPurple, Colors.orange, Colors.purple], id: \.hashValue) { color in
                Space(color: color)
                    .frame(maxHeight: 50)
                    .padding(4)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}
