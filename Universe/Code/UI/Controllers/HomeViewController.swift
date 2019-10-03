//
//  HomeViewController.swift
//  Universe
//
//  Created by Andrey Maksymov on 10/3/19.
//  Copyright © 2019 Andrey Maksymov. All rights reserved.
//

import UIKit
import Bond

class HomeViewController: BaseViewController {
    
    private let toWeatherListViewController: String = "toWeatherListViewController"
    private let toWeatherGraphViewController: String = "toWeatherGraphViewController"
    
    private let weatherViewModel = WeatherViewModel()
    
    private weak var graphVC : WeatherGraphViewController?
    private weak var listVC : WeatherListViewController?
    
    private var currentPeriod: PeriodDuration = .days3
    
    @IBOutlet private weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        weatherViewModel.fetch(forPeriod: currentPeriod) // fetch start data
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case toWeatherListViewController:
            listVC = segue.destination as? WeatherListViewController
        case toWeatherGraphViewController:
            graphVC = segue.destination as? WeatherGraphViewController
            graphVC?.delegate = self
        default:
            break
        }
    }
    
// MARK: - Actions
    @IBAction func onSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            currentPeriod = .days5
        case 2:
            currentPeriod = .week
        default:
            currentPeriod = .days3
        }
        
        weatherViewModel.fetch(forPeriod: currentPeriod) // should use endpoints with differenet period but this endpoint doesn't allow to do this
    }
}

// MARK: - Binding
extension HomeViewController {
    func bindViewModel() {
        weatherViewModel.weather.bind(to: self) { (strongSelf, weather) in
            strongSelf.weatherViewModel.showCurrentTemp(onLabel: strongSelf.cityNameLabel)
        }
        
        weatherViewModel.dayWeathers.bind(to: self) { (strongSelf, weathers) in
            strongSelf.listVC?.weathers = weathers
            strongSelf.graphVC?.weathers = weathers
        }
        
        weatherViewModel.error.bind(to: self) { (strongSelf, error) in
            if error != nil {
                let retryAction = UIAlertAction(title: "Retry", style: .destructive) { _ in
                    strongSelf.weatherViewModel.fetch(forPeriod: strongSelf.currentPeriod)
                }
                strongSelf.showAlert(withError: error, orMessage: nil, externalAction: retryAction)
            }
        }
        
        weatherViewModel.isFetching.bind(to: self) { (strongSelf, isLoading) in
            strongSelf.loading = isLoading
        }
    }
}

// MARK: - WeatherGraphViewControllerDelegate
extension HomeViewController: WeatherGraphViewControllerDelegate {
    func selectedIndex(_ index: Int) {
        listVC?.selecteditem = index
    }
}
