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

public struct Humidity {
    public var c: Double // celsius
    public var rh: Double // relative humidity
    public var k: Double  { return c + 273.15 } // kelvin
    public var ah: Double { // absolute humidity g/m3
        return cgkJ * (rh * Pws()) / k
    }
    
    private let cgkJ = 2.16679 // gk/J
    
    private let Tc: Double = 647.096 // K
    private let c1: Double = -7.85951783
    private let c2: Double = 1.84408259
    private let c3: Double = -11.7866497
    private let c4: Double = 22.6807411
    private let c5: Double = -15.9618719
    private let c6: Double = 1.80122502
    private let Pc: Double = 22064000.0 // Pa
    
    private let Tn: Double = 273.16 // K
    private let a0: Double = -13.928169
    private let a1: Double = 34.707823
    private let Pn: Double = 611.657 // Pa
    
    public init(c: Double, rh: Double) {
        self.c = c
        self.rh = rh
    }
    
    private func Pws() -> Double {
        var Pws: Double
        if c > 0.01 { // estimate for 0°C-373°C
            let n = 1 - (k / Tc)
            let p = Tc / k * (c1 * n + c2 * pow(n, 1.5) + c3 * pow(n, 3) + c4 * pow(n, 3.5) + c5 * pow(n, 4) + c6 * pow(n, 7.5))
            let l = pow(M_E, p)
            Pws = Pc * l
        } else { // estimate for -100°C-0.01°C
            let n = k / Tn
            let p = a0 * (1 - pow(n, -1.5)) + a1 * (1 - pow(n, -1.25))
            let l = pow(M_E, p)
            Pws = Pn * l
        }
        return Pws
    }
}
