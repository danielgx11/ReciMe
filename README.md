# ReciMe

Offline recipe browser for the ReciMe iOS assessment. Browse a small Brazilian cookbook, search, filter, open a recipe, and save favourites.

## Run

- Clone this repo.
- Go into the root folder.
- Run `make project` in the terminal (Xcode 26 or later).

## Architecture

I chose MVVM so the business logic stays out of the views, the code is easier to test and the concerns stay separated.

I did not split this into packages. The folders are already separated so later each one can become a module, like pieces of a puzzle.

`Recipe` is decoded from `Resources/Recipes.json` through `RecipeRepository`. `LocalRecipeRepository` is the mock API: it reads the file once and filters in memory. A remote client can replace that type without changing the screens.

`RecipesViewModel` owns loading and search. Browse keeps the search field and the filter sheet, then asks the view model to search. Saved reads the full catalogue plus the SwiftData favourite ids.

SwiftData stores only `FavouriteRecipe` (recipe id and date). The recipe text stays in the JSON file. Putting the catalogue in a database would hide the API boundary the brief asks for.

## Search

The brief asks for a search endpoint. That endpoint is `RecipeRepository.search(using:)`, and it is local on purpose.

- The main query matches title, description, and ingredients.
- Included terms must all match. Any excluded term drops the recipe.
- Servings means that many or more.
- Instruction search is separate from the main query.
- Matching ignores case, diacritics, and surrounding whitespace.

Text changes wait 300ms (debounce). A newer search cancels the one still in flight. A failed load can be retried. Failures go to `Logger` (`com.danielgx.ReciMe`, category `repository`). The screen shows a generic message.

## Design

Blueberry, Mango, and Lime are the only brand colors, following the ReciMe DS. Cards share one height. The hero image is sized for the header. The original file was 3632×5456 and decoded to about 76 MB. It is about 500 KB now.

If the favourites store cannot open, the app shows an error instead of crashing.

## Tests

Swift Testing lives in `ReciMeTests`. In Xcode, use Product → Test.

## Limits

Sixteen recipes. No network, pagination, import, meal plan, grocery list, or editing. Favourites stay on the device.

## Privacy

No network, so no keys and no transport setup. No third-party code. Search text is not saved. A favourite is an id and a timestamp.

## Trade offs

- No pagination. There are few recipes for now, but it is something to consider later.
- I chose SwiftData because simple saves were easier for me than Core Data. Core Data is more stable and has more community support.
- No Coordinator. The project has 2 tabs, 1 presented screen and 1 push. I wanted to avoid overengineering.
- No modularization with packages. The folders are already split, so this is easier to do later.

## Tasks

- [x] Setup project
- [x] Adding components
- [x] Add Commons
- [x] Create root view
- [x] Create favorites view
- [x] Create filters sheet
- [x] Implement business logic on Domain
- [x] Assets
- [x] Tests
- [x] Performance improvements
- [ ] Pagination
- [ ] Modularization
- [ ] Add, edit and import recipes
