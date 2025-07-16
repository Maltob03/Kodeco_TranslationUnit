//
//  ContentView.swift
//  TranslatorBatch
//
//  Created by Matteo Altobello on 16/07/25.
//

import SwiftUI
import Translation

struct ContentView: View {
    
    struct Task: Identifiable {
        let id = UUID()
        var title: String
    }
    
    @State private var items = [
        Task(title: "Passport"),
        Task(title: "Travel adapter"),
        Task(title: "Toothbrush"),
        Task(title: "Sunscreen"),
        Task(title: "Phone charger"),
        Task(title: "Travel pillow"),
        Task(title: "Headphones")
    ]
    
    @State private var translationSession: TranslationSession?
    @State private var isTranslating = false
    @State private var configuration: TranslationSession.Configuration?
    @State private var sourceLanguageCode = "en"
    @State private var targetLanguageCode = "it"
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(items) { item in
                        Text(item.title)
                            .padding(.vertical, 4)
                    }
                }
                
                if isTranslating {
                    ProgressView("Translating...")
                        .padding()
                } else {
                    Button("Translate Packing List") {
                        configuration = .init(source: Locale(identifier: sourceLanguageCode).language, target: Locale(identifier: targetLanguageCode).language)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
            }
            .navigationTitle("Packing List")
        }
        .translationTask(configuration) { session in
            isTranslating = true
            await translateAllItems(using: session)
        }
    }
    
    private func translateAllItems(using session: TranslationSession) async {
        let itemTitles = items.compactMap { $0.title }
        
        let requests: [TranslationSession.Request] = itemTitles.enumerated().map
        { (index, string) in
                .init(sourceText: string, clientIdentifier: "\(index)")
        }
        
        do {
            for try await response in session.translate(batch: requests) {
                guard let index = Int(response.clientIdentifier ?? "") else { continue }
                items[index].title = response.targetText
            }
        } catch {
            print("Error executing translateSequence: \(error)")
        }
        
        await MainActor.run {
            self.sourceLanguageCode = self.targetLanguageCode
            self.targetLanguageCode = self.targetLanguageCode == "en" ? "it" : "en"
            self.isTranslating = false
        }
    }
}

#Preview {
    ContentView()
}
