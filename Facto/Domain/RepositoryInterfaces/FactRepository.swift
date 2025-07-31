protocol FactRepository {
    func getFact() async throws -> Fact
    func deleteFavourite(fact: Fact) throws
    func saveToFavourites(fact: Fact) throws
}
