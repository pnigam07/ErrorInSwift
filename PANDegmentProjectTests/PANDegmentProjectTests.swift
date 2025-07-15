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

    func testMemberIDViewRendersContent() throws {
        let testData = MemberIDData(
            message: "Test message",
            phoneMessage: "Test phone message",
            phoneNumbers: [
                PhoneNumber(displayText: "+1 111-111-1111", dialNumber: "+11111111111")
            ],
            showRefreshButton: true
        )
        let viewModel = PANErrorViewModel(
            loadContentA: { testData },
            loadContentB: { testData },
            initialState: .contentA(testData)
        )
        let view = PANErrorView(viewModel: viewModel)
        // This will not crash if the view can be initialized and body can be accessed
        _ = view.body
        // For more advanced UI testing, use ViewInspector or snapshot tests
    }
}
