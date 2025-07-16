//
//  ContentView.swift
//  Translator
//
//  Created by Matteo Altobello on 16/07/25.
//

import SwiftUI
import Translation

struct ContentView: View {
    @State private var inputText = ""
    @State private var showTranslation = false
    @State private var sourceLanguage = "en"
    @State private var targetLanguage = "it"
    @State private var availableLanguages: [String] = []
    @State private var configuration: TranslationSession.Configuration?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Enter text...", text: $inputText)
                    .textFieldStyle(.roundedBorder)
                
                HStack {
                    Picker("From", selection: $sourceLanguage) {
                        ForEach(availableLanguages, id: \.self) { code in
                            Text(Locale(identifier: "en").localizedString(forLanguageCode: code) ?? code)
                                .tag(code)
                        }
                    }
                    
                    Picker("To", selection: $targetLanguage) {
                        ForEach(availableLanguages, id: \.self) { code in
                            Text(Locale(identifier: "en").localizedString(forLanguageCode: code) ?? code)
                                .tag(code)
                        }
                    }
                }
                
                Button("Translate") {
                    configuration = .init(
                        source: Locale(identifier: sourceLanguage).language,
                        target: Locale(identifier: targetLanguage).language
                    )
                    showTranslation = true
                }
                .buttonStyle(.borderedProminent)
                .disabled(inputText.isEmpty)
                
                Spacer()
            }
            .padding()
            .translationTask(configuration) { session in
                Task { @MainActor in
                    do {
                        inputText = try await session.translate(inputText).targetText
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            .translationPresentation(isPresented: $showTranslation, text: inputText) { translatedText in
                inputText = translatedText
            }
            .onAppear {
                availableLanguages = Array(Set(Locale.availableIdentifiers.compactMap {
                    Locale(identifier: $0).language.languageCode?.identifier
                })).sorted(by: { firstCode, secondCode in
                    Locale(identifier: "en").localizedString(forLanguageCode: firstCode) ?? firstCode < Locale(identifier: "en").localizedString(forLanguageCode: secondCode) ?? secondCode
                })
            }
            .navigationTitle("Pocket Translator")
        }
    }
}


#Preview {
    ContentView()
}
