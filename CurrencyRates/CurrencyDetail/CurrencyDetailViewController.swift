//
//  CurrencyDetailViewController.swift
//  CurrencyRates
//
//  Created by Maksim on 29/04/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

import UIKit

// MARK: - Protocols
protocol CurrencyDetailDisplayLogic: class {
    func presentDisplayDetails(viewModel: CurrencyDetailViewModel)
    func presentDisplayError(error: String)
}

final class CurrencyDetailViewController: UIViewController {

    var interactor: CurrencyDetailBusinessLogic?
    var router: (CurrencyDetailRoutingLogic & CurrencyDetailDataPassing)?
    private var displayDetails = [CurrencyDetailDisplay]()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.register(ObjDetailTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
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
        let interactor = CurrencyDetailInteractor()
        let presenter = CurrencyDetailPresenter()
        let router = CurrencyDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchDetails()
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
    private func fetchDetails() {
        interactor?.fetchDetails()
    }
}

// MARK: - CurrencyDetailDisplayLogic
extension CurrencyDetailViewController: CurrencyDetailDisplayLogic {
    func presentDisplayDetails(viewModel: CurrencyDetailViewModel) {
        displayDetails = viewModel.displayDetails
        tableView.reloadData()
    }
    
    func presentDisplayError(error: String) {
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension CurrencyDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayDetails.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let cell = cell as? ObjDetailTableViewCell {
            cell.titleLabel.text = displayDetails[indexPath.row].title
            cell.subTitleLabel.text = displayDetails[indexPath.row].subTitle
        }
        return cell
    }
}
