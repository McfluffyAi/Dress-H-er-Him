import Foundation

/// Service for handling network requests
@MainActor
class NetworkService: ObservableObject {
    private let session = URLSession.shared
    private let baseURL = "https://api.example.com"
    
    /// Generic network request method
    func request<T: Codable>(
        endpoint: String,
        method: HTTPMethod = .GET,
        body: Data? = nil,
        responseType: T.Type
    ) async throws -> T {
        guard let url = URL(string: baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = body {
            request.httpBody = body
        }
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            guard 200...299 ~= httpResponse.statusCode else {
                throw NetworkError.httpError(httpResponse.statusCode)
            }
            
            let decoder = JSONDecoder()
            return try decoder.decode(responseType, from: data)
        } catch {
            if error is NetworkError {
                throw error
            } else {
                throw NetworkError.requestFailed(error)
            }
        }
    }
    
    /// GET request
    func get<T: Codable>(endpoint: String, responseType: T.Type) async throws -> T {
        return try await request(
            endpoint: endpoint,
            method: .GET,
            responseType: responseType
        )
    }
    
    /// POST request
    func post<T: Codable, U: Codable>(
        endpoint: String,
        body: U,
        responseType: T.Type
    ) async throws -> T {
        let encoder = JSONEncoder()
        let bodyData = try encoder.encode(body)
        
        return try await request(
            endpoint: endpoint,
            method: .POST,
            body: bodyData,
            responseType: responseType
        )
    }
}

// MARK: - Supporting Types
enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case requestFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response"
        case .httpError(let code):
            return "HTTP error: \(code)"
        case .requestFailed(let error):
            return "Request failed: \(error.localizedDescription)"
        }
    }
}
