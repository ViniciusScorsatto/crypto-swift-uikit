//
//  CryptoRepository.swift
//  crypto-swift-uikit
//
//  Created by Vinicius Scorsatto on 25/07/2024.
//

import Foundation

enum APIEndpoint: String {
    case base = "https://api.coingecko.com/api/v3"
    case coinsMarkets = "/coins/markets"

    var url: URL {
        return URL(string: APIEndpoint.base.rawValue + self.rawValue)!
    }
}

protocol CryptoRepositoryProtocol {
    func fetchCryptocurrencies(completion: @escaping (Result<[Cryptocurrency], Error>) -> Void)
}

class CryptoRepository: CryptoRepositoryProtocol {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchCryptocurrencies(completion: @escaping (Result<[Cryptocurrency], Error>) -> Void) {
            let url = APIEndpoint.coinsMarkets.url
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            urlComponents.queryItems = [
                URLQueryItem(name: "vs_currency", value: "usd")
            ]
            
            networkService.fetchData(from: urlComponents.url!) { result in
                switch result {
                case .success(let data):
                    do {
                        let cryptocurrencies = try JSONDecoder().decode([Cryptocurrency].self, from: data)
                        completion(.success(cryptocurrencies))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
}
