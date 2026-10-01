import SwiftUI

struct ResultHeader: View {
    let count: Int
    let criteria: RecipeSearchCriteria
    var body: some View {
        HStack {
            Text("\(count) \(count == 1 ? "recipe" : "recipes")")
                .font(.headline)
            Spacer()
            if criteria.hasActiveFilters {
                Label("Filtered", systemImage: "slider.horizontal.3")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color("Blueberry"))
            }
        }
    }
}
