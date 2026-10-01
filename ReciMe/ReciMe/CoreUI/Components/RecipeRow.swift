import SwiftUI

struct RecipeRow: View {
    let recipe: Recipe

    var body: some View {
        ZStack(alignment: .trailing) {
            NavigationLink {
                RecipeDetailView(recipe: recipe)
            } label: {
                HStack(spacing: Metrics.spacing16) {
                    RecipeArtwork(recipe: recipe)
                        .frame(width: Metrics.artworkThumb, height: Metrics.artworkThumb)

                    VStack(alignment: .leading, spacing: Metrics.spacing8) {
                        Text(recipe.title)
                            .font(.headline)
                            .foregroundStyle(.primary)

                        Text(recipe.description)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(2)

                        Label(Strings.serves(recipe.servings), systemImage: Images.people)
                            .font(.caption2.weight(.semibold))
                            .foregroundStyle(Colors.blueberry)
                    }

                    Spacer(minLength: Metrics.spacing32)
                }
                .padding(Metrics.spacing8)
                .background(Colors.cardSurface, in: RoundedRectangle(cornerRadius: Metrics.cardCornerRadius, style: .continuous))
            }
            .buttonStyle(.plain)

            FavouriteButton(recipeID: recipe.id)
                .padding(Metrics.spacing16)
        }
    }
}
