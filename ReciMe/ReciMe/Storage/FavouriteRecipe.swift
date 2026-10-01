import Foundation
import SwiftData

@Model
final class FavouriteRecipe {
    @Attribute(.unique) var recipeID: String
    var createdAt: Date

    init(recipeID: String, createdAt: Date = .now) {
        self.recipeID = recipeID
        self.createdAt = createdAt
    }
}
