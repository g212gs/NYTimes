// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let mostpopular = try? newJSONDecoder().decode(Mostpopular.self, from: jsonData)

import Foundation

// MARK: - Mostpopular
class Mostpopular: Codable, Displayable {
    let status, copyright: String?
    let numResults: Int?
    let results: [Result]?

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults
        case results
    }

    init(status: String?, copyright: String?, numResults: Int?, results: [Result]?) {
        self.status = status
        self.copyright = copyright
        self.numResults = numResults
        self.results = results
    }
}
