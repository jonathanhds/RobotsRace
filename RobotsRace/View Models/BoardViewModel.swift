import Foundation
import Combine

class BoardViewModel: ObservableObject {

    private(set) var game = Game()

    private var cancellable: AnyCancellable?

    var score: (robotA: Int, robotB: Int) {
        game.score
    }

    var rows: [[NodeState]] {
        game.board
    }

    func start() {
        cancellable = game
            .objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.objectWillChange.send()
            }

        game.start()
    }
}
