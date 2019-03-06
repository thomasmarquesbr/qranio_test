//
//  AsteroidDetail.swift
//  teste-qranio-thomas
//
//  Created by Thomás Marques Brandão Reis on 03/03/19.
//  Copyright © 2019 Thomás Marques Brandão Reis. All rights reserved.
//

import UIKit

class AsteroidDetailVC: UIViewController {
    
    @IBOutlet weak var potenciallyHazardousTextField: UILabel!
    @IBOutlet weak var sentryObjectTextField: UILabel!
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var nameLimitedTextField: UILabel!
    @IBOutlet weak var designationTextField: UILabel!
    @IBOutlet weak var absoluteMagTextField: UILabel!
    @IBOutlet weak var orbitDeterminationDateTextField: UILabel!
    @IBOutlet weak var firstObservationDateTextField: UILabel!
    @IBOutlet weak var lastObservationDate: UILabel!
    @IBOutlet weak var dataArcInDaysTextField: UILabel!
    @IBOutlet weak var observationsUsedTextField: UILabel!
    @IBOutlet weak var orbitUncertainty: UILabel!
    @IBOutlet weak var minOrbitIntersecTextField: UILabel!
    @IBOutlet weak var eccentricityTextField: UILabel!
    @IBOutlet weak var semiMajorAxisTextField: UILabel!
    @IBOutlet weak var inclinationTextField: UILabel!
    @IBOutlet weak var orbitalPeriod: UILabel!
    
    var idAsteroid: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAsteroidDetail()
    }
    
    func loadAsteroidDetail() {
        guard let id = idAsteroid else { return }
        AsteroidsDao().getAsteroidDetail(id) { (asteroidDetail) in
            guard let asteroidDetail = asteroidDetail else {

                return
            }
            self.showInfo(asteroidDetail)
        }
    }
    
    func showInfo(_ asteroidDetail: AsteroidDetail) {
        if let value = asteroidDetail.isPotentiallyHazardousAsteroid {
            self.potenciallyHazardousTextField.text = (value) ? Constants.YES : Constants.NO
        } else {
            self.potenciallyHazardousTextField.text = "-"
        }
        
        if let value = asteroidDetail.isSentryObject {
            self.sentryObjectTextField.text = (value) ? Constants.YES : Constants.NO
        } else {
            self.sentryObjectTextField.text = "-"
        }
        
        self.nameTextField.text = asteroidDetail.name ?? "-"
        self.nameLimitedTextField.text = asteroidDetail.nameLimited ?? "-"
        self.designationTextField.text = asteroidDetail.designation ?? "-"
        self.absoluteMagTextField.text = String(describing: asteroidDetail.absoluteMagnitudeH)
        self.orbitDeterminationDateTextField.text = asteroidDetail.orbitalData?.orbitDeterminationDate ?? "-"
        self.firstObservationDateTextField.text = asteroidDetail.orbitalData?.firstObservationDate ?? "-"
        self.lastObservationDate.text = asteroidDetail.orbitalData?.lastObservationDate ?? "-"
        self.dataArcInDaysTextField.text = asteroidDetail.orbitalData?.dataArcInDays ?? "-"
        self.observationsUsedTextField.text = asteroidDetail.orbitalData?.observationsUsed ?? "-"
        self.orbitUncertainty.text = asteroidDetail.orbitalData?.orbitUncertainty ?? "-"
        self.minOrbitIntersecTextField.text = asteroidDetail.orbitalData?.minOrbitIntersec ?? "-"
        self.eccentricityTextField.text = asteroidDetail.orbitalData?.eccentricity ?? "-"
        self.semiMajorAxisTextField.text = asteroidDetail.orbitalData?.semiMajorAxis ?? "-"
        self.inclinationTextField.text = asteroidDetail.orbitalData?.inclination ?? "-"
        self.orbitalPeriod.text = asteroidDetail.orbitalData?.orbitalPeriod ?? "-"
    }
    
}
