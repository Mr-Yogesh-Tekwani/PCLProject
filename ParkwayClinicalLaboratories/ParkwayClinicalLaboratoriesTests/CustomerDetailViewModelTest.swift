//
//  CustomerDetailViewModelTest.swift
//  ParkwayClinicalLaboratoriesTests
//
//  Created by Yogesh on 7/21/23.
//

import Foundation
import XCTest
@testable import ParkwayClinicalLaboratories


class CustomerDetailsViewModelTest: XCTestCase{

    func testInit() throws {
        let custDetailsVm = CustomerDetailsViewModel()
        let _ = try XCTUnwrap(custDetailsVm.makeVc() as UIViewController)
    }
}
