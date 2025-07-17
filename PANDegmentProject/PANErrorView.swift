import SwiftUI

struct Constants {
    static let textTag1 = "text1"
    static let textTag2 = "text2"
    static let textTag3 = "text3"
    static let textTag4 = "text4"
    static let textTag5 = "text5"
    static let textTag6 = "text6"
    static let textTag7 = "text7"
}


struct PANErrorView: View {
    @StateObject var viewModel: PANErrorViewModel

    var body: some View {
        VStack(spacing: 24) {
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.2))
                    .frame(width: 100, height: 100)
                Image(systemName: viewModel.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.blue)
                    .tag(Constants.textTag1)
                    .accessibilityLabel("Error Icon")
                    .accessibilityIdentifier("errorIconImage")
            }

            Text(viewModel.title)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
                .padding(.top, 8)
                .tag(Constants.textTag2)
                .accessibilityLabel("Error Title")
                .accessibilityIdentifier("errorTitleLabel")

            if let description = viewModel.description {
                Text(description)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .tag(Constants.textTag3)
                    .accessibilityLabel("Error Description")
                    .accessibilityIdentifier("errorDescriptionLabel")
            }
            if let additionalDescription = viewModel.additionalDescription, let phoneNumbers = viewModel.phoneNumbers {
                PhoneView(
                    message: additionalDescription,
                    phoneNumbers: phoneNumbers
                )
                .tag(Constants.textTag4)
                .accessibilityLabel("Phone Contact Information")
                .accessibilityIdentifier("phoneView")
            }
            if viewModel.showRefreshButton ?? false {
                Button(action: {
                    Task {
                        await viewModel.refreshContent()
                        // Refresh action can be handled by parent if needed
                    }
                }) {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 16))
                        Text("Refresh")
                            .font(.caption)
                    }
                        .font(.body)
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .tag(Constants.textTag5)
                .accessibilityLabel("Refresh")
                .accessibilityIdentifier("refreshButton")
            }
            Spacer()
        }
        .padding()
    }
}

