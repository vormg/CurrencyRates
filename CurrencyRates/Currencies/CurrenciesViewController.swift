//
//  CurrenciesViewController.swift
//  CurrencyRates
//
//  Created by Maksim on 27/04/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

import UIKit

// MARK: - Protocols
protocol CurrenciesDisplayLogic: class {
    func presentDisplayCurrency(viewModel: CurrenciesViewModel)
    func presentDisplayError(error: String)
}

final class CurrenciesViewController: UIViewController {

    var interactor: CurrenciesBusinessLogic?
    var router: (CurrenciesRoutingLogic & CurrenciesDataPassing)?
    private var displayCurrencies = [CurrenciesDisplay]()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView;
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        let viewController = self
        let interactor = CurrenciesInteractor()
        let presenter = CurrenciesPresenter()
        let router = CurrenciesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchCurrencies()
    }

    // MARK: - Setup UI
    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    // MARK: - Fetch
    private func fetchCurrencies() {
        interactor?.fetchItems()
    }
}

// MARK: - CurrenciesDisplayLogic
extension CurrenciesViewController: CurrenciesDisplayLogic {
    func presentDisplayCurrency(viewModel: CurrenciesViewModel) {
        displayCurrencies = viewModel.displayCurrencies
        tableView.reloadData()
    }
    
    func presentDisplayError(error: String) {
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension CurrenciesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayCurrencies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let cell = cell as? DetailTableViewCell {
            cell.titleLabel.text = displayCurrencies[indexPath.row].title
            cell.subTitleLabel.text = displayCurrencies[indexPath.row].subTitle
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CurrenciesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToDetail(index: indexPath.row)
    }
}
