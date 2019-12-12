// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let mediaMetadatum = try? newJSONDecoder().decode(MediaMetadatum.self, from: jsonData)

import Foundation

// MARK: - MediaMetadatum
class MediaMetadatum: Codable, Displayable {
    let url: String?
    let format: String?
    let height, width: Int?

    init(url: String?, format: String?, height: Int?, width: Int?) {
        self.url = url
        self.format = format
        self.height = height
        self.width = width
    }
}
