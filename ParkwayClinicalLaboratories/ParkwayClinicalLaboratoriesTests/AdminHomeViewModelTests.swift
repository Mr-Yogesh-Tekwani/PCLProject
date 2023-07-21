//
//  AdminHomeViewModelTests.swift
//  ParkwayClinicalLaboratoriesTests
//
//  Created by Yogesh on 7/21/23.
//

import Foundation
import XCTest
@testable import ParkwayClinicalLaboratories


class AdminHomeViewModelTests: XCTestCase{

    func testInit() throws {
        let adminHomeVm = AdminHomeViewModel()
        let _ = try XCTUnwrap(adminHomeVm.makeVc() as UIViewController)
    }
}
