//
//  WeatherListViewController.swift
//  Universe
//
//  Created by Andrey Maksymov on 10/3/19.
//  Copyright © 2019 Andrey Maksymov. All rights reserved.
//

import UIKit

class WeatherListViewController: UIViewController {
    
    var weathers = [DayWeatherViewModel]() {
        didSet {
            collectionView.reloadData()
            collectionView.setContentOffset(.zero, animated: false)
        }
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var selecteditem : Int? {
        didSet {
            if let selectedItem = selecteditem {
                collectionView.selectItem(at: IndexPath(row: selectedItem, section: 0), animated: true, scrollPosition: .centeredHorizontally)
            }
        }
    }
}

extension WeatherListViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        
        weathers[indexPath.row].configureCell(cell)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true) // show cell if user tapped on side cell on big screens
    }
}
