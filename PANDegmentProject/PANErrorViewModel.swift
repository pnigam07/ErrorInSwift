//
//  MemberIDViewModel.swift
//  PANDegmentProject
//
//  Created by pankaj nigam on 7/15/25.
//

import Foundation


protocol MemberIDModelContentState {
    var imageName: String { get }
    var title: String { get }
    var description: String? { get }
    var additionalDescription: String? { get }
    var phoneNumbers: [PhoneNumber]? { get }
    var showRefreshButton: Bool { get }
}

struct MemberIDCardUnavailable: MemberIDModelContentState {
    let imageName: String = AppStrings.houseImage
    let title: String = AppStrings.cardUnavailableTitle
    let description: String? = AppStrings.cardUnavailableDescription
    let additionalDescription: String? = AppStrings.additionalDescriptionA + " "
    let phoneNumbers: [PhoneNumber]? = [
        PhoneNumber(displayText: AppStrings.phoneNumber1Display, dialNumber: AppStrings.phoneNumber1Dial),
        PhoneNumber(displayText: AppStrings.phoneNumber2Display, dialNumber: AppStrings.phoneNumber2Dial)
    ]
    let showRefreshButton: Bool = true
}

struct ImportantMessage: MemberIDModelContentState {
    let imageName: String = "house.fill"
    let title: String = "Important Messaage"
    let description: String? = "we are sorry bit this feature is not available so how is your day going on hope everythiong is alright please do let me know"
    let additionalDescription: String? = "Please call at +1 678-702-3368 (toll free) or if you have any other question call me at 771 (YYM)."
    let phoneNumbers: [PhoneNumber]? = [PhoneNumber(displayText: "+1 678-702-3368 (toll free)", dialNumber: "+16787023368"),
    PhoneNumber(displayText: "771 (YYM)", dialNumber: "771")]
    let showRefreshButton: Bool = false
}

class PANErrorViewModel: ObservableObject {
    private let contentState: MemberIDModelContentState
    
    var title: String {contentState.title}
    var imageName: String {contentState.imageName}
    var description: String? {contentState.description}
    var additionalDescription: String? {contentState.additionalDescription}
    var phoneNumbers: [PhoneNumber]? {contentState.phoneNumbers}
    var showRefreshButton: Bool? {contentState.showRefreshButton}
    
    
    init(contentState: MemberIDModelContentState = MemberIDCardUnavailable() ) {
        self.contentState = contentState
    }
    
    @MainActor
    func refreshContent() async {
        try? await Task.sleep(nanoseconds: 500_00_000) // 0.5 seconds
        
        // Since we can't change the state after init, this is just a placeholder
        // In a real implementation, this could trigger data refresh or notification
    }
}
