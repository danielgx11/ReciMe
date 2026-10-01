import Observation

@MainActor @Observable
final class RecipeStore {
    private let repository: any RecipeRepository
    private(set) var recipes: [Recipe] = []
    private(set) var state: ViewState = .idle

    init(repository: any RecipeRepository = LocalRecipeRepository()) {
        self.repository = repository
    }

    func load() async {
        guard state == .idle else {
            return
        }

        state = .loading

        do {
            recipes = try await repository.search(using: .init())
            state = .loaded
        } catch {
            state = .failed("We couldn't open your cookbook. Please try again.")
        }
    }
}



