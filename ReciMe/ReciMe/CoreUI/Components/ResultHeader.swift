import SwiftUI

struct ResultHeader: View {
    let count: Int
    let criteria: RecipeSearchCriteria

    var body: some View {
        HStack {
            Text(Strings.resultCount(count))
                .font(.headline)
            Spacer()
            if criteria.hasActiveFilters {
                Label(Strings.filtered, systemImage: Images.sliders)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Colors.blueberry)
            }
        }
    }
}
