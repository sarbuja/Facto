import XCTest
@testable import Facto

final class LocalStorageTests: XCTestCase {

    var sut: FavouritesLocalStore!

    private func populateStorage() {
        let factOne = Fact(text: "First fact")
        let factTwo = Fact(text: "Second fact")
        sut.storedFacts = [factOne, factTwo]
    }

    override func setUp() {
        sut = FavouritesLocalStore()
        sut.storedFacts = []
    }

    func test_add_fact_to_favourites() {
        XCTAssertEqual(sut.storedFacts!.count, 0)

        let fact = Fact(text: "a test fact")
        try! sut.addFactToFavourites(fact: fact)

        XCTAssertEqual(sut.storedFacts!.count, 1)
        XCTAssertEqual(sut.storedFacts!.first!.text, "a test fact")
    }

    func test_remove_fact_from_favourites() {
        populateStorage()
        XCTAssertEqual(sut.storedFacts!.count, 2)

        try! sut.removeFactFromFavourites(fact: (sut.storedFacts?.first)!)
        XCTAssertEqual(sut.storedFacts!.count, 1)
        XCTAssertEqual(sut.storedFacts!.first!.text, "Second fact")
    }
}
