import Foundation

nonisolated struct Recipe: Identifiable, Codable, Hashable, Sendable {
    let id: String
    let imageName: String
    let title: String
    let description: String
    let servings: Int
    let ingredients: [String]
    let instructions: [String]
    let dietaryAttributes: [DietaryAttribute]
}

nonisolated struct RecipeResponse: Codable, Sendable {
    let recipes: [Recipe]
}
