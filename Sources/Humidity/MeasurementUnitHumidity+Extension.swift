import Foundation

public extension Measurement where UnitType == UnitHumidity {
    private struct DPConstants {
        let m: Double
        let A: Double
        let Tn: Double
    }

    func dewPoint(temperature: Measurement<UnitTemperature>) throws -> Measurement<UnitTemperature> {
        guard let c = сonstants(for: temperature) else {
            throw HumidityError.dewPointError("🚫 Temperature must be in range -70.0...350.0!")
        }
        let Pws = UnitHumidity.pws(temperature: temperature)
        let RH = self.converted(to: .relative(temperature: temperature)).value
        let Pw =  Pws * RH / 100
        let dewPointCelsius = c.Tn / ((c.m / (log10(Pw / c.A))) - 1.0)
        return Measurement<UnitTemperature>(value: dewPointCelsius, unit: .celsius)
    }

    private func сonstants(for temperature: Measurement<UnitTemperature>) -> DPConstants? {
        let celsius = temperature.converted(to: .celsius).value
        switch celsius {
        case -70.0 ..< -20.0:
            return DPConstants(m: 9.778707, A: 6.114742, Tn: 273.1466)
        case -20.0 ..< 50.0:
            return DPConstants(m: 7.591386, A: 6.116441, Tn: 240.7263)
        case 50.0 ..< 100.0:
            return DPConstants(m: 7.337936, A: 6.004918, Tn: 229.3975)
        case 100.0 ..< 150.0:
            return DPConstants(m: 7.27731, A: 5.856548, Tn: 225.1033)
        case 150.0 ..< 200.0:
            return DPConstants(m: 7.290361, A: 6.002859, Tn: 227.1704)
        case 200.0 ..< 350.0:
            return DPConstants(m: 7.388931, A: 9.980622, Tn: 263.1239)
        default:
            return nil
        }
    }
}
