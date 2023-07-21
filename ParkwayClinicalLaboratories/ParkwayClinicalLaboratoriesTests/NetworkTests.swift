//
//  NetworkTests.swift
//  ParkwayClinicalLaboratoriesTests
//
//  Created by Yogesh on 7/21/23.
//

import Foundation
import UIKit
import XCTest
@testable import ParkwayClinicalLaboratories

class NetworkLayerTests: XCTestCase {

    // Login tests
    
    func testLoginSuccess() throws {
        let mockNetwork = MockNetwork()
        let networkClient = NetworkClient(network: mockNetwork)
        let client = ClientManager(networkClient: networkClient)
        
        // Signal
        let callCompletedSignal = expectation(description: "Login")

        var result : Bool = false
        
        client.loginAccount(username: "Sahil123", password: "Sahil123", completion: { check in
            result = check
            callCompletedSignal.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(result)
        XCTAssertEqual(result, true)
    }
    
    
    func testAddCustomer() throws {
        let mockNetwork = MockNetwork()
        let networkClient = NetworkClient(network: mockNetwork)
        let client = ClientManager(networkClient: networkClient)
        
        // Signal
        let callCompletedSignal = expectation(description: "Add Customer")

        var result : Bool = false
        
        client.addCustomer(city: "NYC", cust_lad: 10.4, cust_log: 99.4, custName: "Yogesh", pickUpTime: "10:30 AM", state: "NY", street: "200 Vincent", zip: 13210, completion: { check in
            result = check
            callCompletedSignal.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(result)
        XCTAssertEqual(result, true)
    }

    func testDeleteCustomer() throws {
        let mockNetwork = MockNetwork()
        let networkClient = NetworkClient(network: mockNetwork)
        let client = ClientManager(networkClient: networkClient)
        
        // Signal
        let callCompletedSignal = expectation(description: "Delete Customer")

        var result : Bool = false
        
        client.deleteCustomer(cId: 160, completion: { check in
            result = check
            callCompletedSignal.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(result)
        XCTAssertEqual(result, true)
    }
    
    func testGetAvailableCustomer() throws {
        let mockNetwork = MockNetwork()
        let networkClient = NetworkClient(network: mockNetwork)
        let client = ClientManager(networkClient: networkClient)
        
        // Signal
        let callCompletedSignal = expectation(description: "Add Customer")

        var result : GetAvailableCustomerArray?
        
        client.getAvailableCustomer(completion: { check in
            result = check
            callCompletedSignal.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.count, 15)
    }
    
    func testUpdateCustomer() throws {
        let mockNetwork = MockNetwork()
        let networkClient = NetworkClient(network: mockNetwork)
        let client = ClientManager(networkClient: networkClient)
        
        // Signal
        let callCompletedSignal = expectation(description: "Add Customer")

        var result : Bool = false
        
        client.updateCustomer(custId: 119, city: "NYC", cust_lad: 10.4, cust_log: 99.4, custName: "Yogesh", pickUpTime: "10:30 AM", state: "NY", street: "200 Vincent", zip: 13210, completion: { check in
            result = check
            callCompletedSignal.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(result)
        XCTAssertEqual(result, true)
    }
    
    func testAddRoute() throws {
        let mockNetwork = MockNetwork()
        let networkClient = NetworkClient(network: mockNetwork)
        let client = ClientManager(networkClient: networkClient)
        
        // Signal
        let callCompletedSignal = expectation(description: "Add Customer")

        var result : Bool = false
        
        client.addRoute(custId: 119, driverId: 129, routeName: "200 Vincent Street", vehicleNo: "MH 7290", completion: { check in
            result = check
            callCompletedSignal.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(result)
        XCTAssertEqual(result, true)
    }
    
    
    func testDeleteRoute() throws {
        let mockNetwork = MockNetwork()
        let networkClient = NetworkClient(network: mockNetwork)
        let client = ClientManager(networkClient: networkClient)
        
        // Signal
        let callCompletedSignal = expectation(description: "Add Customer")

        var result : Bool = false
        
        client.deleteRoute(routeNum: 85, completion: { check in
            result = check
            callCompletedSignal.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(result)
        XCTAssertEqual(result, true)
    }
    
    
    func testGetLatestRouteNum() throws {
        let mockNetwork = MockNetwork()
        let networkClient = NetworkClient(network: mockNetwork)
        let client = ClientManager(networkClient: networkClient)
        
        // Signal
        let callCompletedSignal = expectation(description: "Add Customer")

        var result : GetLatestRouteNumberDecoder?
        
        client.getLatestRouteNumber( completion: { check in
            result = check
            callCompletedSignal.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.routeNo, 1)
    }
    
    
    func testGetRouteResults() throws {
        let mockNetwork = MockNetwork()
        let networkClient = NetworkClient(network: mockNetwork)
        let client = ClientManager(networkClient: networkClient)
        
        // Signal
        let callCompletedSignal = expectation(description: "Add Customer")

        var result : GetRouteArray?
        
        client.getRoute( completion: { check in
            result = check
            callCompletedSignal.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.count, 16)
    }
    
    func testTotalSpecimen() throws {
        let mockNetwork = MockNetwork()
        let networkClient = NetworkClient(network: mockNetwork)
        let client = ClientManager(networkClient: networkClient)
        
        // Signal
        let callCompletedSignal = expectation(description: "Add Customer")

        var result : GetTotalSpecimensCollectedDecoder?
        
        client.getTotalSpecimensCollected( completion: { check in
            result = check
            callCompletedSignal.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.TotalNumberOfSpecimens, 100)
    }
    
    
    func testAddDriver() throws {
        let mockNetwork = MockNetwork()
        let networkClient = NetworkClient(network: mockNetwork)
        let client = ClientManager(networkClient: networkClient)
        
        // Signal
        let callCompletedSignal = expectation(description: "Add Driver")

        var result : Bool = false
        
        client.addDriver(fname: "Driver", lname: "100", phNum: "9890908822", completion: { check in
            result = check
            callCompletedSignal.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(result)
        XCTAssertEqual(result, true)
    }
    
    func testDeleteDriver() throws {
        let mockNetwork = MockNetwork()
        let networkClient = NetworkClient(network: mockNetwork)
        let client = ClientManager(networkClient: networkClient)
        
        // Signal
        let callCompletedSignal = expectation(description: "Delete Driver")

        var result : Bool = false
        
        client.deleteDriver(dId: 129 ,completion: { check in
            result = check
            callCompletedSignal.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(result)
        XCTAssertEqual(result, true)
    }
    
    
    func testGetDriverResults() throws {
        let mockNetwork = MockNetwork()
        let networkClient = NetworkClient(network: mockNetwork)
        let client = ClientManager(networkClient: networkClient)
        
        // Signal
        let callCompletedSignal = expectation(description: "Add Customer")

        var result : GetAvailableDriverArray?
        
        client.getDriver(completion: { check in
            result = check
            callCompletedSignal.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.count, 20)
    }
    
    func testGetDriverLocation() throws {
        let mockNetwork = MockNetwork()
        let networkClient = NetworkClient(network: mockNetwork)
        let client = ClientManager(networkClient: networkClient)
        
        // Signal
        let callCompletedSignal = expectation(description: "Add Customer")

        var result : GetDriverLocationArray?
        
        client.getDriverLocation(dId: 129, completion: { check in
            result = check
            callCompletedSignal.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?[0].lat, 0.0)
    }
    
    
    func testUpdateDriver() throws {
        let mockNetwork = MockNetwork()
        let networkClient = NetworkClient(network: mockNetwork)
        let client = ClientManager(networkClient: networkClient)
        
        // Signal
        let callCompletedSignal = expectation(description: "Delete Driver")

        var result : Bool = false
        
        client.updateDriver(fname: "Driver", lname: "100", dId: 129, phNum: "9890908822",completion: { check in
            result = check
            callCompletedSignal.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(result)
        XCTAssertEqual(result, true)
    }
    
    func testAddVehicle() throws {
        let mockNetwork = MockNetwork()
        let networkClient = NetworkClient(network: mockNetwork)
        let client = ClientManager(networkClient: networkClient)
        
        // Signal
        let callCompletedSignal = expectation(description: "Delete Driver")

        var result : Bool = false
        
        client.addVehicle(manuf: "Honda", model: "Civic", plateNum: "MH 7891", vehicleId: 29, completion: { check in
            result = check
            callCompletedSignal.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(result)
        XCTAssertEqual(result, true)
    }
    
    func testDeleteVehicle() throws {
        let mockNetwork = MockNetwork()
        let networkClient = NetworkClient(network: mockNetwork)
        let client = ClientManager(networkClient: networkClient)
        
        // Signal
        let callCompletedSignal = expectation(description: "Delete Driver")

        var result : Bool = false
        
        client.deleteVehicle(vId: 29, completion: { check in
            result = check
            callCompletedSignal.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(result)
        XCTAssertEqual(result, true)
    }
    
    
    func testUpdateVehicle() throws {
        let mockNetwork = MockNetwork()
        let networkClient = NetworkClient(network: mockNetwork)
        let client = ClientManager(networkClient: networkClient)
        
        // Signal
        let callCompletedSignal = expectation(description: "Delete Driver")

        var result : Bool = false
        
        client.updateVehicle(manuf: "Honda", model: "Civic", plateNum: "MH 7891", vehicleId: 29, completion: { check in
            result = check
            callCompletedSignal.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(result)
        XCTAssertEqual(result, true)
    }
    
    
    func testGetVehicleResults() throws {
        let mockNetwork = MockNetwork()
        let networkClient = NetworkClient(network: mockNetwork)
        let client = ClientManager(networkClient: networkClient)
        
        // Signal
        let callCompletedSignal = expectation(description: "Add Customer")

        var result : GetAvailableVehicleArray?
        
        client.getVehicle(completion: { check in
            result = check
            callCompletedSignal.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.count, 20)
    }
    
    
}
