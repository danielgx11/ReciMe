import SwiftData
import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Metrics.spacing24) {
                RecipeArtwork(recipe: recipe)
                    .frame(height: Metrics.heroHeight)
                    .padding(.horizontal, Metrics.spacing16)

                VStack(alignment: .leading, spacing: Metrics.spacing12) {
                    Text(recipe.title)
                        .font(.system(.largeTitle, design: .serif, weight: .bold))

                    Text(recipe.description)
                        .foregroundStyle(.secondary)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: Metrics.spacing8) {
                            Label(Strings.serves(recipe.servings), systemImage: Images.people)
                            ForEach(recipe.dietaryAttributes, id: \.self) { attribute in
                                Label(attribute.rawValue, systemImage: attribute.symbol)
                            }
                        }
                    }
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Colors.blueberry)

                    Divider()

                    RecipeSection(title: Strings.ingredients, symbol: Images.basket) {
                        ForEach(recipe.ingredients, id: \.self) { ingredient in
                            Label(ingredient, systemImage: Images.circle)
                                .font(.body)
                                .labelStyle(.ingredient)
                        }
                    }

                    RecipeSection(title: Strings.method, symbol: Images.numberedList) {
                        ForEach(Array(recipe.instructions.enumerated()), id: \.offset) { index, instruction in
                            HStack(alignment: .top, spacing: Metrics.spacing12) {
                                Text("\(index + 1)")
                                    .font(.caption.bold())
                                    .foregroundStyle(Color(uiColor: .systemBackground))
                                    .frame(width: Metrics.spacing24, height: Metrics.spacing24)
                                    .background(Colors.blueberry, in: Circle())

                                Text(instruction)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .accessibilityElement(children: .combine)
                            .accessibilityLabel("\(index + 1). \(instruction)")
                        }
                    }
                }
                .padding(.horizontal, Metrics.spacing20)
            }
            .padding(.vertical, Metrics.spacing16)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                FavouriteButton(recipeID: recipe.id)
            }
        }
    }
}

private struct RecipeSection<Content: View>: View {
    let title: String
    let symbol: String
    private let content: Content

    init(title: String, symbol: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.symbol = symbol
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Metrics.spacing16) {
            Label(title, systemImage: symbol)
                .font(.title3.bold())
                .foregroundStyle(Colors.blueberry)

            VStack(alignment: .leading, spacing: Metrics.spacing16, content: { content })
        }
    }
}

// MARK: - PREVIEW

#Preview("Detail") {
    NavigationStack {
        RecipeDetailView(recipe: PreviewData.recipe)
    }
    .modelContainer(PreviewData.container)
}
