//
//  ContentView.swift
//  Widget
//
//  Created by Haadhya on 29/12/23.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 20) {
                Text("MY IBD Care")
                    .font(.title)

                SectionView(title: "Blood", buttons: viewModel.bloodButtons, hasBorder: true)

                SectionView(title: "Urgency", buttons: viewModel.urgencyButtons, hasBorder: true)

                Button(action: {
                    // Action for Cancel Button
                    viewModel.cancelAction()
                }) {
                    Text("ADD BOWEL MOVEMENT")
                        .buttonStyle(CustomButtonStyle(backgroundColor: Color.pink, borderColor: Color.yellow))
                        .frame(width: geometry.size.width - 20)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 30)
                }

                Button(action: {
                    // Action for Submit Button
                    viewModel.submitAction()
                }) {
                    Text("Check All Bowel Moment stats")
                        .buttonStyle(CustomButtonStyle())
                        .padding(.top, 5)
                }

                Spacer()
            }
            .padding()
        }
    }
}

// MARK: - Custom Views

struct SectionView: View {
    var title: String
    var buttons: [BowelMovement]
    var hasBorder: Bool

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .padding(.leading, 20)
            Spacer()
        }

        HStack(spacing: 10) {
            ForEach(buttons, id: \.title) { button in
                Button(action: {
                    button.action()
                }) {
                    Text(button.title)
                        .padding()
                        .foregroundColor(.blue)
                        .background(Color.white)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(hasBorder ? Color.black : Color.clear, lineWidth: 1)
                        )
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 10)
    }
}

struct CustomButtonStyle: ButtonStyle {
    var backgroundColor: Color = Color.black
    var borderColor: Color = Color.blue

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(.white)
            .background(backgroundColor)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(borderColor, lineWidth: 1)
            )
    }
}


#Preview {
    ContentView()
}
struct BowelMovement {
    var title: String
    var action: () -> Void
}
class ContentViewModel: ObservableObject {
    struct Entry: TimelineEntry {
        var date: Date
        var viewModel: ContentViewModel
        var family: WidgetFamily  // Add this line
    }

    @Published var bloodButtons: [BowelMovement] = [
        BowelMovement(title: "Button 1", action: { /* Action for Blood Button 1 */ }),
        BowelMovement(title: "Button 2", action: { /* Action for Blood Button 2 */ }),
        BowelMovement(title: "Button 3", action: { /* Action for Blood Button 3 */ })
    ]

    @Published var urgencyButtons: [BowelMovement] = [
        BowelMovement(title: "Button 1", action: { /* Action for Urgency Button 1 */ }),
        BowelMovement(title: "Button 2", action: { /* Action for Urgency Button 2 */ }),
        BowelMovement(title: "Button 3", action: { /* Action for Urgency Button 3 */ })
    ]

    func cancelAction() {
        // Action for Cancel Button
    }

    func submitAction() {
        // Action for Submit Button
    }

}

