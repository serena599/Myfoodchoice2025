import SwiftUI

struct MealCard: View {
    let title: String
    let color: Color

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(color)
                .padding(.leading)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .padding(.trailing)
        }
        .frame(height: 60)
        .background(color.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    MealCard(title: "Breakfast", color: .green)
} 