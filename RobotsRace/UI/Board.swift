import SwiftUI

struct Board: View {
    var body: some View {
        VStack {
            ForEach(0..<6) { j in
                HStack {
                    ForEach(0..<6) { i in
                        Space(color: Colors.gray)
                    }
                }
            }
        }
    }
}

struct Board_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Board()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}
