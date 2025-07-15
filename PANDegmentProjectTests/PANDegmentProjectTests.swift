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
        XCTAssertEqual(viewModel.title, AppStrings.cardUnavailableTitle)
        XCTAssertEqual(viewModel.imageName, AppStrings.houseImage)
        XCTAssertEqual(viewModel.description, AppStrings.cardUnavailableDescription)
        XCTAssertEqual(viewModel.additionalDescription, AppStrings.additionalDescriptionA + " ")
        XCTAssertEqual(viewModel.phoneNumbers?.count, 2)
        XCTAssertEqual(viewModel.showRefreshButton, true)
        await viewModel.refreshContent() // Should not throw
    }

    func testPhoneViewRendersWithSampleData() {
        let phoneNumbers = [
            PhoneNumber(displayText: AppStrings.phoneNumber1Display, dialNumber: AppStrings.phoneNumber1Dial),
            PhoneNumber(displayText: AppStrings.phoneNumber2Display, dialNumber: AppStrings.phoneNumber2Dial)
        ]
        let view = PhoneView(
            message: AppStrings.additionalDescriptionA,
            phoneNumbers: phoneNumbers
        )
        _ = view.body // Should not crash
    }

}
