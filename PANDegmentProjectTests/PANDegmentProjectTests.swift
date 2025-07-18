//
//  PANDegmentProjectTests.swift
//  PANDegmentProjectTests
//
//  Created by pankaj nigam on 7/14/25.
//

import XCTest
@testable import PANDegmentProject
import SwiftUI
//import ViewInspector

final class PANDegmentProjectTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testPANErrorViewRendersWithUnavailableState() {
        let viewModel = PANErrorViewModel(contentState: MemberIDCardUnavailable())
        let view = PANErrorView(viewModel: viewModel)
        _ = view.body // Should not crash
    }

    func testMemberIDCardUnavailableProperties() {
        let unavailable = MemberIDCardUnavailable()
        XCTAssertNotNil(unavailable.title)
        // Add more property checks if needed
    }

    func testPANErrorViewModelProperties() async {
        let contentState = MemberIDCardUnavailable()
        let viewModel = PANErrorViewModel(contentState: contentState)
        XCTAssertEqual(viewModel.title, AppStrings.Titles.cardUnavailable)
        XCTAssertEqual(viewModel.imageName, AppStrings.Icons.house)
        XCTAssertEqual(viewModel.description, AppStrings.Descriptions.cardUnavailable)
        XCTAssertEqual(viewModel.additionalDescription, AppStrings.AdditionalDescriptions.contentA)
        XCTAssertEqual(viewModel.phoneNumbers?.count, 2)
        XCTAssertEqual(viewModel.showRefreshButton, true)
        await viewModel.refreshContent() // Should not throw
    }

    func testPhoneViewRendersWithSampleData() {
        let phoneNumbers = [
            PhoneNumber(displayText: AppStrings.PhoneNumbers.Display.tollFree, dialNumber: AppStrings.PhoneNumbers.Dial.tollFree),
            PhoneNumber(displayText: AppStrings.PhoneNumbers.Display.yym, dialNumber: AppStrings.PhoneNumbers.Dial.yym)
        ]
        let view = PhoneView(
            message: AppStrings.AdditionalDescriptions.contentA,
            phoneNumbers: phoneNumbers
        )
        _ = view.body // Should not crash
    }

    func testPANErrorViewDisplaysContent() {
        let viewModel = PANErrorViewModel(contentState: MemberIDCardUnavailable())
        let view = PANErrorView(viewModel: viewModel)
        // This will not crash if the view can be initialized and body can be accessed
        _ = view.body
        // For more advanced UI testing, use ViewInspector or snapshot tests
    }

    func testPANErrorViewTags() {
        let viewModel = PANErrorViewModel(contentState: MemberIDCardUnavailable())
        let view = PANErrorView(viewModel: viewModel)
        _ = view.body // Should not crash
        
        
        
        // If using ViewInspector, you could do:
     //    let inspected = try view.inspect()
        // XCTAssertNoThrow(try inspected.find(viewWithTag: Constants.textTag1))
        // XCTAssertNoThrow(try inspected.find(viewWithTag: Constants.textTag2))
        // XCTAssertNoThrow(try inspected.find(viewWithTag: Constants.textTag3))
        // XCTAssertNoThrow(try inspected.find(viewWithTag: Constants.textTag4))
        // XCTAssertNoThrow(try inspected.find(viewWithTag: Constants.textTag5))
    }

    func testPhoneViewTextTag() {
        let phoneNumbers = [
            PhoneNumber(displayText: AppStrings.PhoneNumbers.Display.tollFree, dialNumber: AppStrings.PhoneNumbers.Dial.tollFree),
            PhoneNumber(displayText: AppStrings.PhoneNumbers.Display.yym, dialNumber: AppStrings.PhoneNumbers.Dial.yym)
        ]
        let view = PhoneView(
            message: AppStrings.AdditionalDescriptions.contentA,
            phoneNumbers: phoneNumbers
        )
        _ = view.body // Should not crash
        // If using ViewInspector, you could do:
     //    let inspected = try view.inspect()
     //    XCTAssertNoThrow(try inspected.find(viewWithTag: "phoneViewText"))
    }

//    func testPANErrorViewWithAllContentStates() {
//        let allStates: [MemberIDModelContentState] = [
//            MemberIDCardUnavailable(),
//            ImportantMessage(),
//            DoingExperiment(
//                additionalDescription: "Testing additional description",
//                phoneNumbers: [PhoneNumber(displayText: "123", dialNumber: "123")]
//            )
//        ]
//        for state in allStates {
//            let viewModel = PANErrorViewModel(contentState: state)
//            let view = PANErrorView(viewModel: viewModel)
//            _ = view.body // Should not crash
//        }
//    }

    

    func testPANErrorViewWithoutRefreshButton() {
        let state = ImportantMessage() // showRefreshButton = false
        let viewModel = PANErrorViewModel(contentState: state)
        let view = PANErrorView(viewModel: viewModel)
        _ = view.body // Should not crash
    }

    func testPhoneViewWithEmptyPhoneNumbers() {
        let view = PhoneView(
            message: "No phone numbers available",
            phoneNumbers: []
        )
        _ = view.body // Should not crash
    }

    func testPhoneViewWithMultiplePhoneNumbers() {
        let phoneNumbers = [
            PhoneNumber(displayText: "First", dialNumber: "111"),
            PhoneNumber(displayText: "Second", dialNumber: "222"),
            PhoneNumber(displayText: "Third", dialNumber: "333")
        ]
        let view = PhoneView(
            message: "Call First or Second or Third",
            phoneNumbers: phoneNumbers
        )
        _ = view.body // Should not crash
    }

    func testPhoneServiceCallPhone() {
        let phoneService = PhoneService()
        let testURL = URL(string: "tel:+1234567890")!
        // This will print to console but won't actually make a call in test environment
        phoneService.callPhone(url: testURL)
    }

    func testPhoneNumberStruct() {
        let phoneNumber = PhoneNumber(displayText: "Test", dialNumber: "123")
        XCTAssertEqual(phoneNumber.displayText, "Test")
        XCTAssertEqual(phoneNumber.dialNumber, "123")
    }

    func testButtonViewRenders() {
        let view = ButtonView()
        _ = view.body // Should not crash
    }

//    func testAllMemberIDContentStates() {
//        let states: [MemberIDModelContentState] = [
//            MemberIDCardUnavailable(),
//            ImportantMessage(),
//            DoingExperiment(
//                additionalDescription: "Test description",
//                phoneNumbers: [PhoneNumber(displayText: "Test", dialNumber: "123")]
//            )
//        ]
//        
//        for state in states {
//            XCTAssertNotNil(state.imageName)
//            XCTAssertNotNil(state.title)
//            XCTAssertNotNil(state.showRefreshButton)
//            // description, additionalDescription, and phoneNumbers can be nil
//        }
//    }

    func testPANErrorViewModelDefaultInit() {
        let viewModel = PANErrorViewModel() // Uses default MemberIDCardUnavailable
        XCTAssertEqual(viewModel.title, AppStrings.Titles.cardUnavailable)
        XCTAssertEqual(viewModel.imageName, AppStrings.Icons.house)
        XCTAssertNotNil(viewModel.description)
        XCTAssertNotNil(viewModel.additionalDescription)
        XCTAssertNotNil(viewModel.phoneNumbers)
        XCTAssertTrue(viewModel.showRefreshButton)
    }

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

}
