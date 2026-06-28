import CodexBarCore
import Foundation

enum MostUsedProviderCandidatePreview {
    static func text(
        selectedProviders: [UsageProvider],
        activeProviders: [UsageProvider],
        displayName: (UsageProvider) -> String)
        -> String
    {
        let active = self.normalized(activeProviders)
        guard !active.isEmpty else { return L("most_used_provider_preview_none") }

        let activeSet = Set(active)
        let selected = self.normalized(selectedProviders).filter { activeSet.contains($0) }
        guard !selected.isEmpty else { return L("most_used_provider_preview_all_enabled") }
        guard selected.count != active.count else { return L("most_used_provider_preview_all_enabled") }
        if selected.count == 1, let provider = selected.first {
            return displayName(provider)
        }
        return L("most_used_provider_preview_count", selected.count)
    }

    private static func normalized(_ providers: [UsageProvider]) -> [UsageProvider] {
        var seen: Set<UsageProvider> = []
        var normalized: [UsageProvider] = []
        for provider in providers where !seen.contains(provider) {
            seen.insert(provider)
            normalized.append(provider)
        }
        return normalized
    }
}
