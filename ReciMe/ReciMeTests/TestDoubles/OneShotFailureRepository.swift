@testable import ReciMe

actor OneShotFailureRepository: RecipeRepository {
    private var failed = false

    func search(using criteria: RecipeSearchCriteria) async throws -> [Recipe] {
        if !failed {
            failed = true
            throw NetworkError.noSuchFile
        }
        return []
    }
}
