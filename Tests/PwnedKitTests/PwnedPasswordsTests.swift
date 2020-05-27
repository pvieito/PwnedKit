//
//  PwnedPasswordsManagerTests.swift
//  PwnedKitTests
//
//  Created by Pedro José Pereira Vieito on 22/11/2019.
//  Copyright © 2019 Pedro José Pereira Vieito. All rights reserved.
//

import Foundation
import PwnedKit
import XCTest

class PwnedPasswordsTests: XCTestCase {
    func testPwnedPasswords() throws {
        XCTAssertGreaterThanOrEqual(try PwnedPasswordManager.check(password: "1234"), 1)
        XCTAssertGreaterThanOrEqual(try PwnedPasswordManager.check(password: "password"), 1)
        
        XCTAssertEqual(try PwnedPasswordManager.check(password: UUID().uuidString), 0)
        XCTAssertEqual(try PwnedPasswordManager.check(password: UUID().uuidString), 0)
    }
}
