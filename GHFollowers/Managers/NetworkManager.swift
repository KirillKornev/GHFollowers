//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Kirill Kornev on 22.10.2022.
//

import UIKit

private extension String {
    static let baseUrl = "https://api.github.com/users/"
}

final class NetworkManager {
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()

    private init() {}

    func getFollowers(for userName: String,
                      page: Int,
                      completion: @escaping (Result<[Follower], GFError>) -> Void) {
        let endPoint: String = .baseUrl + "\(userName)/followers?per_page=100&page=\(page)"

        guard let url = URL(string: endPoint) else { completion(.failure(.invalidUsername)); return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(.success(followers))
            } catch {
                completion(.failure(.invalidData))
            }
        }

        task.resume()
    }
}
