enum NodeState {
    case empty
    case target
    case robotA
    case robotATrail
    case robotB
    case robotBTrail
}

extension NodeState: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .empty: return "*"
        case .robotA, .robotATrail: return "A"
        case .robotB, .robotBTrail: return "B"
        case .target: return "T"
        }
    }
}
