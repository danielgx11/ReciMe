import SwiftData
import SwiftUI

struct RecipeRootView: View {
    @State private var viewModel = RecipeStore()
    @Query private var favourites: [FavouriteRecipe]

    private var favouriteIDs: Set<String> { Set(favourites.map(\.recipeID)) }

    var body: some View {
        TabView {
            BrowseView(store: viewModel, favouriteIDs: favouriteIDs)
                .tabItem {
                    Label("Cookbook", systemImage: "book.closed.fill")
                }

            FavoritesView(recipes: viewModel.recipes, favouriteIDs: favouriteIDs)
                .tabItem {
                    Label("Saved", systemImage: Images.filledHeart)
                }
        }
        .tint(Colors.blueberry)
        .task {
            await viewModel.load()
        }
    }
}
