import Foundation

typealias IsMovementValid = ((Position, Direction) -> Bool)

protocol Robot {
    var position: Position { get }
    var score: Int { get set }
    func decideNextMove() async -> Direction?
}

extension Robot {
    var x: Int { position.x }
    var y: Int { position.y }
}

extension Robot {
    fileprivate func randomMove(_ position: Position, _ isMovementValid: IsMovementValid) -> Direction? {
        var allMoves = Direction.allCases.shuffled()

        while !allMoves.isEmpty {
            let nextDirection = allMoves.removeFirst()
            if isMovementValid(position, nextDirection) {
                return nextDirection
            }
        }

        return nil // No movement is valid
    }
}

final class RandomRobot: Robot {

    var score: Int = 0
    var position: Position { currentPosition() }
    private let currentPosition: () -> Position
    private let isMovementValid: IsMovementValid

    init(
        _ currentPosition: @escaping () -> Position,
        _ isMovementValid: @escaping IsMovementValid
    ) {
        self.currentPosition = currentPosition
        self.isMovementValid = isMovementValid
    }

    func decideNextMove() async -> Direction? {
        randomMove(position, isMovementValid)
    }
}

final class ApproximationRobot: Robot {

    var score: Int = 0
    var position: Position { currentPosition() }
    private let targetPosition: () -> Position
    private let currentPosition: () -> Position
    private let isMovementValid: IsMovementValid

    init(
        _ targetPosition: @escaping () -> Position,
        _ currentPosition: @escaping () -> Position,
        _ isMovementValid: @escaping IsMovementValid
    ) {
        self.targetPosition = targetPosition
        self.currentPosition = currentPosition
        self.isMovementValid = isMovementValid
    }

    func decideNextMove() async -> Direction? {
        let position = self.position
        let targetPosition = self.targetPosition()

        if position.x != targetPosition.x {
            if position.x > targetPosition.x, isMovementValid(position, .left) { return .left }
            if position.x < targetPosition.x, isMovementValid(position, .right) { return .right }
        }

        if position.y != targetPosition.y {
            if position.y > targetPosition.y, isMovementValid(position, .up) { return .up }
            if position.y < targetPosition.y, isMovementValid(position, .down) { return .down }
        }

        return randomMove(position, isMovementValid)
    }
}
