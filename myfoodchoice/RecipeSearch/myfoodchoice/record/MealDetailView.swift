import SwiftUI

struct FoodItem: Identifiable {
    let id = UUID()
    var name: String
    var amount: Int
}

struct MealDetailView: View {
    let mealType: String
    @State private var searchText = ""
    @State private var selectedItems: [FoodItem] = []
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .font(.system(size: 20))
                }
                
                Spacer()
                
                Text(mealType)
                    .font(.title3)
                    .fontWeight(.medium)
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                        .font(.system(size: 20))
                }
            }
            .padding()
            
            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("What did you eat?", text: $searchText)
                Image(systemName: "camera")
                    .foregroundColor(Color("IconGreen"))
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
            .padding()
            
            // Food Items List
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(sampleFoodItems) { item in
                        HStack {
                            Text("\(item.amount)")
                                .frame(width: 40)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(8)
                            
                            Text(item.name)
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(Color("IconGreen"))
                                    .font(.system(size: 24))
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.white)
                        .cornerRadius(10)
                    }
                }
                .padding()
            }
            
            // Bottom Button
            Button(action: {}) {
                Text("Add to \(mealType.lowercased())")
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("IconGreen"))
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
    
    // Sample data
    private let sampleFoodItems = [
        FoodItem(name: "Coffee with milk", amount: 3),
        FoodItem(name: "Sandwich", amount: 2),
        FoodItem(name: "Tomato", amount: 3),
        FoodItem(name: "Cucumber", amount: 1),
        FoodItem(name: "Tea without sugar", amount: 2),
        FoodItem(name: "Boiled egg", amount: 3)
    ]
}

#Preview {
    MealDetailView(mealType: "Breakfast")
} 