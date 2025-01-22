import Foundation

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

public enum ApiSetup: String {
    case baseURL = "https://api.themoviedb.org"
}
