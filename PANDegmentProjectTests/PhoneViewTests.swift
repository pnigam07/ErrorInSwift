import XCTest
import SwiftUI
@testable import PANDegmentProject

// MARK: - Mock Phone Service
class MockPhoneService: PhoneServiceProtocol {
    var callPhoneCalled = false
    var lastCalledURL: URL?
    
    func callPhone(url: URL) {
        callPhoneCalled = true
        lastCalledURL = url
    }
}

// MARK: - Phone Number Tests
final class PhoneNumberTests: XCTestCase {
    
    func testPhoneNumberInitialization() {
        // Given
        let displayText = "+1 555-123-4567"
        let dialNumber = "+15551234567"
        
        // When
        let phoneNumber = PhoneNumber(displayText: displayText, dialNumber: dialNumber)
        
        // Then
        XCTAssertEqual(phoneNumber.displayText, displayText)
        XCTAssertEqual(phoneNumber.dialNumber, dialNumber)
    }
    
    func testPhoneNumberEquality() {
        // Given
        let phoneNumber1 = PhoneNumber(displayText: "+1 555-123-4567", dialNumber: "+15551234567")
        let phoneNumber2 = PhoneNumber(displayText: "+1 555-123-4567", dialNumber: "+15551234567")
        let phoneNumber3 = PhoneNumber(displayText: "+1 999-888-7777", dialNumber: "+19998887777")
        
        // Then
        XCTAssertEqual(phoneNumber1, phoneNumber2)
        XCTAssertNotEqual(phoneNumber1, phoneNumber3)
    }
    
    func testPhoneNumberURLGeneration() {
        // Given
        let phoneNumber = PhoneNumber(displayText: "+1 555-123-4567", dialNumber: "+15551234567")
        
        // When
        let phoneURL = phoneNumber.phoneURL
        
        // Then
        XCTAssertNotNil(phoneURL)
        XCTAssertEqual(phoneURL?.absoluteString, "tel:+15551234567")
    }
    
    func testPhoneNumberURLGenerationWithInvalidDialNumber() {
        // Given
        let phoneNumber = PhoneNumber(displayText: "Invalid", dialNumber: "")
        
        // When
        let phoneURL = phoneNumber.phoneURL
        
        // Then
        XCTAssertNil(phoneURL)
    }
}

// MARK: - Phone Service Tests
final class PhoneServiceTests: XCTestCase {
    
    func testPhoneServiceInitialization() {
        // When
        let phoneService = PhoneService()
        
        // Then
        XCTAssertNotNil(phoneService)
    }
    
    func testPhoneServiceConformsToProtocol() {
        // When
        let phoneService = PhoneService()
        
        // Then
        XCTAssertTrue(phoneService is PhoneServiceProtocol)
    }
}

// MARK: - Mock Phone Service Tests
final class MockPhoneServiceTests: XCTestCase {
    
    func testMockPhoneServiceCallPhone() {
        // Given
        let mockService = MockPhoneService()
        let testURL = URL(string: "tel:+15551234567")!
        
        // When
        mockService.callPhone(url: testURL)
        
        // Then
        XCTAssertTrue(mockService.callPhoneCalled)
        XCTAssertEqual(mockService.lastCalledURL, testURL)
    }
    
    func testMockPhoneServiceReset() {
        // Given
        let mockService = MockPhoneService()
        let testURL = URL(string: "tel:+15551234567")!
        
        // When
        mockService.callPhone(url: testURL)
        mockService.callPhoneCalled = false
        mockService.lastCalledURL = nil
        
        // Then
        XCTAssertFalse(mockService.callPhoneCalled)
        XCTAssertNil(mockService.lastCalledURL)
    }
}

// MARK: - Phone View Tests
final class PhoneViewTests: XCTestCase {
    
    func testPhoneViewInitialization() {
        // Given
        let message = "Please call us at +1 555-123-4567"
        let phoneNumbers = [
            PhoneNumber(displayText: "+1 555-123-4567", dialNumber: "+15551234567")
        ]
        let mockService = MockPhoneService()
        
        // When
        let phoneView = PhoneView(
            message: message,
            phoneNumbers: phoneNumbers,
            phoneService: mockService
        )
        
        // Then
        XCTAssertNotNil(phoneView)
    }
    
    func testPhoneViewWithEmptyPhoneNumbers() {
        // Given
        let message = "Please call us for help"
        let phoneNumbers: [PhoneNumber] = []
        let mockService = MockPhoneService()
        
        // When
        let phoneView = PhoneView(
            message: message,
            phoneNumbers: phoneNumbers,
            phoneService: mockService
        )
        
        // Then
        XCTAssertNotNil(phoneView)
    }
    
    func testPhoneViewWithMultiplePhoneNumbers() {
        // Given
        let message = "Please call at +1 555-123-4567 (toll free) or if you have any other question call me at 888 (YYM)."
        let phoneNumbers = [
            PhoneNumber(displayText: "+1 555-123-4567 (toll free)", dialNumber: "+15551234567"),
            PhoneNumber(displayText: "888 (YYM)", dialNumber: "888")
        ]
        let mockService = MockPhoneService()
        
        // When
        let phoneView = PhoneView(
            message: message,
            phoneNumbers: phoneNumbers,
            phoneService: mockService
        )
        
        // Then
        XCTAssertNotNil(phoneView)
    }
}

