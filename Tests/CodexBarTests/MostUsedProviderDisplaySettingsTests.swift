import CodexBarCore
import Testing
@testable import CodexBar

struct MostUsedProviderDisplaySettingsTests {
    @Test
    func `provider preview describes empty all single and subset selections`() {
        let displayName: (UsageProvider) -> String = { provider in
            switch provider {
            case .codex: "Codex"
            case .claude: "Claude"
            case .cursor: "Cursor"
            default: provider.rawValue
            }
        }

        #expect(MostUsedProviderCandidatePreview.text(
            selectedProviders: [],
            activeProviders: [],
            displayName: displayName) == "No enabled providers")
        #expect(MostUsedProviderCandidatePreview.text(
            selectedProviders: [.codex, .claude],
            activeProviders: [.codex, .claude],
            displayName: displayName) == "All enabled")
        #expect(MostUsedProviderCandidatePreview.text(
            selectedProviders: [.claude],
            activeProviders: [.codex, .claude],
            displayName: displayName) == "Claude")
        #expect(MostUsedProviderCandidatePreview.text(
            selectedProviders: [.codex, .claude],
            activeProviders: [.codex, .claude, .cursor],
            displayName: displayName) == "2 selected")
    }

    @Test
    func `ranking metric options keep display order`() {
        #expect(MostUsedProviderRankingMetric.allCases == [
            .closestToRateLimit,
            .tokensUsed,
            .dollarsUsed,
        ])
    }
}
