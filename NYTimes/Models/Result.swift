// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let result = try? newJSONDecoder().decode(Result.self, from: jsonData)

import Foundation

// MARK: - Result
class Result: Codable, Displayable {
    let url: String?
    let adxKeywords, column, section, byline: String?
    let type, title, abstract, publishedDate: String?
    let source: String?
    let id, assetID, views: Int?
    let desFacet, orgFacet, perFacet, geoFacet: [String]?
    let media: [Media]?

    enum CodingKeys: String, CodingKey {
        case url
        case adxKeywords
        case column, section, byline, type, title, abstract
        case publishedDate = "published_date"
        case source, id
        case assetID
        case views
        case desFacet
        case orgFacet
        case perFacet
        case geoFacet
        case media
    }

    init(url: String?, adxKeywords: String?, column: String?, section: String?, byline: String?, type: String?, title: String?, abstract: String?, publishedDate: String?, source: String?, id: Int?, assetID: Int?, views: Int?, desFacet: [String]?, orgFacet: [String]?, perFacet: [String]?, geoFacet: [String]?, media: [Media]?) {
        self.url = url
        self.adxKeywords = adxKeywords
        self.column = column
        self.section = section
        self.byline = byline
        self.type = type
        self.title = title
        self.abstract = abstract
        self.publishedDate = publishedDate
        self.source = source
        self.id = id
        self.assetID = assetID
        self.views = views
        self.desFacet = desFacet
        self.orgFacet = orgFacet
        self.perFacet = perFacet
        self.geoFacet = geoFacet
        self.media = media
    }
}
