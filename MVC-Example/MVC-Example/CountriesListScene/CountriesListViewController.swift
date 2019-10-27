//
//  ViewController.swift
//  MVC-Example
//
//  Created by Rodrigo Máximo on 27/10/19.
//  Copyright © 2019 Rodrigo Máximo. All rights reserved.
//

import UIKit

final class CountriesListViewController: UIViewController {

    @IBOutlet private weak var segmentedControl: CountrySegmentedControl?
    @IBOutlet private weak var tableView: UITableView?
    private let refreshControl = UIRefreshControl()

    private var countries: [Country] = CountriesProvider.provide(10)
    private let segueToCountryId = "countrySegue"

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard
            let country = sender as? Country,
            let destinationVC = segue.destination as? CountryViewController else
        {
            return
        }
        destinationVC.country = country
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        setupSegmentedControl()
        setupRefreshControl()
        setupTableView()
    }

    private func setupSegmentedControl() {
        segmentedControl?.addTarget(self, action: #selector(didSelectSegmentedControl), for: .valueChanged)
    }

    @objc private func didSelectSegmentedControl() {
        tableView?.reloadData()
    }

    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(didPullRefreshControl), for: .valueChanged)
    }

    @objc private func didPullRefreshControl() {
        countries = CountriesProvider.provide(10)
        refreshControl.endRefreshing()
        tableView?.reloadData()
    }

    private func setupTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.refreshControl = refreshControl
    }

    @IBAction func orderButtonDidTouch(_ sender: UIButton) {
        if segmentedControl?.selectedType == .some(.name) {
            countries = countries.sorted{ $0.name < $1.name }
        } else {
            countries = countries.sorted{ $0.hdi > $1.hdi }
        }
        tableView?.reloadData()
    }
}

extension CountriesListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueToCountryId, sender: countries[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeue(CountriesListTableViewCell.self) else {
            return UITableViewCell()
        }
        cell.render(viewModel: createCountryViewModel(from: countries[indexPath.row]))
        return cell
    }

    private func createCountryViewModel(from country: Country) -> CountriesListTableViewCell.ViewModel {
        let description = segmentedControl?.selectedType == .some(.name) ? country.name : String(country.hdi)
        return CountriesListTableViewCell.ViewModel(image: UIImage(named: country.name),
                                              description: description)
    }
}
