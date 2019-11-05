//
//  WeatherGraphViewController.swift
//  Universe
//
//  Created by Andrey Maksymov on 10/3/19.
//  Copyright © 2019 Andrey Maksymov. All rights reserved.
//

import Foundation
import UIKit
import GraphKit

protocol WeatherGraphViewControllerDelegate: class {
    func selectedIndex(_ index: Int)
}

class WeatherGraphViewController: UIViewController {
    
    private let kAxisMargin: CGFloat = 100.0;
    
    private var temps = [[Int]]()
    private var dates = [String]()
    
    weak var delegate: WeatherGraphViewControllerDelegate?
    
    var weathers = [DayWeatherViewModel]() {
        didSet {
            temps =  [weathers.map { $0.maxTemp }, weathers.map { $0.minTemp }]
            dates = weathers.map { $0.stringDate }
            graphView.lineWidth = 6
            graphView.reset()
            if weathers.count > 0 { graphView.draw() }
        }
    }
    
    @IBOutlet private weak var graphView: GKLineGraph!
    @IBOutlet private var gesture: UITapGestureRecognizer!
    
    @IBAction private func handleTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: graphView)
        let width = graphView.bounds.size.width
        
        if let firstLabel = graphView.subviews.first as? UILabel, let lastLabel = graphView.subviews.last as? UILabel { // gets date labels positions to find margins
            let leftMargin = firstLabel.frame.origin.x
            let rightMargin = width - (lastLabel.frame.origin.x + lastLabel.frame.size.width)
            let sectorWidth = (width - (leftMargin + rightMargin)) / CGFloat(weathers.count)
            
            let index = Int(roundf(Float(location.x / sectorWidth)))
            
            if index != 0 && index - 1 < weathers.count { // miss indexes that can be placed on margins
                delegate?.selectedIndex(index - 1)
            }
        }
    }
}

extension WeatherGraphViewController : GKLineGraphDataSource {
    func numberOfLines() -> Int {
        return temps.count
    }
    
    func colorForLine(at index: Int) -> UIColor {
        let colors = [UIColor(rgb: 0xF30C12, alpha: 1.0), UIColor.gk_midnightBlue()]
        
        if let color = colors[index] {
            return color
        }
        
        return UIColor.gk_midnightBlue()
    }
    
    func valuesForLine(at index: Int) -> [Any] {
        return temps[index]
    }
    
    func titleForLine(at index: Int) -> String {
        return dates[index]
    }
}
