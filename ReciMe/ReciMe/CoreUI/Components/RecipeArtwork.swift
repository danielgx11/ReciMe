import SwiftUI

struct RecipeArtwork: View {
    let recipe: Recipe

    var body: some View {
        let style = ArtworkStyle(imageName: recipe.imageName)
        ZStack {
            LinearGradient(
                colors: [style.start, style.end],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            Image(systemName: style.symbol)
                .font(.system(size: Metrics.spacing32, weight: .medium))
                .foregroundStyle(.white.opacity(0.9))

            Text(style.caption)
                .font(.caption2.weight(.black))
                .tracking(1.1)
                .foregroundStyle(.white.opacity(0.7))
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(Metrics.spacing12)
        }
        .clipShape(RoundedRectangle(cornerRadius: Metrics.cornerRadius, style: .continuous))
        .accessibilityHidden(true)
    }
}

private struct ArtworkStyle {
    let start: Color
    let end: Color
    let symbol: String
    let caption: String

    init(imageName: String) {
        caption = imageName.replacingOccurrences(of: "-", with: " ").uppercased()
        switch imageName {
        case "pudim", "tomato-soup", "stroganoff":
            start = Colors.mango
            end = .orange.opacity(0.8)
            symbol = Images.flame
        case "moqueca", "avocado-salad", "cauliflower-rice":
            start = Colors.lime
            end = .teal.opacity(0.72)
            symbol = Images.leaf
        case "feijoada", "tropeiro", "coxinha":
            start = Colors.blueberry
            end = .brown.opacity(0.75)
            symbol = Images.forkAndKnife
        default:
            start = Colors.blueberry
            end = Colors.mango
            symbol = Images.sparkles
        }
    }
}
