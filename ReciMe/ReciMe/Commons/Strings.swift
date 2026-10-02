enum Strings {
    static let cookbook = "Cookbook"
    static let saved = "Saved"
    static let saveRecipe = "Save recipe"
    static let removeFromSaved = "Remove from saved"
    static let filterRecipes = "Filter recipes"
    static let searchRecipes = "Search recipes or ingredients"
    static let openingCookbook = "Opening your cookbook…"
    static let cookbookUnavailable = "Cookbook unavailable"
    static let savedEmptyTitle = "No saved recipes"
    static let savedEmptyDescription = "Tap the heart on a recipe you want to cook again."
    static let cookYourWay = "Cook your way"
    static let cookbookTagline = "A little Brazilian warmth, whenever you need it."
    static let filtered = "Filtered"
    static let serves = "Serves"
    static let vegetarianOnly = "Vegetarian only"
    static let servings = "Servings"
    static let anyNumber = "Any number"
    static let ingredients = "Ingredients"
    static let mustInclude = "Must include"
    static let exclude = "Exclude"
    static let cookingNotes = "Cooking notes"
    static let searchInstructions = "Search instructions"
    static let fineTuneSearch = "Fine-tune your search"
    static let clear = "Clear"
    static let showRecipes = "Show recipes"
    static let method = "Method"
    static let noResultsTitle = "No recipes found"
    static let noResultsDescription = "Try clearing a filter or searching for another ingredient."
    static let dietAndPortions = "Diet and portions"
    static let tomatoExample = "e.g. tomato"
    static let mushroomExample = "e.g. mushroom"
    static let add = "Add"
    static let loadFailed = "We couldn't open your cookbook. Please try again."
    static let tryAgain = "Try again"
    static let clearFilters = "Clear filters"
    static let filtersApplied = "Filters applied"
    static let noFiltersApplied = "No filters applied"
    static let veg = "Veg"
    static let favouritesUnavailable = "Saved recipes unavailable"

    static func serves(_ count: Int) -> String {
        "Serves \(count)"
    }

    static func resultCount(_ count: Int) -> String {
        count == 1 ? "\(count) recipe" : "\(count) recipes"
    }

    static func cookbookSize(_ count: Int) -> String {
        "\(count) recipes to make your own"
    }

    static func remove(_ term: String) -> String {
        "Remove \(term)"
    }

    enum Accessibility {
        static let removeFromSaved = "Remove recipe from saved"
    }
}
