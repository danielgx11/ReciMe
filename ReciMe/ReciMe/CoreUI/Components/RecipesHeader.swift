import SwiftUI

struct RecipesHeader: View {
    let recipeCount: Int

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(Images.cookbookHero)
                .resizable()
                .scaledToFill()
                .frame(height: Metrics.heroHeight)
                .clipped()

            LinearGradient(colors: [.clear, .black.opacity(0.72)], startPoint: .top, endPoint: .bottom)

            VStack(alignment: .leading, spacing: Metrics.spacing8) {
                Text(Strings.cookYourWay)
                    .font(.system(.largeTitle, design: .serif, weight: .bold))
                Text(Strings.cookbookTagline)
                    .font(.subheadline.weight(.medium))
                Text(Strings.cookbookSize(recipeCount))
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.black)
                    .padding(.horizontal, Metrics.spacing12)
                    .padding(.vertical, Metrics.spacing8)
                    .background(Colors.mango, in: Capsule())
            }
            .foregroundStyle(.white)
            .padding(Metrics.spacing20)
        }
        .clipShape(RoundedRectangle(cornerRadius: Metrics.spacing32, style: .continuous))
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(Strings.cookYourWay). \(Strings.cookbookSize(recipeCount))")
    }
}
