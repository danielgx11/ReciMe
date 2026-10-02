import Foundation

nonisolated struct RecipeSearchCriteria: Equatable, Sendable {
    var query = ""
    var vegetarianOnly = false
    var minimumServings: Int?
    var includedIngredients: [String] = []
    var excludedIngredients: [String] = []
    var instructionQuery = ""

    var hasActiveFilters: Bool {
        vegetarianOnly
            || minimumServings != nil
            || !includedIngredients.isEmpty
            || !excludedIngredients.isEmpty
            || !instructionQuery.isEmpty
    }

    var clearingAdvancedFilters: RecipeSearchCriteria {
        var cleared = RecipeSearchCriteria()
        cleared.query = query
        return cleared
    }

    func matches(_ recipe: Recipe) -> Bool {
        matchesMainQuery(recipe)
            && matchesVegetarian(recipe)
            && matchesServings(recipe)
            && matchesIngredients(recipe)
            && matchesInstructions(recipe)
    }

    static func addTerm(_ raw: String, into terms: inout [String], othersTerms: inout [String]) -> Bool {
        let term = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !term.isEmpty else {
            return false
        }
        guard !terms.contains(where: { $0.localizedCaseInsensitiveCompare(term) == .orderedSame }) else {
            return false
        }

        othersTerms.removeAll { $0.localizedCaseInsensitiveCompare(term) == .orderedSame }
        terms.append(term)
        return true
    }

    // MARK: - Filter Predicates

    private func matchesMainQuery(_ recipe: Recipe) -> Bool {
        let trimmedQuery = query.trimmingCharacters(in: .whitespaces)
        guard !trimmedQuery.isEmpty else {
            return true
        }

        let targetFields = [recipe.title, recipe.description] + recipe.ingredients
        let matches = targetFields.contains {
            $0.localizedStandardContains(trimmedQuery)
        }

        return matches
    }

    private func matchesVegetarian(_ recipe: Recipe) -> Bool {
        !vegetarianOnly || recipe.dietaryAttributes.contains(.vegetarian)
    }

    private func matchesServings(_ recipe: Recipe) -> Bool {
        guard let minServings = minimumServings else {
            return true
        }

        return recipe.servings >= minServings
    }

    private func matchesIngredients(_ recipe: Recipe) -> Bool {
        let includesAll = includedIngredients.allSatisfy { included in
            recipe.ingredients.contains { $0.localizedStandardContains(included) }
        }

        let excludesAll = excludedIngredients.allSatisfy { excluded in
            !recipe.ingredients.contains { $0.localizedStandardContains(excluded) }
        }
        return includesAll && excludesAll
    }

    private func matchesInstructions(_ recipe: Recipe) -> Bool {
        let trimmedQuery = instructionQuery.trimmingCharacters(in: .whitespaces)
        guard !trimmedQuery.isEmpty else {
            return true
        }

        return recipe.instructions.contains { $0.localizedStandardContains(trimmedQuery) }
    }
}
