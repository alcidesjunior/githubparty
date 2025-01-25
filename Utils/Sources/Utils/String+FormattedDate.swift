import Foundation

public extension String {
    func toFormattedDate() -> String? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withColonSeparatorInTimeZone]
        isoFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale(identifier: "pt_BR")

        guard let date = isoFormatter.date(from: self) else {
            return nil
        }

        return dateFormatter.string(from: date)
}
}
