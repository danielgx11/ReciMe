import os
import SwiftData
import SwiftUI

@main
struct ReciMeApp: App {
    private let container: ModelContainer?

    init() {
        let inMemory = ProcessInfo.processInfo.arguments.contains("-reset-favourites")
        let schema = Schema([FavouriteRecipe.self])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: inMemory)
        do {
            container = try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            AppLog.repository.error("Favourites store failed: \(error.localizedDescription, privacy: .public)")
            container = nil
        }
    }

    var body: some Scene {
        WindowGroup {
            if let container {
                RecipeRootView()
                    .modelContainer(container)
            } else {
                ContentUnavailableView(
                    Strings.favouritesUnavailable,
                    systemImage: Images.warning,
                    description: Text(Strings.loadFailed)
                )
            }
        }
    }
}
