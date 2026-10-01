import SwiftUI

struct RecipeArtwork: View {
    let recipe: Recipe
    private var mood: (Color, Color, String) {
        switch recipe.id {
        case "recipe-001", "recipe-006", "recipe-010": (Color("Mango"), .orange.opacity(0.8), "flame.fill")
        case "recipe-002", "recipe-004", "recipe-005": (Color("Lime"), .teal.opacity(0.72), "leaf.fill")
        case "recipe-007", "recipe-008", "recipe-009": (Color("Blueberry"), .brown.opacity(0.75), "fork.knife")
        default: (Color("Blueberry"), Color("Mango"), "sparkles")
        }
    }

    var body: some View {
        let style = mood
        ZStack {
            LinearGradient(colors: [style.0, style.1],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)

            Image(systemName: style.2)
                .font(.system(size: Metrics.spacing32, weight: .medium))
                .foregroundStyle(.white.opacity(0.9))

            Text(recipe.imageName.replacingOccurrences(of: "-", with: " ").uppercased())
                .font(.system(size: Metrics.spacing8, weight: .black, design: .rounded))
                .tracking(1.1)
                .foregroundStyle(.white.opacity(0.7))
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(Metrics.spacing12)
        }
        .clipShape(RoundedRectangle(cornerRadius: Metrics.cornerRadius,
                                    style: .continuous))
    }
}
