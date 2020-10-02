public enum HumidityError: Error {
    case dewPointError(String)
}
public extension HumidityError {
    var localizedDescription: String {
        switch self {
        case .dewPointError(let string):
            return string
        }
    }
}
