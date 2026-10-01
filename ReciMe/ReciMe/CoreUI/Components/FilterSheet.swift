import SwiftUI

struct FilterSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Binding private var criteria: RecipeSearchCriteria
    @State private var searchCriteria: RecipeSearchCriteria

    init(criteria: Binding<RecipeSearchCriteria>) {
        _criteria = criteria
        _searchCriteria = State(initialValue: criteria.wrappedValue)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Toggle(Strings.vegetarianOnly, isOn: $searchCriteria.vegetarianOnly)
                        .tint(Colors.lime)

                    Picker(Strings.servings, selection: $searchCriteria.minimumServings) {
                        Text(Strings.anyNumber).tag(Int?.none)
                        ForEach([2, 4, 6, 8, 10], id: \.self) {
                            Text("\(Strings.serves) \($0)+").tag(Optional($0))
                        }
                    }
                } header: {
                    Label(Strings.dietAndPortions, systemImage: Images.forkAndKnife)
                }

                Section {
                    IngredientTermEditor(
                        title: Strings.mustInclude,
                        placeholder: Strings.tomatoExample,
                        terms: $searchCriteria.includedIngredients,
                        otherTerms: $searchCriteria.excludedIngredients
                    )
                    IngredientTermEditor(
                        title: Strings.exclude,
                        placeholder: Strings.mushroomExample,
                        terms: $searchCriteria.excludedIngredients,
                        otherTerms: $searchCriteria.includedIngredients
                    )
                } header: {
                    Label(Strings.ingredients, systemImage: Images.basket)
                }

                Section {
                    TextField(Strings.searchInstructions, text: $searchCriteria.instructionQuery)
                } header: {
                    Label(Strings.cookingNotes, systemImage: Images.numberedList)
                }
            }
            .navigationTitle(Strings.fineTuneSearch)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(Strings.clear) { searchCriteria = .init() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(Strings.showRecipes) {
                        criteria = searchCriteria
                        dismiss()
                    }
                    .tint(Colors.blueberry)
                }
            }
        }
    }
}
