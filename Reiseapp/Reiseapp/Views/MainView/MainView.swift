import SwiftUI
import SwiftData

struct MainView: View {
    
    @Query(sort: [SortDescriptor(\Trip.createdAt, order: .reverse)])
    private var trips: [Trip]
    
    @State private var addNewVacation = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppBackgroundView()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 18) {
                        
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Meine Reisen")
                                    .font(
                                        .system(
                                            size: 34,
                                            weight: .bold,
                                            design: .rounded
                                        )
                                    )
                                    .foregroundStyle(.white)
                                
                                Text("Deine nächsten Abenteuer")
                                    .font(.subheadline)
                                    .foregroundStyle(.white.opacity(0.82))
                            }
                            
                            Spacer()
                            
                            Button {
                                addNewVacation = true
                            } label: {
                                Image(systemName: "plus")
                                    .font(.title2.bold())
                                    .foregroundStyle(.black)
                                    .frame(width: 46, height: 46)
                                    .background(Color.travelSun)
                                    .clipShape(Circle())
                            }
                        }
                        
                        if trips.isEmpty {
                            GlassCard {
                                ContentUnavailableView(
                                    "Noch keine Reisen",
                                    systemImage: "suitcase",
                                    description: Text(
                                        "Lege über das Plus deine erste Reise an."
                                    )
                                )
                            }
                        } else {
                            GlassCard(padding: 8) {
                                LazyVStack(spacing: 0) {
                                    ForEach(
                                        Array(trips.enumerated()),
                                        id: \.element.id
                                    ) { index, trip in
                                        
                                        NavigationLink {
                                            TripDetailView(trip: trip)
                                        } label: {
                                            MainViewCell(trip: trip)
                                        }
                                        .buttonStyle(.plain)
                                        
                                        if index < trips.count - 1 {
                                            Divider()
                                                .padding(.leading, 84)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 18)
                    .padding(.top, 12)
                    .padding(.bottom, 20)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .sheet(isPresented: $addNewVacation) {
                NewTripView()
            }
        }
    }
}

#Preview {
    MainView()
        .modelContainer(for: Trip.self, inMemory: true)
}
