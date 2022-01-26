//
//  PersonDetailResponse.swift
//  tmdb-rx-driver
//
//  Created by Liubov Kovalchuk on 26.01.2022.
//

import Foundation

struct PersonDetailResponse: Decodable {
    let id: Int
    let name: String
    let profileUrl: String?
    let knownAs: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, profileUrl = "profile_path", knownAs = "also_known_as"
    }
}
