import Foundation
import Observation
import os

@Observable
final class RecipesViewModel {
    private let repository: any RecipeRepository

    private(set) var recipes: [Recipe] = []
    private(set) var results: [Recipe] = []
    private(set) var state: ViewState = .idle

    init(repository: any RecipeRepository = LocalRecipeRepository()) {
        self.repository = repository
    }

    func search(using criteria: RecipeSearchCriteria) async {
        if recipes.isEmpty {
            state = .loading
        }

        do {
            if recipes.isEmpty {
                recipes = try await repository.search(using: .init())
                try Task.checkCancellation()
            }

            if criteria == RecipeSearchCriteria() {
                results = recipes
            } else {
                results = try await repository.search(using: criteria)
                try Task.checkCancellation()
            }

            state = .loaded
        } catch is CancellationError {
            return
        } catch {
            AppLog.repository.error("Recipe load failed: \(error.localizedDescription, privacy: .public)")
            state = .failed(Strings.loadFailed)
        }
    }
}
