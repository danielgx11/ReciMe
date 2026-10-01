//
//  OneShotFailureRepository.swift
//  ReciMe
//
//  Created by Daniel Gomes Xavier on 01/10/26.
//


actor OneShotFailureRepository: RecipeRepository {
    private var failed = false

    func search(using criteria: RecipeSearchCriteria) async throws -> [Recipe] {
        if !failed {
            failed = true
            throw NetworkError.noSuchFile
        }
        return []
    }
}