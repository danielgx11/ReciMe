import XCTest

final class ReciMeUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunchShowsCookbook() {
        let app = XCUIApplication()
        app.launchArguments.append("-reset-favourites")
        app.launch()
        XCTAssertTrue(app.navigationBars["Cookbook"].waitForExistence(timeout: 5))
    }

    @MainActor
    func testSaveAndRemoveFavourite() {
        let app = XCUIApplication()
        app.launchArguments.append("-reset-favourites")
        app.launch()

        let save = app.buttons["Save recipe"].firstMatch
        XCTAssertTrue(save.waitForExistence(timeout: 5))
        save.tap()

        app.tabBars.buttons["Saved"].tap()
        XCTAssertTrue(app.staticTexts["Pudim de Leite Condensado"].waitForExistence(timeout: 5))

        app.buttons["Remove recipe from saved"].firstMatch.tap()
        XCTAssertTrue(app.staticTexts["No saved recipes"].waitForExistence(timeout: 5))
    }
}
