struct FavouriteStoreTests {
    @Test func addsAndRemovesAFavourite() throws {
        let container = try ModelContainer(
            for: FavouriteRecipe.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let context = ModelContext(container)
        let favourite = FavouriteRecipe(recipeID: "pasta")
        context.insert(favourite)
        try context.save()
        #expect(try context.fetchCount(FetchDescriptor<FavouriteRecipe>()) == 1)
        context.delete(favourite)
        try context.save()
        #expect(try context.fetchCount(FetchDescriptor<FavouriteRecipe>()) == 0)
    }
}