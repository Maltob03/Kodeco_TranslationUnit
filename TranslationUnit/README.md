# 🌐 Swift Translation Projects

Welcome! This repository contains two hands-on SwiftUI projects that demonstrate how to use Apple’s Translation framework, including the new TranslationSession API. These exercises are designed to help you quickly grasp the essentials of building interactive translation features in Swift apps.

---

## ✨ Project 1: Message Translator

A straightforward app for translating a single message. Enter your text, tap a button, and see your message instantly translated in place.

**Key Highlights:**
- Input field for typing your message
- One-tap translation with a dedicated button
- The original text is replaced by its translation
- Visual feedback using TranslationOverlay

**Workflow:**
1. Type your message in the provided field
2. Tap the Translate button
3. A translation overlay appears briefly
4. The message updates to show the translated text

---

## ✨ Project 2: Batch Translator

This app displays a list of tasks and allows you to translate all items at once with a single action, leveraging batch processing.

**Key Highlights:**
- Task list presented using SwiftUI’s List
- Translate All button to process every item
- All tasks are translated simultaneously
- Utilizes TranslationSession for efficient batch translation

**Workflow:**
1. View a static list of tasks
2. Press Translate All
3. A TranslationSession is started for the group
4. Each task is translated and the list updates with the results

---

## 🚦 How to Run

1. Open either project in Xcode
2. Run on a real device (for full translation features) or simulator (for overlay demo) with internet access
3. Enter text or use the Translate All feature to see translations in action

---

## 👤 Credits

Project maintained and originally set up by [Matteo Altobello](https://github.com/matteoaltobello).

