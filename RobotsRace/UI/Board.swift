import SwiftUI

struct Board: View {

    @StateObject var viewModel = BoardViewModel()

    var body: some View {
        VStack {
            Score(score: viewModel.score)
                .frame(maxHeight: 20)

            HStack {
                ForEach(viewModel.rows, id: \.hashValue) { row in
                    VStack {
                        ForEach(row, id: \.hashValue) { node in
                            Space(node: node)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.start()
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
