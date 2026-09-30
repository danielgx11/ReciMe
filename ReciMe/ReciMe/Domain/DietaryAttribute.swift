import Foundation

nonisolated enum DietaryAttribute: String, Codable, CaseIterable, Hashable, Sendable {
    case vegetarian = "Vegetarian"
    case vegan = "Vegan"
    case glutenFree = "Gluten-Free"
    case dairyFree = "Dairy-Free"
    case keto = "Keto"
    case nutFree = "Nut-Free"

    var symbol: String {
        switch self {
        case .vegetarian, .vegan: 
            "leaf.fill"
        case .glutenFree:
            "wheat.arsl"
        case .dairyFree:
            "drop.fill"
        case .keto:
            "bolt.fill"
        case .nutFree:
            "checkmark.shield.fill"
        }
    }
}
