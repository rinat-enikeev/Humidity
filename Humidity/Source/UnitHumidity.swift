import Foundation

public final class UnitHumidity: Dimension {
    struct Symbol {
        static let absolute = "g/m³"
        static let relative = "%"
    }

    private struct Constants {
        static let cgkJ = 2.16679 // gk/J
        static let criticalTemperature: Double = 647.096 // K
        static let c1: Double = -7.85951783
        static let c2: Double = 1.84408259
        static let c3: Double = -11.7866497
        static let c4: Double = 22.6807411
        static let c5: Double = -15.9618719
        static let c6: Double = 1.80122502
        static let Pc: Double = 22064000.0 // Pa
        static let Tn: Double = 273.16 // K
        static let a0: Double = -13.928169
        static let a1: Double = 34.707823
        static let Pn: Double = 611.657 // Pa
    }

    private struct Coefficient {
        static let initial: Double = 1.0
    }

    private convenience init(symbol: String, coefficient: Double) {
        self.init(symbol: symbol, converter: UnitConverterLinear(coefficient: coefficient))
    }
    
    public override class func baseUnit() -> UnitHumidity {
        return UnitHumidity(symbol: Symbol.absolute, coefficient: Coefficient.initial)
    }

    public class var absolute: UnitHumidity {
        return UnitHumidity(symbol: Symbol.absolute, coefficient: Coefficient.initial)
    }

    public class func relative(temperature: Measurement<UnitTemperature>) -> UnitHumidity {
        return UnitHumidity(symbol: Symbol.relative, coefficient: coefficent(temperature: temperature))
    }

    private class func coefficent(temperature: Measurement<UnitTemperature>) -> Double {
        return Constants.cgkJ * (pws(temperature: temperature) / temperature.converted(to: .kelvin).value)
    }

    public class func pws(temperature: Measurement<UnitTemperature>) -> Double {
        var pws: Double
        let celsius = temperature.converted(to: .celsius).value
        let kelvin = temperature.converted(to: .kelvin).value
        if celsius > 0.01 { // estimate for 0°C-373°C
            let n = 1 - (kelvin / Constants.criticalTemperature)
            let p = (Constants.criticalTemperature / kelvin) * (Constants.c1 * n + Constants.c2 * pow(n, 1.5) + Constants.c3 * pow(n, 3) + Constants.c4 * pow(n, 3.5) + Constants.c5 * pow(n, 4) + Constants.c6 * pow(n, 7.5))
            let l = pow(M_E, p)
            pws = Constants.Pc * l
        } else { // estimate for -100°C-0.01°C
            let n = kelvin / Constants.Tn
            let p = Constants.a0 * (1 - pow(n, -1.5)) + Constants.a1 * (1 - pow(n, -1.25))
            let l = pow(M_E, p)
            pws = Constants.Pn * l
        }
        return pws
    }
}
