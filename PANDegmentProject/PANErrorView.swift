import SwiftUI

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
            }

            Text(viewModel.title)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
                .padding(.top, 8)

            if let description = viewModel.description {
                Text(description)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
            }
            if let additionalDescription = viewModel.additionalDescription, let phoneNumbers = viewModel.phoneNumbers {
                PhoneView(
                    message: additionalDescription,
                    phoneNumbers: phoneNumbers
                )
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
            }
            Spacer()
        }
        .padding()
    }
}

