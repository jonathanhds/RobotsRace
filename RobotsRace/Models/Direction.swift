enum Direction: CaseIterable {
    case up
    case down
    case left
    case right
}

extension Direction {
    var diff: Position {
        switch self {
        case .up: return (x: 0, y: -1)
        case .down: return (x: 0, y: 1)
        case .left: return (x: -1, y: 0)
        case .right: return (x: 1, y: 0)
        }
    }
}
