import SwiftUI

struct GameScreen: View {
    var body: some View {
        VStack {
            Spacer()

            Score()
                .padding(.horizontal)
                .frame(maxHeight: 20)

            Board()
                .padding()

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}

struct GameScreen_Previews: PreviewProvider {
    static var previews: some View {
        GameScreen()
    }
}
