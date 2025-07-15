//
//  PANDegmentProjectTests.swift
//  PANDegmentProjectTests
//
//  Created by pankaj nigam on 7/14/25.
//

import XCTest
@testable import PANDegmentProject
import SwiftUI

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

    func testPANErrorViewModelProperties() async {
        let contentState = MemberIDCardUnavailable()
        let viewModel = PANErrorViewModel(contentState: contentState)
        XCTAssertEqual(viewModel.title, contentState.title)
        XCTAssertEqual(viewModel.imageName, contentState.imageName)
        XCTAssertEqual(viewModel.description, contentState.description)
        XCTAssertEqual(viewModel.additionalDescription, contentState.additionalDescription)
        XCTAssertEqual(viewModel.phoneNumbers?.count, contentState.phoneNumbers?.count)
        XCTAssertEqual(viewModel.showRefreshButton, contentState.showRefreshButton)
        await viewModel.refreshContent() // Should not throw
    }

    func testPANErrorViewModelWithAllContentStates() async {
        let allStates: [MemberIDModelContentState] = [
            MemberIDCardUnavailable(),
            ImportantMessage(),
            DoingExperiment(
                additionalDescription: "Testing additional description",
                phoneNumbers: [PhoneNumber(displayText: "123", dialNumber: "123")]
            )
        ]
        for state in allStates {
            let viewModel = PANErrorViewModel(contentState: state)
            XCTAssertEqual(viewModel.title, state.title)
            XCTAssertEqual(viewModel.imageName, state.imageName)
            XCTAssertEqual(viewModel.description, state.description)
            XCTAssertEqual(viewModel.additionalDescription, state.additionalDescription)
            XCTAssertEqual(viewModel.phoneNumbers?.count, state.phoneNumbers?.count)
            XCTAssertEqual(viewModel.showRefreshButton, state.showRefreshButton)
            await viewModel.refreshContent() // Should not throw
        }
    }

    func testPhoneViewRendersWithSampleData() {
        let phoneNumbers = [
            PhoneNumber(displayText: "+1 678-702-3368", dialNumber: "+16787023368"),
            PhoneNumber(displayText: "771", dialNumber: "771")
        ]
        let view = PhoneView(
            message: "Please call at +1 678-702-3368 (toll free) or if you have any other question call me at 771 (YYM).",
            phoneNumbers: phoneNumbers
        )
        _ = view.body // Should not crash
    }

}
