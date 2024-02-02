import Foundation
import Moya

/// Moya still doesn't support async requests. Using this extension in the meantime.
/// Check back https://github.com/Moya/Moya/issues/2265 for any evolution on the matter.
extension MoyaProvider {

    class MoyaConcurrency {

        private let provider: MoyaProvider

        init(provider: MoyaProvider) {
            self.provider = provider
        }

        func request<T: Decodable>(_ target: Target) async throws -> T {
            return try await withCheckedThrowingContinuation { continuation in
                provider.request(target) { result in
                    switch result {
                    case .success(let response):
                        do {
                            let res = try JSONDecoder.default.decode(T.self, from: response.data)
                            continuation.resume(returning: res)
                        } catch {
                            continuation.resume(throwing: MoyaError.jsonMapping(response))
                        }

                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }

    var async: MoyaConcurrency {
        MoyaConcurrency(provider: self)
    }
}

extension JSONDecoder {
    static var `default`: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(.custom)
        return decoder
    }
}

extension DateFormatter {
    static let custom: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
