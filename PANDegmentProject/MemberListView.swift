import SwiftUI

struct Member: Identifiable {
    let id: Int
    let name: String
}

class MemberListViewModel: ObservableObject {
    @Published var members: [Member]
    
    init(members: [Member] = [
        Member(id: 1, name: "Pankaj Nigam"),
        Member(id: 2, name: "John Doe"),
        Member(id: 3, name: "Jane Smith")
    ]) {
        self.members = members
    }
}

struct MemberListView: View {
    @StateObject var viewModel: MemberListViewModel
    @Binding var selectedMemberID: Int?
    var onClose: (() -> Void)? = nil
    
    init(viewModel: MemberListViewModel = MemberListViewModel(), selectedMemberID: Binding<Int?> = .constant(nil), onClose: (() -> Void)? = nil) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self._selectedMemberID = selectedMemberID
        self.onClose = onClose
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.members) { member in
                HStack {
                    ZStack {
                        Circle()
                            .fill(Color(.systemGray5))
                            .frame(width: 36, height: 36)
                        Text(String(member.name.prefix(1)))
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                    Text(member.name)
                        .font(.body)
                    Spacer()
                    if selectedMemberID == member.id {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.vertical, 8)
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedMemberID = member.id
                }
                .background(Color.white)
            }
            .listStyle(PlainListStyle())
            .frame(maxWidth: .infinity)
            .navigationTitle("Select Member")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(.lightGray), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if let onClose = onClose {
                        Button(action: { onClose() }) {
                            Text("Close")
                                .foregroundColor(.blue)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 6)
                                .background(Color.white)
                                .cornerRadius(16)
                        }
                        .accessibilityLabel("Close")
                        .accessibilityIdentifier("closeButton")
                    }
                }
            }
        }
        .background(Color.white)
    }
}

#Preview {
    MemberListView()
} 
