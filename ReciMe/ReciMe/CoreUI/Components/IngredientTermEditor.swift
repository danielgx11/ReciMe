//
//  IngredientTermEditor.swift
//  ReciMe
//
//  Created by Daniel Gomes Xavier on 29/09/26.
//


import SwiftUI

struct IngredientTermEditor: View {
    let title: String
    let placeholder: String

    @Binding var terms: [String]
    @Binding var otherTerms: [String]
    @State private var draft = ""

    var body: some View {
        VStack(alignment: .leading, spacing: Metrics.spacing8) {
            Text(title)
                .font(.subheadline.weight(.semibold))

            HStack {
                TextField(placeholder, text: $draft)
                    .textInputAutocapitalization(.never)
                    .onSubmit(add)

                Button(Strings.add, action: add)
                    .disabled(draft.trimmingCharacters(in: .whitespaces).isEmpty)
            }

            if !terms.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(terms, id: \.self) { term in
                            Button {
                                terms.removeAll { $0 == term }
                            } label: {
                                Label(term, systemImage: Images.dismiss)
                            }
                            .buttonStyle(.bordered)
                            .tint(Colors.blueberry)
                            .accessibilityLabel(Strings.remove(term))
                        }
                    }
                }
            }
        }
    }

    private func add() {
        if RecipeSearchCriteria.addTerm(draft, into: &terms, othersTerms: &otherTerms) {
            draft = ""
        }
    }
}
