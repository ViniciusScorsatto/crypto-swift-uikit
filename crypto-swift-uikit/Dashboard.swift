//
//  ViewController.swift
//  crypto-swift-uikit
//
//  Created by Vinicius Scorsatto on 25/07/2024.
//

import UIKit

class Dashboard: UIViewController {
    
    private var viewModel: CryptocurrencyViewModel!
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
                
                viewModel = CryptocurrencyViewModel(repository: CryptoRepository(networkService: NetworkService()))
                setupBindings()
                viewModel.loadCryptocurrencies()
    }
    
    private func setupBindings() {
            viewModel.onCryptocurrenciesUpdated = { [weak self] in
                DispatchQueue.main.async {
                                self?.tableView.reloadData()
                            }
            }
            
            viewModel.onError = { error in
                // Handle error (e.g., show alert)
            }
        }


}

extension Dashboard: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let cryptocurrency = viewModel.getCryptocurrency(at: indexPath.row)
        cell.textLabel?.text = cryptocurrency.name
        cell.detailTextLabel?.text = "$\(cryptocurrency.currentPrice)"
        return cell
    }
}

