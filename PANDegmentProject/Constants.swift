import Foundation
import SwiftUI

// MARK: - App Strings
struct AppStrings {
    
    // MARK: - Icons
    struct Icons {
        static let house = "house.fill"
        static let person = "person.3.fill"
        static let checkmark = "checkmark"
    }
    
    // MARK: - Titles
    struct Titles {
        static let memberID = "memberID message"
        static let importantMessage = "important message"
        static let cardUnavailable = "card unavailable"
        static let selectMember = "Select Member"
        static let showMemberList = "Show Member List"
    }
    
    // MARK: - Descriptions
    struct Descriptions {
        static let welcome = "Welcome to the alternate content state!"
        static let defaultMessage = "Hi my name is pankaj hope you doing well. You might have lots of questions."
        static let cardUnavailable = "we are sorry bit this feature is not available so how is your day going on hope everythiong is alright please do let me know"
    }
    
    // MARK: - Phone Numbers
    struct PhoneNumbers {
        struct Display {
            static let tollFree = "+1 678-702-3368 (toll free)"
            static let yym = "771 (YYM)"
            static let alt1 = "+1 123-456-7890"
            static let alt2 = "555 (ALT)"
        }
        
        struct Dial {
            static let tollFree = "+16787023368"
            static let yym = "771"
            static let alt1 = "+11234567890"
            static let alt2 = "555"
        }
    }
    
    // MARK: - Additional Descriptions
    struct AdditionalDescriptions {
        static let contentA = "Please call at \(PhoneNumbers.Display.tollFree) or if you have any other question call me at \(PhoneNumbers.Display.yym)."
        static let contentB = "For help, call \(PhoneNumbers.Display.alt1) or \(PhoneNumbers.Display.alt2)."
    }
    
    // MARK: - Accessibility
    struct Accessibility {
        static let phoneContactInfo = "Phone Contact Information"
        static let showMemberList = "Show Member List"
        static let close = "Close"
    }
    
    // MARK: - Identifiers
    struct Identifiers {
        static let phoneViewText = "phoneViewText"
        static let showMemberListButton = "showMemberListButton"
        static let closeButton = "closeButton"
    }
}

// MARK: - App Colors
struct AppColors {
    static let primary = Color.blue
    static let background = Color.white
    static let navigationBar = Color(.lightGray)
    static let avatarBackground = Color(.systemGray5)
}

// MARK: - App Dimensions
struct AppDimensions {
    struct Spacing {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        static let extraLarge: CGFloat = 24
    }
    
    struct CornerRadius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
    }
    
    struct Avatar {
        static let size: CGFloat = 36
    }
} 
