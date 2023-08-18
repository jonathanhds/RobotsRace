import SwiftUI

struct Score: View {
    let score: (robotA: Int, robotB: Int)

    var body: some View {
        HStack {
            Space(color: Colors.lightGreen)
            Text("\(score.robotA)")
                .foregroundColor(Colors.green)

            Spacer()

            Text("\(score.robotB)")
                .foregroundColor(Colors.lightPurple)
            Space(color: Colors.purple)
        }
    }
}

struct Score_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Score(score: (10, 10))
                .frame(maxHeight: 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}
