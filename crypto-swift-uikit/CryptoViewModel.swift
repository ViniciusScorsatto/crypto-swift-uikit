//
//  CryptoViewModel.swift
//  crypto-swift-uikit
//
//  Created by Vinicius Scorsatto on 25/07/2024.
//

import Foundation

class CryptocurrencyViewModel {
    private let repository: CryptoRepository
    private var cryptocurrencies: [Cryptocurrency] = []
    var onCryptocurrenciesUpdated: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    init(repository: CryptoRepository) {
        self.repository = repository
    }
    
    func loadCryptocurrencies() {
        repository.fetchCryptocurrencies { [weak self] result in
            switch result {
            case .success(let cryptocurrencies):
                self?.cryptocurrencies = cryptocurrencies
                self?.onCryptocurrenciesUpdated?()
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
    
    func getCryptocurrency(at index: Int) -> Cryptocurrency {
        return cryptocurrencies[index]
    }
    
    var count: Int {
        return cryptocurrencies.count
    }
}

