//
//  NetworkManager.swift
//  Meteo
//
//  Created by Theo Blanchard on 9/13/24.
//

import Foundation

final class NetworkManager<T: Codable> {
    static func fetch(for url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        //reprendre ici (à 26:36)
    }
}

enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case error(err: String)
}
