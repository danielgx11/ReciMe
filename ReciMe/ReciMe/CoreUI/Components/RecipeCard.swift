import SwiftUI

struct RecipeCard: View {
    let recipe: Recipe
    let isFavourite: Bool

    var body: some View {
        ZStack(alignment: .topTrailing) {
            NavigationLink {
                RecipeDetailView(recipe: recipe, isFavourite: isFavourite)
            } label: {
                VStack(alignment: .leading, spacing: 10) {
                    RecipeArtwork(recipe: recipe).frame(height: 128)

                    Text(recipe.title)
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)

                    HStack(spacing: 6) {
                        Label("\(recipe.servings)", systemImage: "person.2.fill")

                        if recipe.dietaryAttributes.contains(.vegetarian) {
                            Label("Veg", systemImage: "leaf.fill")
                        }
                    }
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
                }
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.background, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
            .buttonStyle(.plain)

            FavouriteButton(recipeID: recipe.id, isFavourite: isFavourite)
                .padding(10)
        }
        .accessibilityElement(children: .contain)
    }
}
