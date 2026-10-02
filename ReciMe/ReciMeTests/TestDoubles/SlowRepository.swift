@testable import ReciMe

actor SlowRepository: RecipeRepository {
    func search(using criteria: RecipeSearchCriteria) async throws -> [Recipe] {
        try await Task.sleep(for: .seconds(2))
        return []
    }
}
