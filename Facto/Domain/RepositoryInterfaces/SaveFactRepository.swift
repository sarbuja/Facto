import Foundation

protocol SaveFactRepository {
    func saveToFavourites(fact: Fact) throws
}
