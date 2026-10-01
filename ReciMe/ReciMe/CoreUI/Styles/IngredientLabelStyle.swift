import SwiftUI

struct IngredientLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 10) {
            configuration
                .icon
                .foregroundStyle(Color("Lime"))

            configuration.title
        }
    }
}
