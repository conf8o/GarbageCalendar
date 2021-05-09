import Foundation

enum CsvError: Error {
    case header(String)
    case data(String)
}
