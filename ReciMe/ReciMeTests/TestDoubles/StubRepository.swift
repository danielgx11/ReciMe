//
//  StubRepository.swift
//  ReciMe
//
//  Created by Daniel Gomes Xavier on 01/10/26.
//


struct StubRepository: RecipeRepository {
    var recipes: [Recipe]

    func search(using criteria: RecipeSearchCriteria) async throws -> [Recipe] {
        recipes.filter(criteria.matches)
    }
}