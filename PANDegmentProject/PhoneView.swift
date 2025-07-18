import SwiftUI

// MARK: - Models
struct PhoneNumber: Equatable {
    let displayText: String
    let dialNumber: String
    
    var phoneURL: URL? {
        URL(string: "tel:\(dialNumber)")
    }
}

// MARK: - Phone Service
protocol PhoneServiceProtocol {
    func callPhone(url: URL)
}

final class PhoneService: PhoneServiceProtocol {
    func callPhone(url: URL) {
        print("Calling: \(url.absoluteString)")
        UIApplication.shared.open(url)
    }
}

// MARK: - Phone View
struct PhoneView: View {
    private let message: String
    private let phoneNumbers: [PhoneNumber]
    private let phoneService: PhoneServiceProtocol
    
    init(
        message: String,
        phoneNumbers: [PhoneNumber],
        phoneService: PhoneServiceProtocol = PhoneService()
    ) {
        self.message = message
        self.phoneNumbers = phoneNumbers
        self.phoneService = phoneService
    }
    
    var body: some View {
        Text(attributedMessage)
            .font(.body)
            .multilineTextAlignment(.center)
            .onOpenURL(perform: handlePhoneCall)
            .padding(.horizontal)
            .accessibilityLabel("Phone Contact Information")
            .accessibilityIdentifier("phoneViewText")
    }
}

// MARK: - Private Methods
private extension PhoneView {
    var attributedMessage: AttributedString {
        var attributed = AttributedString(message)
        
        for phoneNumber in phoneNumbers {
            if let range = attributed.range(of: phoneNumber.displayText) {
                attributed[range].link = phoneNumber.phoneURL
                attributed[range].foregroundColor = .blue
            }
        }
        
        return attributed
    }
    
    func handlePhoneCall(_ url: URL) {
        guard url.scheme == "tel" else { return }
        phoneService.callPhone(url: url)
    }
}

// MARK: - Preview
#Preview {
    PhoneView(
        message: "Please call at +1 678-702-3368 (toll free) or if you have any other question call me at 771 (YYM).",
        phoneNumbers: [
            PhoneNumber(displayText: "+1 678-702-3368", dialNumber: "+16787023368"),
            PhoneNumber(displayText: "771", dialNumber: "771")
        ]
    )
} 
