import Foundation
import SwiftData
import Testing
@testable import ReciMe

struct RecipeSearchTests {
    @Test func filtersRequireEveryIncludedIngredient() {
        var criteria = RecipeSearchCriteria()
        criteria.includedIngredients = ["tomato", "basil"]
        #expect(criteria.matches(Recipe.vegetarianPasta))
        criteria.includedIngredients.append("chicken")
        #expect(!criteria.matches(Recipe.vegetarianPasta))
    }

    @Test func decodesMockAPIEnvelope() throws {
        let payload = """
        {"recipes":[{"id":"one","imageName":"one","title":"One","description":"Test","servings":2,"ingredients":["tomato"],"instructions":["Bake."],"dietaryAttributes":["Vegetarian"]}]}
        """
        let response = try JSONDecoder().decode(RecipeResponse.self, from: Data(payload.utf8))
        #expect(response.recipes.count == 1)
        #expect(response.recipes[0].dietaryAttributes == [.vegetarian])
    }

    @Test func rejectsMalformedEnvelope() {
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(RecipeResponse.self, from: Data("{}".utf8))
        }
    }

    @Test func filtersRejectExcludedIngredientsAndRespectServings() {
        var criteria = RecipeSearchCriteria()
        criteria.excludedIngredients = ["tomato"]
        #expect(!criteria.matches(Recipe.vegetarianPasta))
        criteria.excludedIngredients = []
        criteria.minimumServings = 6
        #expect(!criteria.matches(Recipe.vegetarianPasta))
    }

    @Test func vegetarianAndInstructionSearchAreIndependent() {
        var criteria = RecipeSearchCriteria()
        criteria.vegetarianOnly = true
        criteria.instructionQuery = "simmer"
        #expect(criteria.matches(Recipe.vegetarianPasta))
        criteria.instructionQuery = "roast"
        #expect(!criteria.matches(Recipe.vegetarianPasta))
    }

    @Test func matchIgnoresCaseDiacriticsAndSurroundingSpace() {
        let feijoada = Recipe(
            id: "feijoada",
            imageName: "feijoada",
            title: "Feijoada",
            description: "Feijão preto",
            servings: 8,
            ingredients: ["Feijão", "Pork"],
            instructions: ["Soak the beans overnight."],
            dietaryAttributes: []
        )
        var criteria = RecipeSearchCriteria()
        criteria.query = "  feijao  "
        #expect(criteria.matches(feijoada))
        criteria.query = ""
        criteria.instructionQuery = "  SOAK "
        #expect(criteria.matches(feijoada))
    }

    @Test func combinedFiltersAllHaveToPass() {
        var criteria = RecipeSearchCriteria()
        criteria.vegetarianOnly = true
        criteria.minimumServings = 4
        criteria.includedIngredients = ["basil"]
        criteria.instructionQuery = "simmer"
        #expect(criteria.matches(Recipe.vegetarianPasta))
        criteria.excludedIngredients = ["penne"]
        #expect(!criteria.matches(Recipe.vegetarianPasta))
    }

    @Test func addingATermRemovesItFromTheOtherList() {
        var included: [String] = []
        var excluded = ["Tomato"]
        #expect(RecipeSearchCriteria.addTerm(" tomato ", into: &included, other: &excluded))
        #expect(included == ["tomato"])
        #expect(excluded.isEmpty)
        #expect(!RecipeSearchCriteria.addTerm("tomato", into: &included, other: &excluded))
    }

    @Test func clearingAdvancedFiltersKeepsTheQuery() {
        var criteria = RecipeSearchCriteria()
        criteria.query = "soup"
        criteria.vegetarianOnly = true
        criteria.minimumServings = 4
        let cleared = criteria.clearingAdvancedFilters
        #expect(cleared.query == "soup")
        #expect(!cleared.hasActiveFilters)
    }
}
