//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Kirill Kornev on 22.10.2022.
//

import Foundation

private extension String {
    static let baseUrl = "https://api.github.com/users/"
}

final class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    func getFollowers(for userName: String,
                      page: Int,
                      completion: @escaping ([Follower]?, String?) -> Void) {
        let endPoint: String = .baseUrl + "\(userName)/followers?per_page=100&page=\(page)"

        guard let url = URL(string: endPoint) else { completion(nil, "This userName created an error"); return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error {
                completion(nil, "Please, check your internet connection")
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, "Invalid response")
                return
            }

            guard let data = data else {
                completion(nil, "The data received from the server wes invalid.")
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(followers, nil)
            } catch {
                completion(nil, "The data received from the server wes invalid.")
            }
        }

        task.resume()
    }
}
