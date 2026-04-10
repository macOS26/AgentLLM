import Foundation

/// Connection details for an LLM service. Fully configurable — no hardcoded URLs.
public struct LLMEndpoint: Codable, Sendable, Hashable {
    /// Chat API URL (code/text models)
    public var chatURL: String
    /// Models list URL (code/text models)
    public var modelsURL: String
    /// Vision chat API URL (empty = same as chatURL)
    public var visionChatURL: String
    /// Vision models list URL (empty = same as modelsURL)
    public var visionModelsURL: String
    /// Auth header name
    public var authHeader: String
    /// Auth value prefix
    public var authPrefix: String
    /// Extra headers
    public var extraHeaders: [String: String]
    /// Request timeout in seconds
    public var timeout: TimeInterval
    /// Default port (0 = use URL as-is)
    public var defaultPort: Int

    public init(
        chatURL: String,
        modelsURL: String = "",
        visionChatURL: String = "",
        visionModelsURL: String = "",
        authHeader: String = "Authorization",
        authPrefix: String = "Bearer ",
        extraHeaders: [String: String] = [:],
        timeout: TimeInterval = 120,
        defaultPort: Int = 0
    ) {
        self.chatURL = chatURL
        self.modelsURL = modelsURL
        self.visionChatURL = visionChatURL
        self.visionModelsURL = visionModelsURL
        self.authHeader = authHeader
        self.authPrefix = authPrefix
        self.extraHeaders = extraHeaders
        self.timeout = timeout
        self.defaultPort = defaultPort
    }

    /// Resolved chat URL — returns visionChatURL for vision, chatURL otherwise
    public func resolvedChatURL(isVision: Bool) -> String {
        if isVision && !visionChatURL.isEmpty { return visionChatURL }
        return chatURL
    }

    /// Resolved models URL — returns visionModelsURL for vision, modelsURL otherwise
    public func resolvedModelsURL(isVision: Bool) -> String {
        if isVision && !visionModelsURL.isEmpty { return visionModelsURL }
        return modelsURL
    }

    // MARK: - Well-Known Default Ports

    /// Ollama default port
    public static let ollamaPort = 11434
    /// LM Studio default port
    public static let lmStudioPort = 1234
    /// vLLM default port
    public static let vLLMPort = 8000
}
