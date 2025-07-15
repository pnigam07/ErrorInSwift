import SwiftUI

struct PANRootView: View {
    private let viewModel = PANErrorViewModel(contentState: MemberIDCardUnavailable())
   
    var body: some View {
        PANErrorView(viewModel: viewModel)
    }
}

#Preview {
    PANRootView()
} 
