import SwiftData
import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    let isFavourite: Bool

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                RecipeArtwork(recipe: recipe)
                    .frame(height: 260)
                    .padding(.horizontal, 16)

                VStack(alignment: .leading, spacing: 12) {
                    Text(recipe.title)
                        .font(.system(.largeTitle, design: .serif, weight: .bold))

                    Text(recipe.description)
                        .foregroundStyle(.secondary)

                    HStack(spacing: 8) {
                        Label("Serves \(recipe.servings)", systemImage: "person.2.fill")

                        ForEach(recipe.dietaryAttributes, id: \.self) { attribute in
                            Label(attribute.rawValue, systemImage: attribute.symbol)
                        }
                    }
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color("Blueberry"))

                    Divider()

                    RecipeSection(title: "Ingredients", symbol: "basket.fill") {
                        ForEach(recipe.ingredients, id: \.self) { ingredient in
                            Label(ingredient, systemImage: "circle")
                                .font(.body)
                                .labelStyle(IngredientLabelStyle())
                        }
                    }

                    RecipeSection(title: "Method", symbol: "list.number") {
                        ForEach(Array(recipe.instructions.enumerated()), id: \.element) { index, instruction in
                            HStack(alignment: .top, spacing: 12) {
                                Text("\(index + 1)")
                                    .font(.caption.bold())
                                    .foregroundStyle(.white)
                                    .frame(width: 25, height: 25)
                                    .background(Color("Blueberry"), in: Circle())

                                Text(instruction)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.vertical, 16)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                FavouriteButton(recipeID: recipe.id, isFavourite: isFavourite)
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
        VStack(alignment: .leading, spacing: 14) {
            Label(title, systemImage: symbol)
                .font(.title3.bold())
                .foregroundStyle(Color("Blueberry"))

            VStack(alignment: .leading, spacing: 14, content: { content })
        }
    }
}
