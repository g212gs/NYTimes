// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let media = try? newJSONDecoder().decode(Media.self, from: jsonData)

import Foundation

// MARK: - Media
class Media: Codable, Displayable {
    let type, subtype, caption, copyright: String?
    let approvedForSyndication: Int?
    let mediaMetadata: [MediaMetadatum]?

    enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright
        case approvedForSyndication
        case mediaMetadata = "media-metadata"
    }

    init(type: String?, subtype: String?, caption: String?, copyright: String?, approvedForSyndication: Int?, mediaMetadata: [MediaMetadatum]?) {
        self.type = type
        self.subtype = subtype
        self.caption = caption
        self.copyright = copyright
        self.approvedForSyndication = approvedForSyndication
        self.mediaMetadata = mediaMetadata
    }
}
