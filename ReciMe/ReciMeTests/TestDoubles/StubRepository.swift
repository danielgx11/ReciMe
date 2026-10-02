@testable import ReciMe

struct StubRepository: RecipeRepository {
    var recipes: [Recipe]

    func search(using criteria: RecipeSearchCriteria) async throws -> [Recipe] {
        recipes.filter(criteria.matches)
    }
}
