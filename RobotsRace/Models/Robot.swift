import Foundation

typealias IsMovementValid = ((Position, Direction) -> Bool)

protocol Robot {
    var position: Position { get }
    func decideNextMove() -> Direction?
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

    let position: Position

    private let isMovementValid: IsMovementValid

    init(
        _ position: Position,
        _ isMovementValid: @escaping IsMovementValid
    ) {
        self.position = position
        self.isMovementValid = isMovementValid
    }

    func decideNextMove() -> Direction? {
        randomMove(position, isMovementValid)
    }
}

final class ApproximationRobot: Robot {

    let position: Position
    private let targetPosition: Position
    private let isMovementValid: IsMovementValid

    init(
        _ position: Position,
        _ targetPosition: Position,
        _ isMovementValid: @escaping IsMovementValid
    ) {
        self.position = position
        self.targetPosition = targetPosition
        self.isMovementValid = isMovementValid
    }

    func decideNextMove() -> Direction? {
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
