import XCTest
@testable import GarbageCalendar
import CSV

class GarbageCalendarTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSapporoGarbageCallendar() throws {
        let urlstr = "https://ckan.pf-sapporo.jp/dataset/281fc9c2-7ca5-4aed-a728-0b588e509686/resource/3e7862c1-c9df-4b21-b6cf-aca9b89e60c6/download/garvagecollectioncalendar202010.csv"
        let url = URL(string: urlstr)!
        let sapporo = try SapporoGarbageCallendar(csvURL: url)
        print(sapporo.locations)
        print(sapporo.baseDate)
        print(sapporo.garbageTypeData.count)
        print(sapporo[1].randomElement()!)
        print(sapporo[Date()].randomElement()!)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
