import SwiftUI

struct SettingsView: View {

    @AppStorage("darkMode") private var darkMode = false

    @Environment(\.openURL) private var openURL

    @State private var abreiseortTF = ""
    @State private var benutzerdaten = false

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField(
                        "Abreiseort",
                        text: $abreiseortTF
                    )

                    Toggle(
                        "Dunkelmodus",
                        isOn: $darkMode
                    )
                    .tint(.travelViolet)

                    Toggle(
                        "Anonymisierte Daten senden",
                        isOn: $benutzerdaten
                    )
                    .tint(.travelViolet)

                } header: {
                    Label(
                        "Persönliche Einstellungen",
                        systemImage: "person.fill"
                    )

                } footer: {
                    Text("Ihre Benutzerdaten werden anonymisiert verarbeitet, um die Qualität von TravelMate stets verbessern zu können.")
                }

                Section {
                    Button {
                        openURL(
                            URL(string: "https://www.google.de")!
                        )
                    } label: {
                        Label(
                            "Hilfe-Forum",
                            systemImage: "globe"
                        )
                    }

                    Button {
                        openURL(
                            URL(string: "tel:+4912345")!
                        )
                    } label: {
                        Label(
                            "Hotline",
                            systemImage: "phone"
                        )
                    }

                } header: {
                    Label(
                        "Hilfe",
                        systemImage: "questionmark.circle.fill"
                    )

                } footer: {
                    Text(
                        "Unsere Hotline erreichst du Mo–Mi von 9:00–13:30 Uhr."
                    )
                }
            }
            .navigationTitle("Einstellungen")
            .tint(.travelViolet)
        }
    }
}

#Preview {
    SettingsView()
}
