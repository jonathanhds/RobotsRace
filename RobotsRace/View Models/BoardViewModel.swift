import Foundation

class BoardViewModel: ObservableObject {

    @Published private(set) var game = Game()

    var score: (robotA: Int, robotB: Int) {
        game.score
    }

    var rows: [[NodeState]] {
        game.board
    }

    func step() {
        Task {
            await game.step()
        }

        objectWillChange.send()
    }
}
