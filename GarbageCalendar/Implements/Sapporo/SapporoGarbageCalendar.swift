import Foundation
import CSV

public struct SapporoGarbageCallendar {
    internal let garbageTypeData: [[Int?]]
    internal let locations: [String]
    internal let baseDate: Date
    
    init(csvURL: URL) throws {
        let data = try String(contentsOf: csvURL, encoding: .utf8)
        let csv = try CSVReader(string: data)
        
        // 区域
        guard let header = csv.next() else {
            throw CsvError.header("No header.")
        }
        guard header.count > 2 else {
            throw CsvError.header("Less than 3 columns:  \(header)")
        }
        locations = Array(header[2...])
        
        // ベースの日付
        guard let first = csv.next() else {
            throw CsvError.data("No data")
        }
        guard let date = SapporoGarbageCallendar.date(string: first[0]) else {
            throw CsvError.data("First cell is not Date: \(first)")
        }
        baseDate = date
        
        // データ
        var dataBuffer = [first[2...].map{ Int($0) }]
        for row in csv {
            dataBuffer.append(row[2...].map { Int($0) })
        }
        garbageTypeData = dataBuffer
    }
    subscript(date: Date) -> [String: String?] {
        let interval = DateInterval(start: baseDate, end: date)
        let day = DateUtils.day(interval.duration)
        return self[day]
    }
    subscript(i: Int) -> [String: String?] {
        let types: [String?] = garbageTypeData[i].map { $0.flatMap(gerbageType)
        }
        return [String: String?](zip(locations, types)) { (_, new) in new }
    }
    
    func gerbageType(_ symbol: Int) -> String? {
        SapporoGarbageCallendar.SAPPORO_GARBAGE_TYPE[symbol]
    }
}


extension SapporoGarbageCallendar {
    static private let calendar = Calendar(identifier: .gregorian)
    
    static let SAPPORO_GARBAGE_TYPE = [
        1: "燃やせるゴミ",
        2: "燃やせないゴミ",
        8: "びん・缶・ペット",
        9: "容器プラ",
        10: "雑がみ",
        11: "枝・葉・草"
    ]

    static func date(string: String) -> Date? {
        let d = string.split(separator: "-").map { Int($0) }
        guard d.count == 3, let year = d[0], let month = d[1], let day = d[2] else {
            return nil
        }
        return SapporoGarbageCallendar.calendar.date(from: DateComponents(year: year, month: month, day: day))
    }
}
