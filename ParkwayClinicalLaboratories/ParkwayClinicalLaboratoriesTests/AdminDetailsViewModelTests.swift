//
//  AdminDetailsViewModelTests.swift
//  ParkwayClinicalLaboratoriesTests
//
//  Created by Yogesh on 7/21/23.
//

import Foundation
import XCTest
@testable import ParkwayClinicalLaboratories


class AdminDetailsViewModelTests: XCTestCase{

    func testInit() throws {
        let adminVm = AdminHomeDetailsViewModel()
        let _ = try XCTUnwrap(adminVm.makeVc() as UIViewController)
    }
}
