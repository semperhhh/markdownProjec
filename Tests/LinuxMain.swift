import XCTest

import markdownProjectTests

var tests = [XCTestCaseEntry]()
tests += markdownProjectTests.allTests()
XCTMain(tests)