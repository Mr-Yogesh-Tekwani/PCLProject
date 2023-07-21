//
//  LoginViewModelTest.swift
//  ParkwayClinicalLaboratoriesTests
//
//  Created by Yogesh on 7/21/23.
//

import Foundation
import XCTest
@testable import ParkwayClinicalLaboratories


class LoginViewModelTest: XCTestCase{

    func testInit() throws {
        let loginVm = LoginViewModel()
        let _ = try XCTUnwrap(loginVm.makeVc() as UIViewController)
        
        
    }
}
