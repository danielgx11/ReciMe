import SwiftUI

struct BrowseView: View {
    let store: RecipeStore
    let favouriteIDs: Set<String>
    @State private var criteria = RecipeSearchCriteria()
    @State private var isShowingFilters = false

    private var results: [Recipe] { store.recipes.filter(criteria.matches) }

    var body: some View {
        NavigationStack {
            Group {
                switch store.state {
                case .idle, .loading:
                    ProgressView("Opening your cookbook…")
                case let .failed(message):
                    ContentUnavailableView("Cookbook unavailable", systemImage: "exclamationmark.triangle", description: Text(message))
                case .loaded:
                    if results.isEmpty {
                        ContentUnavailableView.search(text: criteria.query)
                    } else {
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 20) {
                                RecipesHeader(recipeCount: store.recipes.count)

                                ResultHeader(count: results.count, criteria: criteria)

                                LazyVGrid(columns: [GridItem(.adaptive(minimum: 164), spacing: 14)], spacing: 14) {
                                    ForEach(results) { recipe in
                                        RecipeCard(recipe: recipe, isFavourite: favouriteIDs.contains(recipe.id))
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, 24)
                        }
                        .background(Color(uiColor: .systemGroupedBackground))
                    }
                }
            }
            .navigationTitle("Cookbook")
            .searchable(text: $criteria.query, prompt: "Search recipes or ingredients")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { isShowingFilters = true } label: {
                        Label("Filter recipes", systemImage: criteria.hasActiveFilters ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                    }
                    .accessibilityHint(criteria.hasActiveFilters ? "Filters applied" : "No filters applied")
                }
            }
            .sheet(isPresented: $isShowingFilters) {
                FilterSheet(criteria: $criteria)
            }
        }
    }
}
