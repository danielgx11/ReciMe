import SwiftData
import SwiftUI

struct FavouriteButton: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var favourites: [FavouriteRecipe]

    let recipeID: String

    private var favourite: FavouriteRecipe? {
        favourites.first { $0.recipeID == recipeID }
    }

    var body: some View {
        let isFavourite = favourite != nil
        Button(
            isFavourite ? Strings.removeFromSaved : Strings.saveRecipe,
            systemImage: isFavourite ? Images.filledHeart : Images.heart
        ) {
            if let favourite {
                modelContext.delete(favourite)
            } else {
                modelContext.insert(FavouriteRecipe(recipeID: recipeID))
            }
        }
        .labelStyle(.iconOnly)
        .foregroundStyle(isFavourite ? Colors.blueberry : .primary)
        .padding(Metrics.spacing8)
        .background(.thinMaterial, in: Circle())
        .accessibilityLabel(isFavourite ? Strings.Accessibility.removeFromSaved : Strings.saveRecipe)
    }
}
