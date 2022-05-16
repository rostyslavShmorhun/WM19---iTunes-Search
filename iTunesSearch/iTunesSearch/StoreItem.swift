//
//  StoreItem.swift
//  iTunesSearch
//
//  Created by Rostyslav Shmorhun on 12.05.2022.
//

import Foundation

struct StoreItem: Codable{
    
    let trackName: String
    let artistName: String
    let kind: String
    let description: String
    let artworkURL: URL
    
    enum CodingKeys: String, CodingKey{
        case trackName
        case artistName
        case kind
        case description
        case artworkURL = "artworkUrl100"
    }
    
    enum AdditionalKeys: String, CodingKey {
        case longDescription
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        trackName = try values.decode(String.self, forKey: CodingKeys.trackName)
        artistName = try values.decode(String.self, forKey: CodingKeys.artistName)
        kind = try values.decode(String.self, forKey: CodingKeys.kind)
        artworkURL = try values.decode(URL.self, forKey:
                                        CodingKeys.artworkURL)
        if let description = try? values.decode(String.self,
                                                forKey: CodingKeys.description) {
            self.description = description
        } else {
            let additionalValues = try decoder.container(keyedBy:
                                                            AdditionalKeys.self)
            description = (try? additionalValues.decode(String.self,
                                                        forKey: AdditionalKeys.longDescription)) ?? ""
        }
    }
}

struct SearchResponse: Codable {
    let results: [StoreItem]
}
