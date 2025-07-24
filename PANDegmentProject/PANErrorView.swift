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

// MARK: - Error Icon Component
struct ErrorIconView: View {
    let imageName: String
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.blue.opacity(0.2))
                .frame(width: 100, height: 100)
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
                .tag(Constants.textTag1)
                .accessibilityLabel("Error Icon")
                .accessibilityIdentifier("errorIconImage")
        }
    }
}

// MARK: - Error Title Component
struct ErrorTitleView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.blue)
            .padding(.top, 8)
            .tag(Constants.textTag2)
            .accessibilityLabel("Error Title")
            .accessibilityIdentifier("errorTitleLabel")
    }
}

// MARK: - Error Description Component
struct ErrorDescriptionView: View {
    let description: String
    
    var body: some View {
        Text(description)
            .font(.body)
            .multilineTextAlignment(.leading)
            .padding(.horizontal)
            .tag(Constants.textTag3)
            .accessibilityLabel("Error Description")
            .accessibilityIdentifier("errorDescriptionLabel")
    }
}

// MARK: - Error Contact Component
struct ErrorContactView: View {
    let additionalDescription: String
    let phoneNumbers: [PhoneNumber]
    
    var body: some View {
        PhoneView(
            message: additionalDescription,
            phoneNumbers: phoneNumbers
        )
        .tag(Constants.textTag4)
        .accessibilityLabel("Phone Contact Information")
        .accessibilityIdentifier("phoneView")
    }
}

// MARK: - Error Refresh Button Component
struct ErrorRefreshButtonView: View {
    let action: () async -> Void
    
    var body: some View {
        Button(action: {
            Task {
                await action()
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
}

// MARK: - Main Error View
struct PANErrorView: View {
    @StateObject var viewModel: PANErrorViewModel

    var body: some View {
        VStack(spacing: 24) {
            // Build Error Icon
            ErrorIconView(imageName: viewModel.imageName)
            
            // Build Error Title
            ErrorTitleView(title: viewModel.title)
            
            // Build Error Description (if available)
            if let description = viewModel.description {
                ErrorDescriptionView(description: description)
            }
            
            // Build Error Contact (if available)
            if let additionalDescription = viewModel.additionalDescription,
               let phoneNumbers = viewModel.phoneNumbers {
                ErrorContactView(
                    additionalDescription: additionalDescription,
                    phoneNumbers: phoneNumbers
                )
            }
            
            // Build Error Refresh Button (if enabled)
            if viewModel.showRefreshButton == true {
                ErrorRefreshButtonView {
                    await viewModel.refreshContent()
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

