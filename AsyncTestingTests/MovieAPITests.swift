//
//  MovieAPITests.swift
//  AsyncTestingTests
//
//  Created by C4Q on 4/24/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import XCTest
@testable import AsyncTesting // the name of the project

class MovieAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testMovieAPI() {
        // create an expectation for a background task
        let exp = expectation(description: "movie results received")

        var search: MovieSearch!

        MovieAPI.searchMovies(keyword: "") { (error, data) in
            if let error = error {
                XCTFail("movie search error: \(error)")
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    search = try decoder.decode(MovieSearch.self, from: data)

                    // fulfill to indicate task is complete
                    exp.fulfill()
                } catch {
                    XCTFail("decoding error: \(error)")
                }
            }
        }
    // async call so we need to wait until the expectation is fulfilled
    wait(for: [exp], timeout: 3.0)
    XCTAssertGreaterThan(search.results.count, 0, "movie count should be greater than 0")
}
    func testAPI() {
        let exp = expectation(description: "movie results received")
        var search: MovieSearch!
        var unratedMV = [Movie]()
        MovieAPI.searchMovies(keyword: "") { (error, data) in
            if let error = error {
                XCTFail("movie search error: \(error)") // generates a failure immediately and unconditionally
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    search = try decoder.decode(MovieSearch.self, from: data)
                    unratedMV = search.results.filter({$0.contentAdvisoryRating == "Unrated"})
                    exp.fulfill() // fulfill to indicate task is complete
                } catch {
                    XCTFail("decoding error: \(error)")
                }
            }
        }
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(search.results.count , 10, "Movie count should be equal 10")
     //   XCTAssertEqual(search.results[0].artistName, "Xianxian Chen")
        XCTAssertNil(unratedMV.index(where: {$0.contentAdvisoryRating != "Unrated"}), "all moview are unrated")
        
    }

//func testMovieExist() {
//    let exp = expectation(description: "movie results received")
//    var search: MovieSearch!
//    MovieAPI.searchMovies(keyword: "") { (error, data) in
//        if let error = error {
//            XCTFail("movie search error: \(error)")
//        } else if let data = data {
//            do {
//                let decoder = JSONDecoder()
//                search = try decoder.decode(MovieSearch.self, from: data)
//
//                // fulfill to indicate task is complete
//                exp.fulfill()
//            } catch {
//                XCTFail("decoding error: \(error)")
//            }
//        }
//    }
//    // async call so we need to wait until the expectation is fulfilled
//    wait(for: [exp], timeout: 3.0)
//
//    XCTAssertEqual(search.results[0].trackName, "Blue Collar Comedy Tour: One for the Road", "movie does not exist")
//}
    
    
    
}
