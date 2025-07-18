import SwiftUI

// MARK: - Root View
struct PANRootView: View {
    @StateObject private var memberListViewModel = MemberListViewModel()
    @State private var isShowingMemberList = false
    
    var body: some View {
        VStack(spacing: 24) {
            showMemberListButton
            Spacer()
        }
        .sheet(isPresented: $isShowingMemberList) {
            MemberListView(
                viewModel: memberListViewModel,
                onClose: { isShowingMemberList = false }
            )
        }
    }
}

// MARK: - View Components
private extension PANRootView {
    var showMemberListButton: some View {
        Button(action: showMemberList) {
            HStack {
                Image(systemName: "person.3.fill")
                    .font(.system(size: 16, weight: .medium))
                Text("Show Member List")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            .foregroundColor(.white)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(Color.blue)
            .cornerRadius(8)
        }
        .accessibilityLabel("Show Member List")
        .accessibilityIdentifier("showMemberListButton")
    }
}

// MARK: - Actions
private extension PANRootView {
    func showMemberList() {
        isShowingMemberList = true
    }
}

// MARK: - Preview
#Preview {
    PANRootView()
} 
