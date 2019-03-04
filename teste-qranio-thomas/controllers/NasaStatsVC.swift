//
//  NasaStatsVC.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 03/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import UIKit

class NasaStatsVC: UIViewController {
    
    @IBOutlet weak var nearEarthObjectCountTextField: UILabel!
    @IBOutlet weak var closeApproachCountTextField: UILabel!
    @IBOutlet weak var lastUpdatedTextField: UILabel!
    @IBOutlet weak var sourceTextField: UILabel!
    @IBOutlet weak var nasaJplUrlTextField: UILabel!
    @IBOutlet weak var datePickerStart: UIDatePicker!
    @IBOutlet weak var datePickerEnd: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDatePickers()
        loadNasaStats()
    }
    
    func initDatePickers() {
        datePickerStart.addTarget(self, action: #selector(datePickerStartValueChanged), for: UIControl.Event.valueChanged)
        datePickerStart.maximumDate = Date()
        datePickerEnd.addTarget(self, action: #selector(datePickerEndValueChanged), for: UIControl.Event.valueChanged)
        datePickerEnd.maximumDate = Date()
    }
    
    @objc func datePickerStartValueChanged (datePicker: UIDatePicker) {
        let date = datePickerStart.date
        guard let maximunDateEnd = Calendar.current.date(byAdding: .day, value: 7, to: date) else { return }
        let order = Calendar.current.compare(maximunDateEnd, to: Date(), toGranularity: .day)
        if order != .orderedDescending {
            datePickerEnd.maximumDate = maximunDateEnd
        }
    }
    
    @objc func datePickerEndValueChanged (datePicker: UIDatePicker) {
        let startDate = datePickerStart.date
        let endDate = datePickerEnd.date
        let order = Calendar.current.compare(startDate, to: endDate, toGranularity: .day)
        if order == .orderedDescending {
            datePickerStart.maximumDate = endDate
            datePickerStart.date = Calendar.current.date(byAdding: .day, value: -7, to: endDate)!
        } else {
            datePickerStart.maximumDate = Date()
        }
    }
    
    func loadNasaStats() {
        AsteroidsDao().getStats { nasaStats in
            guard let nasaStats = nasaStats else { return }
            self.showInfo(nasaStats)
        }
    }
    
    func showInfo(_ nasaStats: NasaStats) {
        self.nearEarthObjectCountTextField.text = String(describing: nasaStats.nearEarthObjectCount)
        self.closeApproachCountTextField.text = String(describing: nasaStats.closeApproachCout)
        self.lastUpdatedTextField.text = nasaStats.lastUpdated
        self.nasaJplUrlTextField.text = nasaStats.nasaJplUrl
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAsteroids" {
            let asteroidsTableVC = segue.destination as! AsteroidsTableVC
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            asteroidsTableVC.startDate = dateFormatter.string(from: datePickerStart.date)
            asteroidsTableVC.endDate = dateFormatter.string(from: datePickerEnd.date)
        }
    }
    
}
