import XCTest
import SwiftUI
@testable import PANDegmentProject
//import ViewInspector
//
//extension MemberListView: Inspectable {}
//extension MemberRowView: Inspectable {}
//extension MemberAvatarView: Inspectable {}
//extension CloseButton: Inspectable {}

final class MemberListViewTests: XCTestCase {
//    func testMemberListViewModel() {
//        let members = [Member(id: 1, name: "Alice"), Member(id: 2, name: "Bob")]
//        let viewModel = MemberListViewModel(members: members)
//        XCTAssertEqual(viewModel.members.count, 2)
//        
//        viewModel.members = [Member(id: 3, name: "Charlie")]
//        XCTAssertEqual(viewModel.members.count, 1)
//        XCTAssertEqual(viewModel.members[0].name, "Charlie")
//    }

    func testMemberListViewRenders() {
        let viewModel = MemberListViewModel(members: [Member(id: 1, name: "Test")])
        let view = MemberListView(viewModel: viewModel)
        _ = view.body // Should not crash
    }

    func testMemberListViewEmpty() {
        let viewModel = MemberListViewModel(members: [])
        let view = MemberListView(viewModel: viewModel)
        _ = view.body // Should not crash
        XCTAssertEqual(viewModel.members.count, 3) // default members
    }

    func testMemberListViewSelection() async {
        let viewModel = MemberListViewModel()
        let member = viewModel.members.first!
        await MainActor.run { viewModel.selectMember(member) }
        XCTAssertTrue(viewModel.isSelected(member))
        await MainActor.run { viewModel.clearSelection() }
        XCTAssertFalse(viewModel.isSelected(member))
    }

    func testMemberListViewOnClose() {
        var didClose = false
        let view = MemberListView(viewModel: MemberListViewModel(), onClose: { didClose = true })
        view.onClose?()
        XCTAssertTrue(didClose)
    }

    func testMemberRowViewSelectionIndicator() {
        let member = Member(id: 1, name: "Test")
        let rowSelected = MemberRowView(member: member, isSelected: true, onTap: {})
        let rowUnselected = MemberRowView(member: member, isSelected: false, onTap: {})
        _ = rowSelected.body
        _ = rowUnselected.body
    }

    func testMemberAvatarView() {
        let avatar = MemberAvatarView(initials: "A")
        _ = avatar.body
    }

    func testCloseButton() {
        var didTap = false
        let button = CloseButton(action: { didTap = true })
        _ = button.body
        button.action()
        XCTAssertTrue(didTap)
    }

    func testMemberInitialsUppercase() {
        let member = Member(id: 1, name: "alice")
        XCTAssertEqual(member.initials, "A")
    }

    func testAccessibilityLabelsAndIdentifiers() {
        let member = Member(id: 1, name: "Test")
        let row = MemberRowView(member: member, isSelected: true, onTap: {})
        XCTAssertTrue(row.accessibilityLabel.contains("Test"))
        XCTAssertTrue(row.accessibilityIdentifier("memberRow_1").contains("memberRow_1"))
        let close = CloseButton(action: {})
        _ = close.body
    }

    func testSelectingNonexistentMember() async {
        let viewModel = MemberListViewModel()
        let nonMember = Member(id: 999, name: "Ghost")
        await MainActor.run { viewModel.selectMember(nonMember) }
        XCTAssertTrue(viewModel.isSelected(nonMember))
        await MainActor.run { viewModel.clearSelection() }
        XCTAssertFalse(viewModel.isSelected(nonMember))
    }

    func testAllAccessibilityIdentifiersPresent() throws {
        let members = [Member(id: 1, name: "Alice"), Member(id: 2, name: "Bob")]
        let view = MemberListView(viewModel: MemberListViewModel(members: members))
        let nav = try view.inspect().navigationView()
        let list = try nav.find(viewWithAccessibilityIdentifier: "memberListView.list")
        XCTAssertNotNil(list)
        for member in members {
            let row = try nav.find(viewWithAccessibilityIdentifier: "memberRow_\(member.id)")
            XCTAssertNotNil(row)
            _ = try row.find(viewWithAccessibilityIdentifier: "memberRow.avatar_\(member.id)")
            _ = try row.find(viewWithAccessibilityIdentifier: "memberRow.name_\(member.id)")
            // Checkmark only for selected
            let viewModel = MemberListViewModel(members: members)
            viewModel.selectMember(member)
            let selectedRow = MemberRowView(member: member, isSelected: true, onTap: {})
            let checkmark = try selectedRow.inspect().find(viewWithAccessibilityIdentifier: "memberRow.checkmark_\(member.id)")
            XCTAssertNotNil(checkmark)
        }
        // Close button
        let close = try nav.find(viewWithAccessibilityIdentifier: AppStrings.Identifiers.closeButton)
        XCTAssertNotNil(close)
        _ = try close.find(viewWithAccessibilityIdentifier: "closeButton.icon")
        _ = try close.find(viewWithAccessibilityIdentifier: "closeButton.text")
    }
} 
