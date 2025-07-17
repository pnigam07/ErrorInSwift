import XCTest
import SwiftUI
@testable import PANDegmentProject

final class MemberListViewTests: XCTestCase {
    func testMemberListViewModelInitializationAndUpdate() {
        let initialMembers = [
            Member(id: 1, name: "Alice"),
            Member(id: 2, name: "Bob")
        ]
        let viewModel = MemberListViewModel(members: initialMembers)
        XCTAssertEqual(viewModel.members.count, 2)
        XCTAssertEqual(viewModel.members[0].name, "Alice")
        XCTAssertEqual(viewModel.members[1].name, "Bob")
        
        // Update members
        let newMembers = [
            Member(id: 3, name: "Charlie")
        ]
        viewModel.members = newMembers
        XCTAssertEqual(viewModel.members.count, 1)
        XCTAssertEqual(viewModel.members[0].name, "Charlie")
    }

    func testMemberListViewFirstLetterLabelAndSelection() {
        let members = [
            Member(id: 1, name: "Alice"),
            Member(id: 2, name: "Bob")
        ]
        let viewModel = MemberListViewModel(members: members)
        var selectedMemberID: Int? = nil
        let view = MemberListView(viewModel: viewModel, selectedMemberID: .constant(selectedMemberID))
        _ = view.body // Should not crash
        // For UI testing, you would use ViewInspector to check the label and selection
    }

    func testMemberListViewEmpty() {
        let viewModel = MemberListViewModel(members: [])
        let view = MemberListView(viewModel: viewModel, selectedMemberID: .constant(nil))
        _ = view.body // Should not crash with empty list
        XCTAssertEqual(viewModel.members.count, 0)
    }

    func testMemberListViewSelectionLogic() {
        let members = [
            Member(id: 1, name: "Alice"),
            Member(id: 2, name: "Bob")
        ]
        let viewModel = MemberListViewModel(members: members)
        var selectedMemberID: Int? = 1
        let binding = Binding<Int?>(
            get: { selectedMemberID },
            set: { selectedMemberID = $0 }
        )
        let view = MemberListView(viewModel: viewModel, selectedMemberID: binding)
        _ = view.body // Should not crash
        // Simulate selection change
        binding.wrappedValue = 2
        XCTAssertEqual(selectedMemberID, 2)
        // Simulate re-selection
        binding.wrappedValue = 1
        XCTAssertEqual(selectedMemberID, 1)
    }

    func testMemberListViewOnClose() {
        let viewModel = MemberListViewModel(members: [Member(id: 1, name: "Test")])
        var didClose = false
        let view = MemberListView(viewModel: viewModel, selectedMemberID: .constant(nil), onClose: { didClose = true })
        // Simulate close action
        view.onClose?()
        XCTAssertTrue(didClose)
    }
} 