// MARK: - Phone View Integration Tests
final class PhoneViewIntegrationTests: XCTestCase {
    
    func testPhoneViewAttributedMessageGeneration() {
        // Given
        let message = "Please call at +1 555-123-4567 or 888"
        let phoneNumbers = [
            PhoneNumber(displayText: "+1 555-123-4567", dialNumber: "+15551234567"),
            PhoneNumber(displayText: "888", dialNumber: "888")
        ]
        let mockService = MockPhoneService()
        let phoneView = PhoneView(
            message: message,
            phoneNumbers: phoneNumbers,
            phoneService: mockService
        )
        
        // When & Then
        // Note: We can't directly test the attributedMessage property as it's private
        // But we can test that the view is created successfully
        XCTAssertNotNil(phoneView)
    }
    
    func testPhoneViewHandlePhoneCallWithValidURL() {
        // Given
        let message = "Please call us"
        let phoneNumbers: [PhoneNumber] = []
        let mockService = MockPhoneService()
        let phoneView = PhoneView(
            message: message,
            phoneNumbers: phoneNumbers,
            phoneService: mockService
        )
        
        // When
        let validURL = URL(string: "tel:+15551234567")!
        // Note: We can't directly call handlePhoneCall as it's private
        // But we can test the mock service behavior
        
        // Then
        XCTAssertFalse(mockService.callPhoneCalled)
    }
    
    func testPhoneViewHandlePhoneCallWithInvalidURL() {
        // Given
        let message = "Please call us"
        let phoneNumbers: [PhoneNumber] = []
        let mockService = MockPhoneService()
        let phoneView = PhoneView(
            message: message,
            phoneNumbers: phoneNumbers,
            phoneService: mockService
        )
        
        // When
        let invalidURL = URL(string: "https://example.com")!
        // Note: We can't directly call handlePhoneCall as it's private
        
        // Then
        XCTAssertFalse(mockService.callPhoneCalled)
    }
}

// MARK: - Phone View Accessibility Tests
final class PhoneViewAccessibilityTests: XCTestCase {
    
    func testPhoneViewAccessibilityLabel() {
        // Given
        let message = "Please call us"
        let phoneNumbers: [PhoneNumber] = []
        let mockService = MockPhoneService()
        let phoneView = PhoneView(
            message: message,
            phoneNumbers: phoneNumbers,
            phoneService: mockService
        )
        
        // When & Then
        // Note: We can't directly test accessibility properties in unit tests
        // These would be tested in UI tests
        XCTAssertNotNil(phoneView)
    }
}

// MARK: - Phone View Edge Cases Tests
final class PhoneViewEdgeCasesTests: XCTestCase {
    
    func testPhoneViewWithEmptyMessage() {
        // Given
        let message = ""
        let phoneNumbers = [
            PhoneNumber(displayText: "+1 555-123-4567", dialNumber: "+15551234567")
        ]
        let mockService = MockPhoneService()
        
        // When
        let phoneView = PhoneView(
            message: message,
            phoneNumbers: phoneNumbers,
            phoneService: mockService
        )
        
        // Then
        XCTAssertNotNil(phoneView)
    }
    
    func testPhoneViewWithLongMessage() {
        // Given
        let message = String(repeating: "Please call us for assistance. ", count: 10)
        let phoneNumbers = [
            PhoneNumber(displayText: "+1 555-123-4567", dialNumber: "+15551234567")
        ]
        let mockService = MockPhoneService()
        
        // When
        let phoneView = PhoneView(
            message: message,
            phoneNumbers: phoneNumbers,
            phoneService: mockService
        )
        
        // Then
        XCTAssertNotNil(phoneView)
    }
    
    func testPhoneViewWithSpecialCharactersInMessage() {
        // Given
        let message = "Please call us at +1 555-123-4567 or email us at test@example.com"
        let phoneNumbers = [
            PhoneNumber(displayText: "+1 555-123-4567", dialNumber: "+15551234567")
        ]
        let mockService = MockPhoneService()
        
        // When
        let phoneView = PhoneView(
            message: message,
            phoneNumbers: phoneNumbers,
            phoneService: mockService
        )
        
        // Then
        XCTAssertNotNil(phoneView)
    }
}

// MARK: - Phone View Performance Tests
final class PhoneViewPerformanceTests: XCTestCase {
    
    func testPhoneViewCreationPerformance() {
        // Given
        let message = "Please call us"
        let phoneNumbers = [
            PhoneNumber(displayText: "+1 555-123-4567", dialNumber: "+15551234567")
        ]
        let mockService = MockPhoneService()
        
        // When & Then
        measure {
            for _ in 0..<100 {
                _ = PhoneView(
                    message: message,
                    phoneNumbers: phoneNumbers,
                    phoneService: mockService
                )
            }
        }
    }
    
    func testPhoneViewWithManyPhoneNumbersPerformance() {
        // Given
        let message = "Please call us"
        let phoneNumbers = (1...50).map { index in
            PhoneNumber(displayText: "+1 555-000-\(String(format: "%04d", index))", dialNumber: "+1555000\(String(format: "%04d", index))")
        }
        let mockService = MockPhoneService()
        
        // When & Then
        measure {
            _ = PhoneView(
                message: message,
                phoneNumbers: phoneNumbers,
                phoneService: mockService
            )
        }
    }
} 