import SwiftUI


struct PhoneView: View {
    let message: String
    let phoneNumbers: [PhoneNumber]
    let phoneService = PhoneService()
    
    var body: some View {
        Text(makeAttributedString())
            .font(.body)
            .multilineTextAlignment(.center)
            .onOpenURL { url in
                if url.scheme == "tel" {
                    phoneService.callPhone(url: url)
                }
            }
            .padding(.horizontal)
            .tag("phoneViewText")
    }
    
    private func makeAttributedString() -> AttributedString {
        var attributed = AttributedString(message)
        for phone in phoneNumbers {
            if let range = attributed.range(of: phone.displayText) {
                attributed[range].link = URL(string: "tel:\(phone.dialNumber)")
                attributed[range].foregroundColor = .blue
            }
        }
        return attributed
    }
}

    //extension PhoneView: Inspectable {}

struct PhoneNumber {
    let displayText: String
    let dialNumber: String
}

class PhoneService {
    func callPhone(url: URL) {
        print("calling \(url.absoluteString)")
        UIApplication.shared.open(url)
        
    }
}

#Preview {
    PhoneView(
        message: "Please call at +1 678-702-3368 (toll free) or if you have any other question call me at 771 (YYM).",
        phoneNumbers: [
            PhoneNumber(displayText: "+1 678-702-3368", dialNumber: "+16787023368"),
            PhoneNumber(displayText: "771", dialNumber: "771")
        ]
    )
} 
