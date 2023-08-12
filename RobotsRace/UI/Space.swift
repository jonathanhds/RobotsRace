import SwiftUI

struct Space: View {

    let color: Color

    var body: some View {
        Circle()
            .foregroundColor(color)
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
