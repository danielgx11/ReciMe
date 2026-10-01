import SwiftData
import SwiftUI

struct RecipeRootView: View {
    @State private var viewModel = RecipesViewModel()
    @Query private var favourites: [FavouriteRecipe]

    private var favouriteIDs: Set<String> { Set(favourites.map(\.recipeID)) }

    var body: some View {
        TabView {
            BrowseView(viewModel: viewModel)
                .tabItem {
                    Label(Strings.cookbook, systemImage: Images.cookbook)
                }

            FavoritesView(recipes: viewModel.recipes, favouriteIDs: favouriteIDs)
                .tabItem {
                    Label(Strings.saved, systemImage: Images.filledHeart)
                }
        }
        .tint(Colors.blueberry)
    }
}
