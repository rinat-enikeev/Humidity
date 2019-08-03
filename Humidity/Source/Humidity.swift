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
    public var c: Double // celsius °C
    public var rh: Double // relative humidity
    public var k: Double  { return c + 273.15 } // kelvin °K
    public var f: Double { return (c * 9.0/5.0) + 32.0 } // fahrenheit °F
    public var ah: Double { // absolute humidity g/m³
        return cgkJ * (rh * Pws()) / k
    }
    public var Td: Double? { // dew point °C
        guard let m = m(c: c) else { return nil }
        guard let A = A(c: c) else { return nil }
        guard let Tn = Tn(c: c) else { return nil }
        let Pw = Pws() * rh / 100.0
        return Tn / ((m / (log10(Pw / A))) - 1.0)
    }
    public var TdF: Double? { // dew point °F
        guard let Td = Td else { return nil }
        return (Td * 9.0/5.0) + 32.0
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
    
    private func Tn(c: Double) -> Double? {
        switch c {
        case -70.0 ..< -20.0:
            return 273.1466
        case -20.0 ..< 50.0:
            return 240.7263
        case 50.0 ..< 100.0:
            return 229.3975
        case 100.0 ..< 150.0:
            return 225.1033
        case 150.0 ..< 200.0:
            return 227.1704
        case 200.0 ..< 350.0:
            return 263.1239
        default:
            return nil
        }
    }
    
    private func A(c: Double) -> Double? {
        switch c {
        case -70.0 ..< -20.0:
            return 6.114742
        case -20.0 ..< 50.0:
            return 6.116441
        case 50.0 ..< 100.0:
            return 6.004918
        case 100.0 ..< 150.0:
            return 5.856548
        case 150.0 ..< 200.0:
            return 6.002859
        case 200.0 ..< 350.0:
            return 9.980622
        default:
            return nil
        }
    }
    
    private func m(c: Double) -> Double? {
        switch c {
        case -70.0 ..< -20.0:
            return 9.778707
        case -20.0 ..< 50.0:
            return 7.591386
        case 50.0 ..< 100.0:
            return 7.337936
        case 100.0 ..< 150.0:
            return 7.27731
        case 150.0 ..< 200.0:
            return 7.290361
        case 200.0 ..< 350.0:
            return 7.388931
        default:
            return nil
        }
    }
}
