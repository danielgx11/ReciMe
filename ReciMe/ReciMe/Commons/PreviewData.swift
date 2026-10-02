import SwiftData

enum PreviewData {
    static let recipe = Recipe(
        id: "preview-pudim",
        imageName: "pudim",
        title: "Pudim de Leite",
        description: "Cold caramel custard for a long lunch.",
        servings: 8,
        ingredients: ["Condensed milk", "Eggs", "Sugar"],
        instructions: ["Caramelise the sugar.", "Bake in a water bath until just set."],
        dietaryAttributes: [.vegetarian]
    )

    static let container: ModelContainer = {
        do {
            return try ModelContainer(
                for: FavouriteRecipe.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            )
        } catch {
            fatalError("Preview store failed: \(error)")
        }
    }()
}
