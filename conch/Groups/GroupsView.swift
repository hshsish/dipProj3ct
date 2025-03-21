import SwiftUI

struct GroupsView: View {
    @StateObject private var viewModel: GroupViewModel

    init(accessToken: String) {
        _viewModel = StateObject(wrappedValue: GroupViewModel(accessToken: accessToken))
    }

    var body: some View {
        NavigationStack {
            List(viewModel.groups) { group in
                Text(group.name)
            }
            .navigationTitle("Группы")
            .alert(isPresented: $viewModel.showingError) {
                Alert(
                    title: Text("Ошибка"),
                    message: Text(viewModel.errorMessage ?? ""),
                    dismissButton: .default(Text("OK"), action: {
                        viewModel.errorMessage = nil
                    })
                )
            }
        }
    }
}
