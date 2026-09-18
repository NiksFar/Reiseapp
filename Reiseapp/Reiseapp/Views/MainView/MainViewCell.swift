import SwiftUI
import UIKit
import SwiftData

struct MainViewCell: View {

    @Environment(\.modelContext) private var modelContext

    @State private var showDeleteConfirmation = false
    @State private var showEdit = false

    let trip: Trip

    var body: some View {
        HStack(spacing: 14) {

            if let photoData = trip.photoData,
               let uiImage = UIImage(data: photoData) {

                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 62, height: 62)
                    .clipShape(Circle())

            } else {

                Image(systemName: "photo.fill")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .frame(width: 62, height: 62)
                    .background(Color.travelSun)
                    .clipShape(Circle())
            }

            VStack(alignment: .leading, spacing: 5) {

                Text(trip.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(1)

                Text(trip.toCity)
                    .font(.subheadline.italic())
                    .foregroundStyle(.secondary)

                Text(
                    trip.date,
                    format: .dateTime
                        .day()
                        .month()
                        .year()
                )
                .font(.caption)
                .foregroundStyle(.secondary)
            }

            Spacer(minLength: 8)

            Image(systemName: "chevron.right")
                .font(.footnote.bold())
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 13)
        .padding(.horizontal, 12)
        .contentShape(Rectangle())

        .swipeActions(edge: .trailing) {

            Button {
                showDeleteConfirmation = true
            } label: {
                Label("Löschen", systemImage: "trash")
            }
            .tint(.red)

            Button {
                showEdit = true
            } label: {
                Label("Bearbeiten", systemImage: "pencil")
            }
            .tint(Color.travelViolet)
        }

        .confirmationDialog(
            "Reise löschen",
            isPresented: $showDeleteConfirmation,
            titleVisibility: .visible
        ) {
            Button("Löschen", role: .destructive) {
                modelContext.delete(trip)
            }

            Button("Abbrechen", role: .cancel) { }

        } message: {
            Text("Die Reise wird unwiderruflich gelöscht.")
        }

        .contextMenu {

            Button("Bearbeiten", systemImage: "pencil") {
                showEdit = true
            }

            Button(
                "Löschen",
                systemImage: "trash",
                role: .destructive
            ) {
                showDeleteConfirmation = true
            }
        }

        .sheet(isPresented: $showEdit) {
            NewTripView(trip: trip)
        }
    }
}

#Preview {
    MainViewCell(
        trip: Trip(
            title: "Malle ist nur 1 Mal im Jahr",
            fromCity: "Berlin",
            toCity: "Mallorca",
            date: Date(),
            ticketPrice: 149,
            travelers: []
        )
    )
    .padding()
    .modelContainer(
        for: Trip.self,
        inMemory: true
    )
}
