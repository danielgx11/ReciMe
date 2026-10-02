import Foundation
import Testing
@testable import ReciMe

@MainActor
struct RecipesViewModelTests {
    @Test func searchLoadsRecipes() async {
        let viewModel = RecipesViewModel(repository: StubRepository(recipes: [Recipe.vegetarianPasta]))
        await viewModel.search(using: .init())
        #expect(viewModel.state == .loaded)
        #expect(viewModel.recipes == [Recipe.vegetarianPasta])
        #expect(viewModel.results == [Recipe.vegetarianPasta])
    }

    @Test func failedSearchCanBeRetried() async {
        let viewModel = RecipesViewModel(repository: OneShotFailureRepository())
        await viewModel.search(using: .init())
        #expect(viewModel.state == .failed(Strings.loadFailed))
        await viewModel.search(using: .init())
        #expect(viewModel.state == .loaded)
    }

    @Test func cancellationDoesNotFailTheSearch() async {
        let viewModel = RecipesViewModel(repository: SlowRepository())
        let started = Date()
        let task = Task { await viewModel.search(using: .init()) }
        task.cancel()
        await task.value
        #expect(viewModel.state != .failed(Strings.loadFailed))
        #expect(Date().timeIntervalSince(started) < 1)
    }
}

extension Recipe {
    static var vegetarianPasta: Recipe {
        .init(
        id: "pasta",
        imageName: "pasta",
        title: "Tomato Pasta",
        description: "Quick dinner",
        servings: 4,
        ingredients: ["Penne", "Cherry tomatoes", "Basil"],
        instructions: ["Simmer the tomatoes for 10 minutes."],
        dietaryAttributes: [.vegetarian]
    )
    }

}
