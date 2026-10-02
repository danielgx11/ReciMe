import SwiftUI

struct IngredientLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: Metrics.spacing8) {
            configuration
                .icon
                .foregroundStyle(Colors.lime)

            configuration.title
        }
    }
}

extension LabelStyle where Self == IngredientLabelStyle {
    static var ingredient: IngredientLabelStyle { IngredientLabelStyle() }
}
