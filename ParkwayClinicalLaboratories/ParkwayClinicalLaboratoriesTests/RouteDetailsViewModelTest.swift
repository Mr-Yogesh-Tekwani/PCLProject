//
//  RouteDetailsViewModelTest.swift
//  ParkwayClinicalLaboratoriesTests
//
//  Created by Yogesh on 7/21/23.
//

import Foundation
import XCTest
@testable import ParkwayClinicalLaboratories


class RouteDetailsViewModelTest: XCTestCase{

    func testInit() throws {
        let roteDetailsVm = RouteDetailsViewModel()
        let _ = try XCTUnwrap(roteDetailsVm.makeVc() as UIViewController)
    }
}
