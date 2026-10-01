import SwiftUI

struct RecipesHeader: View {
    let recipeCount: Int

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("CookbookHero")
                .resizable()
                .scaledToFill()
                .frame(height: 240)
                .clipped()
            LinearGradient(colors: [.clear, .black.opacity(0.72)], startPoint: .top, endPoint: .bottom)
            VStack(alignment: .leading, spacing: 6) {
                Text("Cook your way")
                    .font(.system(.largeTitle, design: .serif, weight: .bold))
                Text("A little Brazilian warmth, whenever you need it.")
                    .font(.subheadline.weight(.medium))
                Text("\(recipeCount) recipes to make your own")
                    .font(.caption.weight(.bold))
                    .padding(.horizontal, 10).padding(.vertical, 6)
                    .background(Color("Mango"), in: Capsule())
                    .foregroundStyle(.primary)
            }
            .foregroundStyle(.white)
            .padding(18)
        }
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Cook your way. \(recipeCount) recipes to make your own.")
    }
}
