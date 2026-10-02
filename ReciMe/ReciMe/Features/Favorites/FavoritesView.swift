import SwiftData
import SwiftUI

struct FavoritesView: View {
    let recipes: [Recipe]
    let favouriteIDs: Set<String>

    private var savedRecipes: [Recipe] {
        recipes.filter {
            favouriteIDs.contains($0.id)
        }
    }

    var body: some View {
        NavigationStack {
            Group {
                if savedRecipes.isEmpty {
                    ContentUnavailableView(
                        Strings.savedEmptyTitle,
                        systemImage: Images.heart,
                        description: Text(Strings.savedEmptyDescription)
                    )
                } else {
                    ScrollView {
                        LazyVStack(spacing: Metrics.spacing12) {
                            ForEach(savedRecipes) { recipe in
                                RecipeRow(recipe: recipe)
                            }
                        }
                        .padding(Metrics.spacing16)
                    }
                    .background(Color(uiColor: .systemGroupedBackground))
                }
            }
            .navigationTitle(Strings.saved)
        }
    }
}

// MARK: - PREVIEWS

#Preview("Saved empty") {
    FavoritesView(recipes: [], favouriteIDs: [])
}

#Preview("Saved") {
    FavoritesView(recipes: [PreviewData.recipe], favouriteIDs: [PreviewData.recipe.id])
        .modelContainer(PreviewData.container)
}
