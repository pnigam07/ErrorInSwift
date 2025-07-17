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
    
    init(viewModel: MemberListViewModel = MemberListViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.members) { member in
                HStack {
                    Text(member.name)
                        .font(.body)
                    Spacer()
                    Text("ID: \(member.id)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Member List")
        }
    }
}

#Preview {
    MemberListView()
} 