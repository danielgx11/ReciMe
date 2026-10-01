import SwiftUI

struct FavoritesView: View {
    let recipes: [Recipe]
    let favouriteIDs: Set<String>

    private var savedRecipes: [Recipe] { recipes.filter { favouriteIDs.contains($0.id) } }

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
                        LazyVStack(spacing: 12) {
                            ForEach(savedRecipes) { recipe in
                                RecipeRow(recipe: recipe, isFavourite: true)
                            }
                        }
                        .padding(16)
                    }
                    .background(Color(uiColor: .systemGroupedBackground))
                }
            }
            .navigationTitle("Saved")
        }
    }
}
