import Foundation
import os

protocol RecipeRepository: Sendable {
    func search(using criteria: RecipeSearchCriteria) async throws -> [Recipe]
}

actor LocalRecipeRepository: RecipeRepository {
    private let bundle: Bundle
    private var cachedRecipes: [Recipe]?

    init(bundle: Bundle = .main) {
        self.bundle = bundle
    }

    func search(using criteria: RecipeSearchCriteria) async throws -> [Recipe] {
        try loadRecipes().filter(criteria.matches)
    }

    private func loadRecipes() throws -> [Recipe] {
        if let cachedRecipes {
            return cachedRecipes
        }

        guard let url = bundle.url(forResource: "Recipes", withExtension: "json") else {
            AppLog.repository.error("Recipes.json is missing from the bundle")
            throw NetworkError.noSuchFile
        }

        do {
            let response = try JSONDecoder().decode(RecipeResponse.self, from: Data(contentsOf: url))
            cachedRecipes = response.recipes
            return response.recipes
        } catch {
            AppLog.repository.error("Could not read recipes: \(error.localizedDescription, privacy: .public)")
            throw error
        }
    }
}

nonisolated enum NetworkError: Error {
    case noSuchFile
}
