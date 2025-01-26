import SwiftUI

struct GoalSettingView: View {
    @State private var vegetables = "5"
    @State private var fruits = "3"
    @State private var grains = "5"
    @State private var meat = "2"
    @State private var dairy = "3"
    @State private var extras = "1"

    var body: some View {
        VStack {
            // Title
            Text("Goal Setting")
                .font(.title)
                .bold()
                .padding()

            // Form Content
            Form {
                Group {
                    GoalSettingRow(iconName: "leaf", category: "Vegetables", value: $vegetables, minValue: "Serve(s)Min. 5*")
                    GoalSettingRow(iconName: "apple", category: "Fruit", value: $fruits, minValue: "Serve(s)Min. 2*")
                    GoalSettingRow(iconName: "wheat", category: "Grains", value: $grains, minValue: "Serve(s)Min. 6*")
                    GoalSettingRow(iconName: "drumstick", category: "Meat", value: $meat, minValue: "Serve(s)Min. 2.5*")
                    GoalSettingRow(iconName: "milk", category: "Dairy", value: $dairy, minValue: "Serve(s)Min. 2.5*")
                    GoalSettingRow(iconName: "chocolate.bar", category: "Extras", value: $extras, minValue: "Serve(s)Min. 2.5*")
                }
            }

            // Note
            Text("* Recommended number of serves based on Australian Dietary Guidelines")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .padding()

            // Buttons
            HStack(spacing: 20) {
                Button(action: {
                    // Cancel action
                }) {
                    Text("Cancel")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: {
                    // Confirm action
                }) {
                    Text("Confirm")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)

        }
    }
}

struct GoalSettingRow: View {
    var iconName: String
    var category: String
    @Binding var value: String
    var minValue: String

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.green)
                .frame(width: 30, height: 30)

            Text(category)

            Spacer()

            TextField("", text: $value)
                .frame(width: 50)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)

            Text(minValue)
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 5)
    }
}

struct GoalSettingView_Previews: PreviewProvider {
    static var previews: some View {
        GoalSettingView()
    }
}

