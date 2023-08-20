import Foundation

final class Game: ObservableObject {

    private var gameBoard = GameBoard()

    var board: [[NodeState]] {
        gameBoard.matrix
    }

    var score: (robotA: Int, robotB: Int) {
        (robotA: robotA.score, robotB: robotB.score)
    }

    private var isRobotATurn = true
    private var couldntMoveLastTurn = false

    private lazy var robotA: Robot = {
        ApproximationRobot(
            player: .playerA,
            gameBoard.targetPosition,
            gameBoard.robotAPosition,
            gameBoard.isMovementValid
        )
    }()

    private lazy var robotB: Robot = {
        RandomRobot(
            player: .playerB,
            gameBoard.robotBPosition,
            gameBoard.isMovementValid
        )
    }()

    func start() {
        Task {
            while true {
                await runOneRound()
            }
        }
    }

    private func runOneRound() async {
        var lastResult: MoveResult = .nothing

        while lastResult == .nothing {
            lastResult = await step()
            objectWillChange.send()
            try? await Task.sleep(for: .seconds(0.5))
        }

        gameBoard.setupBoard()
        objectWillChange.send()
    }

    private func step() async -> MoveResult {
        var robot = isRobotATurn ? robotA : robotB

        guard let nextMove = await robot.decideNextMove() else {
            if couldntMoveLastTurn {
                gameBoard.setupBoard()
                isRobotATurn = true
            } else {
                couldntMoveLastTurn = true
                isRobotATurn.toggle()
            }

            return .nothing
        }

        couldntMoveLastTurn = false

        let moveResult = gameBoard.move(robot: robot, to: nextMove)
        switch moveResult {
        case .nothing:
            isRobotATurn.toggle()
        case .targetFound:
            robot.score += 1
        }

        return moveResult
    }
}

extension Game: CustomDebugStringConvertible {
    var debugDescription: String {
        gameBoard.debugDescription
    }
}
