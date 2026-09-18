import SwiftUI
import SwiftData

struct FlightSearchView: View {

    @Query(
        sort: [
            SortDescriptor(
                \Trip.createdAt,
                order: .reverse
            )
        ]
    )
    private var trips: [Trip]

    @State private var flightSearchViewModel: FlightSearchViewModel
    @State private var fromCitySearch = ""
    @State private var toCitySearch = ""
    @State private var date = Date()

    init() {
        _flightSearchViewModel = State(
            initialValue: FlightSearchViewModel(
                repository: MockFlightRepository()
            )
        )
    }

    var body: some View {
        NavigationStack {
            ZStack {
                AppBackgroundView()

                ScrollView(showsIndicators: false) {
                    VStack(
                        alignment: .leading,
                        spacing: 16
                    ) {
                        VStack(
                            alignment: .leading,
                            spacing: 4
                        ) {
                            Text("Flugsuche")
                                .font(
                                    .system(
                                        size: 34,
                                        weight: .bold,
                                        design: .rounded
                                    )
                                )
                                .foregroundStyle(.white)

                            Text(
                                "Finde den günstigsten Preis für deine Route."
                            )
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.84))
                        }

                        GlassCard {
                            VStack(spacing: 12) {
                                HStack {
                                    Image(
                                        systemName: "airplane.departure"
                                    )
                                    .foregroundStyle(.travelViolet)

                                    TextField(
                                        "Abflugort",
                                        text: $fromCitySearch
                                    )
                                }

                                Divider()

                                HStack {
                                    Image(
                                        systemName: "airplane.arrival"
                                    )
                                    .foregroundStyle(.travelViolet)

                                    TextField(
                                        "Reiseziel",
                                        text: $toCitySearch
                                    )
                                }

                                DatePicker(
                                    "Ergebnisse ab",
                                    selection: $date,
                                    displayedComponents: .date
                                )

                                Button {
                                    flightSearchViewModel.fromCity =
                                        fromCitySearch
                                    flightSearchViewModel.toCity =
                                        toCitySearch
                                    flightSearchViewModel.date = date

                                    Task {
                                        await flightSearchViewModel
                                            .searchFlight()
                                    }
                                } label: {
                                    Label(
                                        "Flüge suchen",
                                        systemImage: "magnifyingglass"
                                    )
                                }
                                .buttonStyle(
                                    TravelButtonStyle(
                                        color: .travelViolet,
                                        foreground: .white
                                    )
                                )
                            }
                        }

                        Text("Die ersten Ergebnisse")
                            .font(.headline)
                            .foregroundStyle(.white)

                        GlassCard(padding: 8) {
                            LazyVStack(spacing: 0) {
                                ForEach(
                                    Array(
                                        flightSearchViewModel.flights
                                            .enumerated()
                                    ),
                                    id: \.element.id
                                ) { index, flight in
                                    HStack {
                                        Image(systemName: "airplane")
                                            .foregroundStyle(.travelViolet)
                                            .frame(
                                                width: 34,
                                                height: 34
                                            )
                                            .background(
                                                .travelViolet.opacity(0.12)
                                            )
                                            .clipShape(Circle())

                                        VStack(
                                            alignment: .leading,
                                            spacing: 4
                                        ) {
                                            Text(
                                                flight.date,
                                                format: .dateTime
                                                    .day()
                                                    .month()
                                                    .year()
                                            )
                                            .font(.subheadline.bold())

                                            Text(
                                                "\(fromCitySearch) → \(toCitySearch)"
                                            )
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        }

                                        Spacer()

                                        Text(
                                            "\(flight.price, specifier: "%.0f") €"
                                        )
                                        .font(.headline)
                                    }
                                    .padding(.vertical, 10)

                                    if index <
                                        flightSearchViewModel.flights.count - 1
                                    {
                                        Divider()
                                    }
                                }
                            }
                        }
                    }
                    .padding(18)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .task {
                if let lastTrip = trips.first {
                    fromCitySearch = lastTrip.fromCity
                    toCitySearch = lastTrip.toCity
                    date = lastTrip.date

                    flightSearchViewModel.fromCity = fromCitySearch
                    flightSearchViewModel.toCity = toCitySearch
                    flightSearchViewModel.date = date

                    await flightSearchViewModel.searchFlight()
                }
            }
        }
    }
}

#Preview {
    FlightSearchView()
        .modelContainer(
            for: Trip.self,
            inMemory: true
        )
}
