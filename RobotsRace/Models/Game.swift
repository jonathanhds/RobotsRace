import Foundation

final class Game {

    private let MATRIX_SIZE = 7

    private(set) var board: [[NodeState]] = []

    var score: (robotA: Int, robotB: Int) {
        (robotA: robotA.score, robotB: robotB.score)
    }

    private var isRobotATurn = true

    private lazy var robotA: Robot = {
        ApproximationRobot(
            targetPosition,
            robotAPosition,
            isMovementValid
        )
    }()

    private lazy var robotB: Robot = {
        RandomRobot(
            robotBPosition,
            isMovementValid
        )
    }()

    init() {
        setupBoard()
    }

    func step() async {
        let robot = isRobotATurn ? robotA : robotB
        var board = board

        guard let nextMove = await robot.decideNextMove() else {
            isRobotATurn.toggle()
            return
        }

        let movement = nextMove.diff

        board[robot.x][robot.y] = isRobotATurn ? .robotATrail : .robotBTrail

        if board[robot.x + movement.x][robot.y + movement.y] == .target {
            if isRobotATurn {
                robotA.score += 1
            } else {
                robotB.score += 1
            }

            resetBoard()
        } else {
            board[robot.x + movement.x][robot.y + movement.y] = isRobotATurn ? .robotA : .robotB
            self.board = board
            isRobotATurn.toggle()
        }
    }

    private func targetPosition() -> Position {
        guard let position = searchFor(nodeState: .target) else {
            fatalError("Not able to find target position on grid")
        }

        return position
    }

    private func robotAPosition() -> Position {
        guard let position = searchFor(nodeState: .robotA) else {
            fatalError("Not able to find RobotA on grid")
        }

        return position
    }

    private func robotBPosition() -> Position {
        guard let position = searchFor(nodeState: .robotB) else {
            fatalError("Not able to find RobotB on grid")
        }

        return position
    }

    private func resetBoard() {
        setupBoard()
        isRobotATurn = true
    }

    private func searchFor(nodeState: NodeState) -> Position? {
        for (x, row) in board.enumerated() {
            for (y, node) in row.enumerated() where node == nodeState {
                return (x: x, y: y)
            }
        }
        return nil
    }

    private func isMovementValid(from position: Position, to direction: Direction) -> Bool {
        switch direction {
        case .down:
            if position.y >= MATRIX_SIZE - 1 { return false }
        case .up:
            if position.y <= 0 { return false }
        case .right:
            if position.x >= MATRIX_SIZE - 1 { return false }
        case .left:
            if position.x <= 0 { return false }
        }

        let diff = direction.diff
        let nextNode = board[position.x + diff.x][position.y + diff.y]

        switch nextNode {
        case .empty, .target: return true
        case .robotA, .robotB, .robotATrail, .robotBTrail: return false
        }
    }

    private func setupBoard() {
        board = .init(repeating: .init(repeating: .empty, count: MATRIX_SIZE), count: MATRIX_SIZE)
        randomlyPlaceTargetOnBoard()
        placeRobotsOnBoard()
    }

    private func randomlyPlaceTargetOnBoard() {
        let i = (1..<MATRIX_SIZE - 1).randomElement() ?? 1
        let j = (1..<MATRIX_SIZE - 1).randomElement() ?? 1

        guard board[i][j] == .empty else {
            randomlyPlaceTargetOnBoard()
            return
        }

        board[i][j] = .target
    }

    private func placeRobotsOnBoard() {
        board[MATRIX_SIZE - 1][0] = .robotA
        board[0][MATRIX_SIZE - 1] = .robotB
    }
}

extension Game: CustomDebugStringConvertible {
    var debugDescription: String {
        board.reduce("") { partialResult, nodes in
            var mutablePartialResult = partialResult
            mutablePartialResult = mutablePartialResult + nodes.map { $0.debugDescription }.joined(separator: " ") + "\n"
            return mutablePartialResult
        }
    }
}
