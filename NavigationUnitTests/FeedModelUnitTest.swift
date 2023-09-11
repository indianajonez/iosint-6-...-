//
//  FeedModelUnitTest.swift
//  NavigationUnitTests
//
//  Created by Ekaterina Saveleva on 11.09.2023.
//

import XCTest
@testable import Navigation

class FeedModelUnitTest: XCTestCase {
    
    func testGetPost() {
        let viewModel = FeedViewModel()
        let testTitle = "userTitile"
        let testText = "userText"
        
       let result = viewModel.getPost(title: testTitle, image: nil, text: testText)
        
        XCTAssertEqual(result.title, testTitle)
        XCTAssertEqual(result.text, testText)
    }
    
}
