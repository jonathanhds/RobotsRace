import Foundation

enum MoveResult {
    case nothing
    case targetFound
}

final class GameBoard {

    private let MATRIX_SIZE = 7

    private(set) var matrix: [[NodeState]] = []

    init() {
        setupBoard()
    }

    func setupBoard() {
        matrix = .init(repeating: .init(repeating: .empty, count: MATRIX_SIZE), count: MATRIX_SIZE)
        randomlyPlaceTargetOnBoard()
        placeRobotsOnBoard()
    }

    func move(robot: Robot, to nextMove: Direction) -> MoveResult {
        let position = robot.position
        var matrixCopy = matrix
        let movementDiff = nextMove.diff

        matrixCopy[position.x][position.y] = robot.trailNodeState

        if matrixCopy[position.x + movementDiff.x][position.y + movementDiff.y] == .target {
            return .targetFound
        } else {
            matrixCopy[position.x + movementDiff.x][position.y + movementDiff.y] = robot.nodeState
            self.matrix = matrixCopy
            return .nothing
        }
    }

    private func randomlyPlaceTargetOnBoard() {
        let i = (1..<MATRIX_SIZE - 1).randomElement() ?? 1
        let j = (1..<MATRIX_SIZE - 1).randomElement() ?? 1

        guard matrix[i][j] == .empty else {
            randomlyPlaceTargetOnBoard()
            return
        }

        matrix[i][j] = .target
    }

    private func placeRobotsOnBoard() {
        matrix[MATRIX_SIZE - 1][0] = .robotA
        matrix[0][MATRIX_SIZE - 1] = .robotB
    }

    func isMovementValid(from position: Position, to direction: Direction) -> Bool {
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
        let nextNode = matrix[position.x + diff.x][position.y + diff.y]

        switch nextNode {
        case .empty, .target: return true
        case .robotA, .robotB, .robotATrail, .robotBTrail: return false
        }
    }

    private func searchFor(nodeState: NodeState) -> Position? {
        for (x, row) in matrix.enumerated() {
            for (y, node) in row.enumerated() where node == nodeState {
                return (x: x, y: y)
            }
        }
        return nil
    }

    func targetPosition() -> Position {
        guard let position = searchFor(nodeState: .target) else {
            fatalError("Not able to find target position on grid")
        }

        return position
    }

    func robotAPosition() -> Position {
        guard let position = searchFor(nodeState: .robotA) else {
            fatalError("Not able to find RobotA on grid")
        }

        return position
    }

    func robotBPosition() -> Position {
        guard let position = searchFor(nodeState: .robotB) else {
            fatalError("Not able to find RobotB on grid")
        }

        return position
    }
}

extension GameBoard: CustomDebugStringConvertible {
    var debugDescription: String {
        matrix.reduce("") { partialResult, nodes in
            var mutablePartialResult = partialResult
            mutablePartialResult = mutablePartialResult + nodes.map { $0.debugDescription }.joined(separator: " ") + "\n"
            return mutablePartialResult
        }
    }
}
