//
//  RecipesViewModelTests.swift
//  ReciMe
//
//  Created by Daniel Gomes Xavier on 01/10/26.
//


@MainActor
struct RecipesViewModelTests {
    @Test func searchLoadsRecipes() async {
        let viewModel = RecipesViewModel(repository: StubRepository(recipes: [vegetarianPasta]))
        await viewModel.search(using: .init())
        #expect(viewModel.state == .loaded)
        #expect(viewModel.recipes == [vegetarianPasta])
        #expect(viewModel.results == [vegetarianPasta])
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