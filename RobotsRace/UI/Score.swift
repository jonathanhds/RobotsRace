import SwiftUI

struct Score: View {
    var body: some View {
        HStack {
            Space(color: Colors.lightPurple)
            Text("10")
                .foregroundColor(Colors.purple)

            Spacer()

            Text("10")
                .foregroundColor(Colors.lightGreen)
            Space(color: Colors.green)
        }
    }
}

struct Score_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Score()
                .frame(maxHeight: 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}
