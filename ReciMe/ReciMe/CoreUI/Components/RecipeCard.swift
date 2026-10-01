import SwiftUI

struct RecipeCard: View {
    let recipe: Recipe

    var body: some View {
        ZStack(alignment: .topTrailing) {
            NavigationLink {
                RecipeDetailView(recipe: recipe)
            } label: {
                VStack(alignment: .leading, spacing: Metrics.spacing12) {
                    RecipeArtwork(recipe: recipe)
                        .frame(height: Metrics.cardArtworkHeight)

                    Text(recipe.title)
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)

                    HStack(spacing: Metrics.spacing8) {
                        Label("\(recipe.servings)", systemImage: Images.people)
                        if recipe.dietaryAttributes.contains(.vegetarian) {
                            Label(Strings.veg, systemImage: Images.leaf)
                        }
                    }
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)

                    Spacer(minLength: 0)
                }
                .padding(Metrics.spacing12)
                .frame(maxWidth: .infinity, alignment: .top)
                .frame(height: Metrics.cardHeight)
                .background(Colors.cardSurface, in: RoundedRectangle(cornerRadius: Metrics.cardCornerRadius, style: .continuous))
            }
            .buttonStyle(.plain)

            FavouriteButton(recipeID: recipe.id)
                .padding(Metrics.spacing12)
        }
        .accessibilityElement(children: .contain)
    }
}
