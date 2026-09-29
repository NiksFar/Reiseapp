import SwiftUI

private enum ReiseappColors {
    static let violet = Color(red: 0.62, green: 0.18, blue: 0.82)
    static let orchid = Color(red: 0.78, green: 0.38, blue: 0.78)
    static let blush = Color(red: 0.91, green: 0.58, blue: 0.65)
    static let peach = Color(red: 0.97, green: 0.72, blue: 0.48)
    static let sun = Color(red: 1.0, green: 0.78, blue: 0.06)
}

extension Color {
    static let travelViolet = ReiseappColors.violet
    static let travelOrchid = ReiseappColors.orchid
    static let travelSun = ReiseappColors.sun
}

extension ShapeStyle where Self == Color {
    static var travelViolet: Color { Color.travelViolet }
    static var travelOrchid: Color { Color.travelOrchid }
    static var travelSun: Color { Color.travelSun }
}

struct AppBackgroundView: View {
    var body: some View {
        LinearGradient(colors: [ReiseappColors.violet, ReiseappColors.orchid, ReiseappColors.blush, ReiseappColors.peach, ReiseappColors.sun], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
    }
}

struct GlassCard<Content: View>: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    let padding: CGFloat
    @ViewBuilder let content: Content
    init(padding: CGFloat = 18, @ViewBuilder content: () -> Content) {
        self.padding = padding; self.content = content()
    }
    var body: some View { content.padding(padding)
            .background(colorScheme == .dark
                        ? Color(.secondarySystemBackground)
                        : Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
            .shadow(color: .black.opacity(0.12), radius: 18, y: 8)
    }
}

struct TravelButtonStyle: ButtonStyle {
    let color: Color
    let foreground: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.font(.headline).padding(.vertical, 14).frame(maxWidth: .infinity).background(color).foregroundStyle(foreground).clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: .black.opacity(configuration.isPressed ? 0.04 : 0.14),
                    radius: 12, y: 6)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
    }
}

#Preview { AppBackgroundView() }
