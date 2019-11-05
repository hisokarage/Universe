//
//  WeatherCell.swift
//  Universe
//
//  Created by Andrey Maksymov on 10/3/19.
//  Copyright © 2019 Andrey Maksymov. All rights reserved.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    func configureCell(withDayWeather dayWeatherVM: DayWeatherViewModel) {
        minTempLabel.text = dayWeatherVM.minTempString
        maxTempLabel.text = dayWeatherVM.maxTempString
        windSpeedLabel.text = dayWeatherVM.windSpeedString
        imageView.sd_setImage(with: dayWeatherVM.iconUrl)
        summaryLabel.text = dayWeatherVM.summary
        dateLabel.text = dayWeatherVM.stringDate
    }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? UIColor(rgb: 0xadd8e6, alpha: 1.0) : .white
        }
    }
}
