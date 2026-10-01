import SwiftUI

struct RecipeRow: View {
    let recipe: Recipe
    let isFavourite: Bool

    var body: some View {
        ZStack(alignment: .trailing) {
            NavigationLink {
                RecipeDetailView(recipe: recipe, isFavourite: isFavourite)
            } label: {
                HStack(spacing: 14) {
                    RecipeArtwork(recipe: recipe).frame(width: 88, height: 88)

                    VStack(alignment: .leading, spacing: 6) {
                        Text(recipe.title).font(.headline)
                            .foregroundStyle(.primary)

                        Text(recipe.description)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(2)

                        Label("Serves \(recipe.servings)", systemImage: "person.2.fill")
                            .font(.caption2.weight(.semibold))
                            .foregroundStyle(Color("Blueberry"))
                    }

                    Spacer(minLength: 38)

                }
                .padding(10)
                .background(.background, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
            .buttonStyle(.plain)

            FavouriteButton(recipeID: recipe.id, isFavourite: isFavourite)
                .padding(14)
        }
    }
}
