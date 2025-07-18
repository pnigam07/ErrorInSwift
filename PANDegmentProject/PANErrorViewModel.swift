//
//  MemberIDViewModel.swift
//  PANDegmentProject
//
//  Created by pankaj nigam on 7/15/25.
//

import Foundation

// MARK: - Protocols
protocol MemberIDModelContentState {
    var imageName: String { get }
    var title: String { get }
    var description: String? { get }
    var additionalDescription: String? { get }
    var phoneNumbers: [PhoneNumber]? { get }
    var showRefreshButton: Bool { get }
}

// MARK: - Content States
struct MemberIDCardUnavailable: MemberIDModelContentState {
    let imageName: String = AppStrings.Icons.house
    let title: String = AppStrings.Titles.cardUnavailable
    let description: String? = AppStrings.Descriptions.cardUnavailable
    let additionalDescription: String? = AppStrings.AdditionalDescriptions.contentA
    let phoneNumbers: [PhoneNumber]? = [
        PhoneNumber(displayText: AppStrings.PhoneNumbers.Display.tollFree, dialNumber: AppStrings.PhoneNumbers.Dial.tollFree),
        PhoneNumber(displayText: AppStrings.PhoneNumbers.Display.yym, dialNumber: AppStrings.PhoneNumbers.Dial.yym)
    ]
    let showRefreshButton: Bool = true
}

struct ImportantMessage: MemberIDModelContentState {
    let imageName: String = AppStrings.Icons.house
    let title: String = AppStrings.Titles.importantMessage
    let description: String? = AppStrings.Descriptions.cardUnavailable
    let additionalDescription: String? = AppStrings.AdditionalDescriptions.contentA
    let phoneNumbers: [PhoneNumber]? = [
        PhoneNumber(displayText: AppStrings.PhoneNumbers.Display.tollFree, dialNumber: AppStrings.PhoneNumbers.Dial.tollFree),
        PhoneNumber(displayText: AppStrings.PhoneNumbers.Display.yym, dialNumber: AppStrings.PhoneNumbers.Dial.yym)
    ]
    let showRefreshButton: Bool = false
}

// MARK: - View Model
@MainActor
final class PANErrorViewModel: ObservableObject {
    private let contentState: MemberIDModelContentState
    
    // MARK: - Computed Properties
    var title: String { contentState.title }
    var imageName: String { contentState.imageName }
    var description: String? { contentState.description }
    var additionalDescription: String? { contentState.additionalDescription }
    var phoneNumbers: [PhoneNumber]? { contentState.phoneNumbers }
    var showRefreshButton: Bool { contentState.showRefreshButton }
    
    // MARK: - Initialization
    init(contentState: MemberIDModelContentState = MemberIDCardUnavailable()) {
        self.contentState = contentState
    }
    
    // MARK: - Actions
    func refreshContent() async {
        try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        
        // Since we can't change the state after init, this is just a placeholder
        // In a real implementation, this could trigger data refresh or notification
    }
}
