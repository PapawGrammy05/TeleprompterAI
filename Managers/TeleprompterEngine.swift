import Foundation

final class TeleprompterEngine: ObservableObject {
    @Published var script: String = """
    EV techs are not just parts changers. We diagnose software, high voltage systems, and real-world failures in ugly weather.
    """
    @Published var currentIndex: Int = 0
    @Published var currentLineIndex: Int = 0
    @Published var lines: [String] = []

    init() {
        updateLines()
    }

    func updateLines() {
        lines = script.split(separator: "\n").map(String.init).filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
    }

    func updateProgress(using transcript: String) {
        let scriptWords = normalizedWords(from: script)
        let spokenWords = normalizedWords(from: transcript)
        guard !scriptWords.isEmpty, !spokenWords.isEmpty else { return }

        var bestMatch = currentIndex
        let searchEnd = min(scriptWords.count, currentIndex + 30)

        for i in currentIndex..<searchEnd {
            let window = Array(scriptWords[i..<min(i + spokenWords.count, scriptWords.count)])
            if overlapScore(window, spokenWords) > 0.65 {
                bestMatch = min(i + spokenWords.count, scriptWords.count - 1)
            }
        }

        if bestMatch > currentIndex {
            currentIndex = bestMatch
            updateCurrentLineIndex()
        }
    }

    private func updateCurrentLineIndex() {
        let words = script.split(separator: " ")
        var wordCount = 0

        for (lineIndex, line) in lines.enumerated() {
            let lineWords = line.split(separator: " ").count
            if wordCount + lineWords > currentIndex {
                currentLineIndex = lineIndex
                return
            }
            wordCount += lineWords
        }
        currentLineIndex = max(0, lines.count - 1)
    }

    var remainingText: String {
        let words = script.split(separator: " ")
        guard currentIndex < words.count else { return "" }
        return words[currentIndex...].joined(separator: " ")
    }

    var currentLine: String {
        guard currentLineIndex >= 0 && currentLineIndex < lines.count else { return "" }
        return lines[currentLineIndex]
    }

    var previousLines: [String] {
        guard currentLineIndex > 0 else { return [] }
        return Array(lines[0..<currentLineIndex])
    }

    var nextLines: [String] {
        let nextIndex = currentLineIndex + 1
        guard nextIndex < lines.count else { return [] }
        return Array(lines[nextIndex...])
    }

    private func normalizedWords(from text: String) -> [String] {
        text.lowercased()
            .replacingOccurrences(of: "[^a-z0-9\\s]", with: " ", options: .regularExpression)
            .split(separator: " ")
            .map(String.init)
    }

    private func overlapScore(_ a: [String], _ b: [String]) -> Double {
        guard !a.isEmpty, !b.isEmpty else { return 0 }
        let matches = zip(a, b).filter { $0 == $1 }.count
        return Double(matches) / Double(max(a.count, b.count))
    }
}