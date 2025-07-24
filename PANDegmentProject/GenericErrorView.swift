import SwiftUI

// MARK: - Error View Configuration
struct ErrorViewConfiguration {
    let iconName: String
    let title: String
    let description: String?
    let additionalDescription: String?
    let phoneNumbers: [PhoneNumber]?
    let showRefreshButton: Bool
    let refreshAction: (() async -> Void)?
    let iconSize: CGFloat
    let iconBackgroundColor: Color
    let iconColor: Color
    let titleColor: Color
    let descriptionColor: Color
    
    init(
        iconName: String,
        title: String,
        description: String? = nil,
        additionalDescription: String? = nil,
        phoneNumbers: [PhoneNumber]? = nil,
        showRefreshButton: Bool = false,
        refreshAction: (() async -> Void)? = nil,
        iconSize: CGFloat = 100,
        iconBackgroundColor: Color = .blue.opacity(0.2),
        iconColor: Color = .blue,
        titleColor: Color = .blue,
        descriptionColor: Color = .primary
    ) {
        self.iconName = iconName
        self.title = title
        self.description = description
        self.additionalDescription = additionalDescription
        self.phoneNumbers = phoneNumbers
        self.showRefreshButton = showRefreshButton
        self.refreshAction = refreshAction
        self.iconSize = iconSize
        self.iconBackgroundColor = iconBackgroundColor
        self.iconColor = iconColor
        self.titleColor = titleColor
        self.descriptionColor = descriptionColor
    }
}

// MARK: - Generic Error View
struct GenericErrorView: View {
    let configuration: ErrorViewConfiguration
    
    init(configuration: ErrorViewConfiguration) {
        self.configuration = configuration
    }
    
    var body: some View {
        VStack(spacing: AppDimensions.Spacing.extraLarge) {
            // Error Icon
            ErrorIconView(
                imageName: configuration.iconName,
                size: configuration.iconSize,
                backgroundColor: configuration.iconBackgroundColor,
                iconColor: configuration.iconColor
            )
            
            // Error Title
            ErrorTitleView(
                title: configuration.title,
                color: configuration.titleColor
            )
            
            // Error Description (if available)
            if let description = configuration.description {
                ErrorDescriptionView(
                    description: description,
                    color: configuration.descriptionColor
                )
            }
            
            // Phone Contact Information (if available)
            if let additionalDescription = configuration.additionalDescription,
               let phoneNumbers = configuration.phoneNumbers {
                PhoneView(
                    message: additionalDescription,
                    phoneNumbers: phoneNumbers
                )
                .tag(ErrorViewConstants.textTag4)
                .accessibilityLabel("Phone Contact Information")
                .accessibilityIdentifier("phoneView")
            }
            
            // Refresh Button (if enabled)
            if configuration.showRefreshButton,
               let refreshAction = configuration.refreshAction {
                RefreshButtonView(action: refreshAction)
            }
            
            Spacer()
        }
        .padding()
    }
}

// MARK: - Convenience Initializers
extension GenericErrorView {
    /// Creates a generic error view with basic configuration
    static func basic(
        iconName: String,
        title: String,
        description: String? = nil,
        showRefreshButton: Bool = false,
        refreshAction: (() async -> Void)? = nil
    ) -> GenericErrorView {
        let configuration = ErrorViewConfiguration(
            iconName: iconName,
            title: title,
            description: description,
            showRefreshButton: showRefreshButton,
            refreshAction: refreshAction
        )
        return GenericErrorView(configuration: configuration)
    }
    
    /// Creates a generic error view with phone contact information
    static func withPhoneContact(
        iconName: String,
        title: String,
        description: String? = nil,
        additionalDescription: String,
        phoneNumbers: [PhoneNumber],
        showRefreshButton: Bool = false,
        refreshAction: (() async -> Void)? = nil
    ) -> GenericErrorView {
        let configuration = ErrorViewConfiguration(
            iconName: iconName,
            title: title,
            description: description,
            additionalDescription: additionalDescription,
            phoneNumbers: phoneNumbers,
            showRefreshButton: showRefreshButton,
            refreshAction: refreshAction
        )
        return GenericErrorView(configuration: configuration)
    }
}

// MARK: - Preview
#Preview("Basic Error") {
    GenericErrorView.basic(
        iconName: "exclamationmark.triangle",
        title: "Something went wrong",
        description: "Please try again later",
        showRefreshButton: true
    ) {
        // Simulate refresh action
        try? await Task.sleep(nanoseconds: 1_000_000_000)
    }
}

#Preview("Error with Phone Contact") {
    GenericErrorView.withPhoneContact(
        iconName: "phone.circle",
        title: "Need Help?",
        description: "We're here to help you",
        additionalDescription: "Please call at +1 678-702-3368 (toll free) or if you have any other question call me at 771 (YYM).",
        phoneNumbers: [
            PhoneNumber(displayText: "+1 678-702-3368 (toll free)", dialNumber: "+16787023368"),
            PhoneNumber(displayText: "771 (YYM)", dialNumber: "771")
        ],
        showRefreshButton: true
    ) {
        // Simulate refresh action
        try? await Task.sleep(nanoseconds: 1_000_000_000)
    }
} 