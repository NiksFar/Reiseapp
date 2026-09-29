import SwiftUI

struct LoginView: View {

    @Bindable var loginViewModel: LoginViewModel

    @State private var isSecure = true

    var body: some View {
        ZStack {
            AppBackgroundView()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    Spacer(minLength: 34)

                    VStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(Color.travelViolet)
                                .frame(width: 148, height: 148)

                            Image(systemName: "suitcase.fill")
                                .font(
                                    .system(
                                        size: 68,
                                        weight: .medium
                                    )
                                )
                                .foregroundStyle(Color.travelSun)
                        }
                        .shadow(
                            color: .black.opacity(0.22),
                            radius: 18,
                            y: 10
                        )

                        Text("Reise App")
                            .font(
                                .system(
                                    size: 32,
                                    weight: .bold,
                                    design: .rounded
                                )
                            )
                            .foregroundStyle(.white)

                        Text("Deine nächste Reise beginnt hier.")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.9))
                    }
                    .padding(.bottom, 12)

                    VStack(spacing: 14) {
                        TextField(
                            "E-Mail-Adresse",
                            text: $loginViewModel.email
                        )
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .keyboardType(.emailAddress)
                        .padding(.horizontal, 16)
                        .frame(height: 56)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(
                            RoundedRectangle(cornerRadius: 16)
                        )

                        HStack(spacing: 0) {
                            Group {
                                if isSecure {
                                    SecureField("Passwort", text: $loginViewModel.password)
                                } else {
                                    TextField("Passwort", text: $loginViewModel.password)
                                }
                            }
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .padding(.leading, 16)

                            Button {
                                isSecure.toggle()
                            } label: {
                                Image(
                                    systemName: isSecure
                                        ? "eye.slash.fill"
                                        : "eye.fill"
                                )
                                .padding(16)
                            }
                        }
                        .frame(height: 56)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 16))

                        if let error = loginViewModel.errorMessage {
                            Label(
                                error,
                                systemImage: "exclamationmark.triangle.fill"
                            )
                            .font(.footnote)
                            .foregroundStyle(.red)
                            .padding(.horizontal)
                        }
                    }
                    .padding(.horizontal, 24)

                    HStack(spacing: 12) {
                        Button("Einloggen") {
                            loginViewModel.logIn()
                        }
                        .buttonStyle(
                            TravelButtonStyle(
                                color: Color.travelSun,
                                foreground: .black
                            )
                        )

                        Button("Registrieren") {
                            // Registrierung wird später implementiert
                        }
                        .buttonStyle(
                            TravelButtonStyle(
                                color: Color.travelViolet,
                                foreground: .white
                            )
                        )
                    }
                    .padding(.horizontal, 24)

                    Text("Testzugang: testuser@mail.com · test123")
                        .font(.caption)
                        .foregroundStyle(.black.opacity(0.52))

                    Spacer(minLength: 36)
                }
                .frame(maxWidth: 560)
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    LoginView(
        loginViewModel: LoginViewModel()
    )
}
