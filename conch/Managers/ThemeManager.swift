import SwiftUI

class ThemeManager: ObservableObject {
    @Published var theme: Theme {
        didSet {
            UserDefaults.standard.set(theme.rawValue, forKey: "theme")
        }
    }

    init() {
        let savedTheme = UserDefaults.standard.string(forKey: "theme") ?? Theme.light.rawValue
        self.theme = Theme(rawValue: savedTheme) ?? .light
    }
}

enum Theme: String {
    case light, dark, pink
}
