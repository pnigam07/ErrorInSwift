import SwiftUI

struct PANRootView: View {
    @State private var showMemberList = false
    private let memberListViewModel = MemberListViewModel()
    @State private var selectedMemberID: Int? = nil
    
    var body: some View {
        VStack(spacing: 24) {
            Button(action: {
                showMemberList = true
            }) {
                Text("Show Member List")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Spacer()
        }
        .sheet(isPresented: $showMemberList) {
            MemberListView(viewModel: memberListViewModel, selectedMemberID: $selectedMemberID, onClose: { showMemberList = false })
        }
    }
}

#Preview {
    PANRootView()
} 
