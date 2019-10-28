//
//  ViewController.swift
//  MVC-Example
//
//  Created by Rodrigo Máximo on 27/10/19.
//  Copyright © 2019 Rodrigo Máximo. All rights reserved.
//

import UIKit

final class CountriesListViewController: UIViewController {

    @IBOutlet private weak var segmentedControl: UISegmentedControl?
    @IBOutlet private weak var tableView: UITableView?
    private let refreshControl = UIRefreshControl()

    var router: CountriesListRouterProtocol!
    var presenter: CountriesListPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.reloadCountries()
        setup()
    }

    private func setup() {
        setupSegmentedControl()
        setupRefreshControl()
        setupTableView()
    }

    private func setupSegmentedControl() {
        presenter.segmentedNames().enumerated().forEach { segmentedControl?.setTitle($1, forSegmentAt: $0) }
        segmentedControl?.addTarget(self, action: #selector(didSelectSegmentedControl), for: .valueChanged)
    }

    @objc private func didSelectSegmentedControl() {
        tableView?.reloadData()
    }

    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(didPullRefreshControl), for: .valueChanged)
    }

    @objc private func didPullRefreshControl() {
        presenter.reloadCountries()
    }

    private func setupTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.refreshControl = refreshControl
    }

    @IBAction func orderButtonDidTouch(_ sender: UIButton) {
        guard let selectedIndex = segmentedControl?.selectedSegmentIndex else {
            return
        }
        presenter.orderCountries(accordingTo: selectedIndex)
    }
}

extension CountriesListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectCountry(at: indexPath.row)
        router.presentCountryScene(from: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCountries
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeue(CountriesListTableViewCell.self),
            let segmentedIndex = segmentedControl?.selectedSegmentIndex else
        {
            return UITableViewCell()
        }
        cell.render(viewModel: presenter.viewModelFor(row: indexPath.row, segmentedIndex: segmentedIndex))
        return cell
    }
}

extension CountriesListViewController: CountriesListPresenterDelegate {
    func didReloadCountries() {
        refreshControl.endRefreshing()
        tableView?.reloadData()
    }

    func didOrderCountries() {
        tableView?.reloadData()
    }
}
