//
//  Humidity.swift
//  Humidity
//
//  Created by Rinat Enikeev on 7/16/19.
//  Copyright © 2019 Rinat Enikeev. All rights reserved.
//
//  @see: https://doi.org/10.1063/1.1461829
//

import Foundation

struct Humidity {
    var celsius: Double
    var kelvin: Double
    
    private let Tc: Float80 = 647.096 // K
    private let c1: Float80 = -7.85951783
    private let c2: Float80 = 1.84408259
    private let c3: Float80 = -11.7866497
    private let c4: Float80 = 22.6807411
    private let c5: Float80 = -15.9618719
    private let c6: Float80 = 1.80122502
    private let Pc: Float80 = 220640.0 // hPa
    
    init(celsius: Double) {
        self.celsius = celsius
        self.kelvin = 273.15 + celsius
    }
    
    func Pws_hPa() -> Double {
        let k = Float80(kelvin)
        let n = 1 - (k / Tc)
        let p = Tc / k * (c1 * n + c2 * pow(n, 1.5) + c3 * pow(n, 3) + c4 * pow(n, 3.5) + c5 * pow(n, 4) + c6 * pow(n, 7.5))
        let l = pow(Float80(M_E), p)
        let Pws = Pc * l
        return Double(Pws)
    }
}
