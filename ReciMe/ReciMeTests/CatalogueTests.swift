import Foundation
import Testing
@testable import ReciMe

@MainActor
struct CatalogueTests {
    @Test func bundledCatalogueHasUniqueIDsAndImageNames() throws {
        let bundle = Bundle(identifier: "com.danielgx.ReciMe") ?? Bundle.main
        let url = try #require(bundle.url(forResource: "Recipes", withExtension: "json"))
        let response = try JSONDecoder().decode(RecipeResponse.self, from: Data(contentsOf: url))
        let ids = response.recipes.map(\.id)
        let names = response.recipes.map(\.imageName)
        #expect(Set(ids).count == ids.count)
        #expect(names.allSatisfy { !$0.isEmpty })
        #expect(Set(names).count == names.count)
    }

    @Test func missingCatalogueThrows() async {
        let repository = LocalRecipeRepository(bundle: Bundle(for: TestBundleAnchor.self))
        await #expect(throws: NetworkError.self) {
            try await repository.search(using: .init())
        }
    }
}

private final class TestBundleAnchor {}
