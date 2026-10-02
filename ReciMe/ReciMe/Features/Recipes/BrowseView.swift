import SwiftData
import SwiftUI

struct BrowseView: View {
    let viewModel: RecipesViewModel
    @State private var criteria = RecipeSearchCriteria()
    @State private var isShowingFilters = false

    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .idle, .loading:
                    ProgressView(Strings.openingCookbook)
                case let .failed(message):
                    ContentUnavailableView {
                        Label(Strings.cookbookUnavailable, systemImage: Images.warning)
                    } description: {
                        Text(message)
                    } actions: {
                        Button(Strings.tryAgain) {
                            Task { await viewModel.search(using: criteria) }
                        }
                    }
                case .loaded:
                    if viewModel.results.isEmpty {
                        emptyResults
                    } else {
                        recipeGrid
                    }
                }
            }
            .navigationTitle(Strings.cookbook)
            .searchable(text: $criteria.query, prompt: Strings.searchRecipes)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingFilters = true
                    } label: {
                        Label(
                            Strings.filterRecipes,
                            systemImage: criteria.hasActiveFilters ? Images.filledFilter : Images.filter
                        )
                    }
                    .accessibilityHint(criteria.hasActiveFilters ? Strings.filtersApplied : Strings.noFiltersApplied)
                }
            }
            .sheet(isPresented: $isShowingFilters) {
                FilterSheet(criteria: $criteria)
            }
            .task(id: criteria) {
                do {
                    try await Task.sleep(for: .milliseconds(300))
                } catch {
                    return
                }
                await viewModel.search(using: criteria)
            }
        }
    }

    private var emptyResults: some View {
        Group {
            if criteria.hasActiveFilters {
                ContentUnavailableView {
                    Label(Strings.noResultsTitle, systemImage: Images.sliders)
                } description: {
                    Text(Strings.noResultsDescription)
                } actions: {
                    Button(Strings.clearFilters) {
                        criteria = criteria.clearingAdvancedFilters
                    }
                }
            } else {
                ContentUnavailableView.search(text: criteria.query)
            }
        }
    }

    private var recipeGrid: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: Metrics.spacing8) {
                RecipesHeader(recipeCount: viewModel.recipes.count)

                ResultHeader(count: viewModel.results.count, criteria: criteria)
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: Metrics.gridMinimumWidth), spacing: Metrics.spacing8)],
                    spacing: Metrics.spacing16
                ) {
                    ForEach(viewModel.results) { recipe in
                        RecipeCard(recipe: recipe)
                    }
                }
            }
            .padding(.horizontal, Metrics.spacing16)
            .padding(.bottom, Metrics.spacing24)
        }
        .background(Color(uiColor: .systemGroupedBackground))
    }
}

// MARK: - PREVIEWS

#Preview("Browse") {
    BrowseView(viewModel: RecipesViewModel())
        .modelContainer(PreviewData.container)
}

#Preview("No results") {
    BrowseView(viewModel: RecipesViewModel(repository: PreviewEmptyRepository()))
        .modelContainer(PreviewData.container)
}

nonisolated private struct PreviewEmptyRepository: RecipeRepository {
    func search(using criteria: RecipeSearchCriteria) async throws -> [Recipe] { [] }
}
