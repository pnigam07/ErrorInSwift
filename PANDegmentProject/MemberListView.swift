import SwiftUI

// MARK: - Models
struct Member: Identifiable, Equatable, Hashable {
    let id: Int
    let name: String
    
    var initials: String {
        String(name.prefix(1)).uppercased()
    }
}

// MARK: - View Model
final class MemberListViewModel: ObservableObject {
    @Published private(set) var members: [Member]
    @Published private(set) var selectedMemberID: Int?
    
    init(members: [Member] = []) {
        self.members = members.isEmpty ? Self.defaultMembers : members
    }
    
    // MARK: - Public Methods
    @MainActor
    func selectMember(_ member: Member) {
        selectedMemberID = member.id
    }
    
    func isSelected(_ member: Member) -> Bool {
        selectedMemberID == member.id
    }
    
    @MainActor
    func clearSelection() {
        selectedMemberID = nil
    }
    
    // MARK: - Private
    private static let defaultMembers = [
        Member(id: 1, name: "Pankaj Nigam"),
        Member(id: 2, name: "John Doe"),
        Member(id: 3, name: "Jane Smith")
    ]
}

// MARK: - Main View
struct MemberListView: View {
    @StateObject private var viewModel: MemberListViewModel
     let onClose: (() -> Void)?
    
    init(
        viewModel: MemberListViewModel = MemberListViewModel(),
        onClose: (() -> Void)? = nil
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.onClose = onClose
    }
    
    var body: some View {
        NavigationView {
            memberListContent
                .navigationBarTitleDisplayMode(.inline)
                .toolbar { toolbarContent }
        }
        .background(AppColors.background)
    }
}

// MARK: - View Components
private extension MemberListView {
    var memberListContent: some View {
        List {
            ForEach(viewModel.members) { member in
                MemberRowView(
                    member: member,
                    isSelected: viewModel.isSelected(member),
                    onTap: { viewModel.selectMember(member) }
                )
            }
        }
        .listStyle(PlainListStyle())
        .frame(maxWidth: .infinity)
        .navigationTitle(AppStrings.Titles.selectMember)
        .toolbarBackground(AppColors.navigationBar, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .accessibilityIdentifier("memberListView.list")
    }
    
    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            if let onClose = onClose {
                CloseButton(action: onClose)
            }
        }
    }
}

// MARK: - Member Row View
struct MemberRowView: View {
    let member: Member
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        HStack(spacing: AppDimensions.Spacing.medium) {
            MemberAvatarView(initials: member.initials)
                .accessibilityIdentifier("memberRow.avatar_\(member.id)")
            
            memberNameText
                .accessibilityIdentifier("memberRow.name_\(member.id)")
            
            Spacer()
            
            selectionIndicator
        }
        .padding(.vertical, AppDimensions.Spacing.small)
        .contentShape(Rectangle())
        .onTapGesture(perform: onTap)
        .background(AppColors.background)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabel)
        .accessibilityIdentifier("memberRow_\(member.id)")
    }
}

// MARK: - Member Row Components
private extension MemberRowView {
    var memberNameText: some View {
        Text(member.name)
            .font(.body)
            .foregroundColor(.primary)
            .lineLimit(1)
    }
    
    @ViewBuilder
    var selectionIndicator: some View {
        if isSelected {
            Image(systemName: AppStrings.Icons.checkmark)
                .foregroundColor(AppColors.primary)
                .font(.system(size: 16, weight: .medium))
                .accessibilityHidden(true)
                .accessibilityIdentifier("memberRow.checkmark_\(member.id)")
        }
    }
    
    var accessibilityLabel: String {
        "\(member.name)\(isSelected ? ", selected" : "")"
    }
}

// MARK: - Member Avatar View
struct MemberAvatarView: View {
    let initials: String
    
    var body: some View {
        ZStack {
            Circle()
                .fill(AppColors.avatarBackground)
                .frame(width: AppDimensions.Avatar.size, height: AppDimensions.Avatar.size)
                .accessibilityIdentifier("memberAvatar.circle")
            
            Text(initials)
                .font(.headline)
                .foregroundColor(AppColors.primary)
                .fontWeight(.semibold)
                .accessibilityIdentifier("memberAvatar.initials")
        }
        .accessibilityHidden(true)
    }
}

// MARK: - Close Button
struct CloseButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: AppDimensions.Spacing.small) {
                Image(systemName: "xmark")
                    .font(.system(size: 14, weight: .medium))
                    .accessibilityIdentifier("closeButton.icon")
                Text(AppStrings.Accessibility.close)
                    .font(.system(size: 16, weight: .medium))
                    .accessibilityIdentifier("closeButton.text")
            }
            .foregroundColor(AppColors.primary)
            .padding(.horizontal, AppDimensions.Spacing.large)
            .padding(.vertical, AppDimensions.Spacing.small)
            .background(AppColors.background)
            .cornerRadius(AppDimensions.CornerRadius.medium)
        }
        .accessibilityLabel(AppStrings.Accessibility.close)
        .accessibilityIdentifier(AppStrings.Identifiers.closeButton)
    }
}

// MARK: - Preview
#Preview {
    MemberListView()
} 
