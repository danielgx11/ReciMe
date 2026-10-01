//
//  File.swift
//  ReciMe
//
//  Created by Daniel Gomes Xavier on 01/10/26.
//


SlowRepository: RecipeRepository {
    func search(using criteria: RecipeSearchCriteria) async throws -> [Recipe] {
        try await Task.sleep(for: .seconds(2))
        return []
    }
}