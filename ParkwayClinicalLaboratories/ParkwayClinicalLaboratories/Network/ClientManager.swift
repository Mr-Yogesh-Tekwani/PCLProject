//
//  ClientManager.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/12/23.
//

import Foundation

class ClientManager {
    
    var networkClient: NetworkClient
    
    init(networkClient: NetworkClient = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    // MARK: Create Account
    func createAccount(username: String, password: String, completion: @escaping (Bool) -> ()) {
        let body: [String: String] = [
            "UserName": username,
            "Password": password
        ]
        guard let request = networkClient.createRequest(url: createUserUrl!, body: body) else {
            return
        }
        
        networkClient.networkCall(request: request) { data in
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(Login.self, from: data!) {
                print("Create Account: ", String(describing: model.Result))
                if model.Result?.lowercased() == "username already exist" {
                    completion(false)
                }
                else{
                    print("Create Account Error !!! ", String(describing: model.Result))
                    completion(true)
                }
            }
        }
        
    }
    
    // MARK: Login Account
    
    func loginAccount(username: String, password: String, completion: @escaping (Bool) -> ()){
        
        var check = false
        let body: [String: String] = [
            "UserName": username,
            "Password": password
        ]
        guard let request = networkClient.createRequest(url: userLoginUrl!, body: body) else {
            completion(false)
            return
        }
        
        networkClient.networkCall(request: request) { data in
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(Login.self, from: data!) {
                print("Login Account: ", String(describing: model.Result))
                if model.Result == "Login successful"{
                    check = true
                    completion(true)
                    print("Check = ", check)
                }
                else{
                    print("Login Account Error !!! ", String(describing: model.Result))
                    completion(false)
                    
                }
            }
        }
        
    }
    
    
    // MARK: Add Customer
    
    func addCustomer(city: String?, cust_lad: Double?, cust_log: Double?, custName: String?, pickUpTime: String?, state: String?, street: String?, zip: Int?, completion: @escaping (Bool) -> ()) {
        
        var check = false
        let body: [String: Any] = [
            "City" : city ?? "",
            "Cust_Lat": cust_lad ?? 0.0 ,
            "Cust_Log": cust_log ?? 0.0,
            "CustomerName": custName ?? "",
            "PickupTime" : pickUpTime ?? "",
            "State" : state ?? "",
            "StreetAddress" : street ?? "",
            "Zip" : zip ?? 0
        ]
        guard let request = networkClient.createRequest(url: addCustomerUrl!, body: body) else {
            completion(false)
            return
        }
        
        networkClient.networkCall(request: request) { data in
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(Login.self, from: data!) {
                print("Add Customer: ", String(describing: model.Result))
                
                if model.Result == "success"{
                    check = true
                    completion(true)
                    print("Check = ", check)
                }
                else{
                    print("Add Customer Error !!!", String(describing: model.Result))
                    completion(false)
                    
                }
            }
        }
        
    }
    
    
    
    // MARK: Delete Customer
    
    func deleteCustomer(cId: Int, completion: @escaping (Bool) -> ()) {
        
        var check = false
        let body: [String: Int] = [
            "CustomerId": cId
        ]
        guard let request = networkClient.createRequest(url: makeDeleteCustomerUrl(custId: cId), body: body) else {
            completion(false)
            return
        }
        
        networkClient.networkCall(request: request) { data in
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(Login.self, from: data!) {
                print("Delete Customer: ", String(describing: model.Result))
                if model.Result == "success"{
                    check = true
                    completion(true)
                    print("Check = ", check)
                }
                else{
                    print("Delete Customer Error !!! ", String(describing: model.Result))
                    completion(false)
                    
                }
            }
        }
    }
    
    
    
    
    // MARK: Get Available Customer
    
    func getAvailableCustomer(completion: @escaping (GetAvailableCustomerArray?) -> ()){
        
        
        var request = URLRequest(url: getAvailableCustomerUrl!)
        request.httpMethod = "GET"
        
        networkClient.networkCall(request: request) { data in
            do{
                let decoder = JSONDecoder()
                if let model = try? decoder.decode(GetAvailableCustomerArray.self, from: data!) {
                    print("getAvailableCustomer Decoding Success !")
                    completion(model)
                }else{
                    print("getAvailableCustomer Decoding Error !!!")
                    completion(nil)
                }
                
            }
            
        }
    }
    
    
    
    // MARK: Get Customer
    
    func getCustomer(completion: @escaping (GetCustomerArray?) -> ()){
        
        
        var request = URLRequest(url: getCustomerUrl!)
        request.httpMethod = "GET"
        
        networkClient.networkCall(request: request) { data in
            do{
                let decoder = JSONDecoder()
                if let model = try? decoder.decode(GetCustomerArray.self, from: data!) {
                    print("getCustomer Decoding Success !")
                    completion(model)
                }else{
                    print("getCustomer Decoding Error !!!")
                    completion(nil)
                }
                
            }
            
        }
    }
    
    
    
    
    // MARK: Update Customer
    
    
    func updateCustomer(custId: Int, city: String?, cust_lad: Double?, cust_log: Double?, custName: String?, pickUpTime: String?, state: String?, street: String?, zip: Int?, completion: @escaping (Bool) -> ()) {
        
        var check = false
        var body: [String: Any] = [
            "CustomerId" : custId,
            "City" : city!,
            "Cust_Lat": cust_lad! ,
            "Cust_Log": cust_log!,
            "CustomerName": custName!,
            "PickupTime" : pickUpTime!,
            "State" : state!,
            "StreetAddress" : street!,
            "Zip" : zip!
        ]
        
        body = body.compactMapValues { $0 }
        
        
        guard let request = networkClient.createRequest(url: updateCustomerUrl!, body: body) else {
            completion(false)
            return
        }
        
        networkClient.networkCall(request: request) { data in
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(Login.self, from: data!) {
                print("Update Customer: ", String(describing: model.Result))
                
                if model.Result == "success"{
                    check = true
                    completion(true)
                    print("Check = ", check)
                }
                else{
                    print("Update Customer Error !!!: ", String(describing: model.Result))
                    completion(false)
                    
                }
            }
        }
        
    }
    
    
    
    // MARK: Add Route
    
    func addRoute(custId: Int, driverId: Int, routeName: String, vehicleNo: String, completion: @escaping (Bool) -> ()) {
        
        var check = false
        let body: [String: Any] = [
            "CustomerId" : custId,
            "DriverId": driverId,
            "RouteName" : routeName,
            "VehicleNo" : vehicleNo
        ]
        
        
        guard let request = networkClient.createRequest(url: addRouteUrl!, body: body) else {
            completion(false)
            return
        }
        
        networkClient.networkCall(request: request) { data in
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(Login.self, from: data!) {
                print("Add Route ", String(describing: model.Result))
                
                if model.Result == "success"{
                    check = true
                    completion(true)
                    print("Check = ", check)
                }
                else{
                    print("Add Route Error !!!: ", String(describing: model.Result))
                    completion(false)
                    
                }
            } else{
                print(String(data: data!, encoding: .utf8))
            }
        }
        
    }
    
    
    
    // MARK: Delete Route
    
    func deleteRoute(routeNum: Int, completion: @escaping (Bool) -> ()) {
        
        var check = false
        let body: [String: Any] = [
            "RouteNumber" : routeNum
        ]
        
        
        guard let request = networkClient.createRequest(url: makeDeleteRouteUrl(routeNumber: routeNum), body: body) else {
            completion(false)
            return
        }
        
        networkClient.networkCall(request: request) { data in
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(Login.self, from: data!) {
                print("Delete Route ", String(describing: model.Result))
                
                if model.Result == "success"{
                    check = true
                    completion(true)
                    print("Check = ", check)
                }
                else{
                    print("Delete Route Error !!!: ", String(describing: model.Result))
                    completion(false)
                    
                }
            }
        }
        
    }
    
    
    // MARK: Edit Route
    
    func editRoute(custId: Int, driverId: Int, routeName: String, routeNo: Int, vehicleNo: String, completion: @escaping (Bool) -> ()  ) {
        
        var check = false
        let body: [String: Any] = [
            "CustomerId" : custId,
            "DriverId": driverId,
            "RouteName" : routeName,
            "RouteNo" : routeNo,
            "VehicleNo" : vehicleNo
        ]
        
        
        guard let request = networkClient.createRequest(url: editRouteUrl!, body: body) else {
            completion(false)
            return
        }
        
        networkClient.networkCall(request: request) { data in
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(Login.self, from: data!) {
                print("Edit Route ", String(describing: model.Result))
                
                if model.Result == "success"{
                    check = true
                    completion(true)
                    print("Check = ", check)
                }
                else{
                    print("Edit Route Error !!!: ", String(describing: model.Result))
                    completion(false)
                    
                }
            }
        }
        
    }
    
    
    
    // MARK: Get Latest Route Number
    
    func getLatestRouteNumber(completion: @escaping (GetLatestRouteNumberDecoder?) -> ())  {
        
        
        var request = URLRequest(url: getLatestRouteNumberUrl!)
        request.httpMethod = "GET"
        
        networkClient.networkCall(request: request) { data in
            do{
                let decoder = JSONDecoder()
                if let model = try? decoder.decode(GetLatestRouteNumberDecoder.self, from: data!) {
                    print("getLatestRouteNumber Decoding Success !")
                    completion(model)
                }else{
                    print("getLatestRouteNumber Decoding Error !!!")
                    completion(nil)
                }
                
            }
            
        }
    }
    
    
    
    // MARK: Get Route
    
    func getRoute(completion: @escaping (GetRouteArray?) -> ()) {
        
        var request = URLRequest(url: getRouteUrl!)
        request.httpMethod = "GET"
        
        networkClient.networkCall(request: request) { data in
            do{
                let decoder = JSONDecoder()
                if let model = try? decoder.decode(GetRouteArray.self, from: data!) {
                    print("getRoute Decoding Success !")
                    completion(model)
                }else{
                    print("getRoute Decoding Error !!!")
                    completion(nil)
                }
                
            }
            
        }
    }
    
    
    
    // MARK: Get Route Detail
    
    
    func getRouteDetail(routeNum: Int, completion: @escaping (GetRouteArray?) -> ()) {
        
        let body: [String: Any] = [
            "RouteNumber" : routeNum
        ]
        
        
        guard let request = networkClient.createRequest(url: makeGetRouteDetailUrl(routeNumber: routeNum), body: body) else {
            completion(nil)
            return
        }
        
        networkClient.networkCall(request: request) { data in
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(GetRouteArray.self, from: data!) {
                print("getRouteDetail Route Decoding Success")
                completion(model)
            }
            
            else{
                print("Delete Route Error !!!: ")
                completion(nil)
            }
        }
    }
    
    
    
    // MARK: Add Update Transaction Status
    
    
    func addUpdateTransactionStatus(custId: Int, numOfSpec : Int, routeId: Int, stat: Int, update: String, completion: @escaping (Bool) -> ()) {
        
        var check = false
        let body: [String: Any] = [
            "CustomerId": custId,
            "NumberOfSpecimens": numOfSpec,
            "RouteId" : routeId,
            "Status" : stat,
            "UpdateBy": update
        ]
        
        
        guard let request = networkClient.createRequest(url: addUpdateTransactionStatusUrl!, body: body) else {
            completion(false)
            return
        }
        
        networkClient.networkCall(request: request) { data in
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(Login.self, from: data!) {
                print("addUpdateTransactionStatus Route ", String(describing: model.Result))
                
                if model.Result == "success"{
                    check = true
                    completion(true)
                    print("Check = ", check)
                }
                else{
                    print("addUpdateTransactionStatus Route Error !!!: ", String(describing: model.Result))
                    completion(false)
                    
                }
            }
        }
        
    }
    
    
    // MARK: Get Detail for Admin
    
    func getDetailForAdmin(completion: @escaping (GetDetailForAdminArray?) -> ()) {
        
        var request = URLRequest(url: getDetailForAdminUrl!)
        request.httpMethod = "GET"
        
        networkClient.networkCall(request: request) { data in
            print(String(data: data!, encoding: .utf8))
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(GetDetailForAdminArray.self, from: data!) {
                print("getDetailForAdmin Route Decoding Success")
                completion(model)
            }
            
            else{
                print("getDetailForAdmin Error !!!: ")
                completion(nil)
            }
        }
    }
    
    
    // MARK: Get Total Specimens Collected
    
    func getTotalSpecimensCollected(completion: @escaping (GetTotalSpecimensCollectedDecoder?) -> ()) {
        
        var request = URLRequest(url: getTotalSpecimensCollectedUrl!)
        request.httpMethod = "GET"
        
        networkClient.networkCall(request: request) { data in
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(GetTotalSpecimensCollectedDecoder.self, from: data!) {
                print("getTotalSpecimensCollected Route Decoding Success")
                completion(model)
            }
            
            else{
                print("getTotalSpecimensCollected Error !!!: ")
                completion(nil)
            }
        }
    }
    
    
    
    // MARK: Add Driver
    
    
    func addDriver(fname: String, lname: String, phNum: String,  completion: @escaping (Bool) -> ()) {
        
        var check = false
        let body: [String: Any] = [
            "FirstName": fname,
            "LastName": lname,
            "PhoneNumber" : phNum
        ]
        
        
        guard let request = networkClient.createRequest(url: addDriverUrl!, body: body) else {
            completion(false)
            return
        }
        
        networkClient.networkCall(request: request) { data in
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(Login.self, from: data!) {
                print("addDriver Route ", String(describing: model.Result))
                
                if model.Result == "success"{
                    check = true
                    completion(true)
                    print("Check = ", check)
                }
                else{
                    print("addDriver Route Error !!!: ", String(describing: model.Result))
                    completion(false)
                    
                }
            }
        }
        
    }
    
    
    // MARK: Add Driver Location
    
    func addDriverLocation(driverId: Int, geoFence: String, lat: Double, log: Double, completion: @escaping (Bool) -> ()) {
        
        var check = false
        let body: [String: Any] = [
            "DriverId": driverId,
            "Geofence": geoFence,
            "Lat" : lat,
            "Log": log
        ]
        
        
        guard let request = networkClient.createRequest(url: addDriverUrl!, body: body) else {
            completion(false)
            return
        }
        
        networkClient.networkCall(request: request) { data in
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(Login.self, from: data!) {
                print("addDriverLocation Route ", String(describing: model.Result))
                
                if model.Result == "success"{
                    check = true
                    completion(true)
                    print("Check = ", check)
                }
                else{
                    print("addDriverLocation Route Error !!!: ", String(describing: model.Result))
                    completion(false)
                    
                }
            }
        }
        
    }
    
    
    
    // MARK: Delete Driver
    
    
    func deleteDriver(dId: Int, completion: @escaping (Bool) -> ()) {
        
        var check = false
        let body: [String: Int] = [
            "DriverId": dId
        ]
        guard let request = networkClient.createRequest(url: makeDeleteDriverUrl(driverId: dId), body: body) else {
            completion(false)
            return
        }
        
        networkClient.networkCall(request: request) { data in
            let decoder = JSONDecoder()
            
            if let data = data{
            
            if let model = try? decoder.decode(Login.self, from: data) {
                print("delete Driver : ", String(describing: model.Result))
                if model.Result == "success"{
                    check = true
                    completion(true)
                    print("Check = ", check)
                }
                else{
                    print("delete Driver Error !!! ", String(describing: model.Result))
                    completion(false)
                    
                }
            }
            }
            else{
                print("Delete Driver Data Error !!!")
            }
        }
    }
    
    
    
    // MARK: Driver Login
    
    func driverLogin(phNum: String, pass: String , completion: @escaping (Bool) -> ()) {
        
        var check = false
        let body: [String: String] = [
            "PhoneNumber": phNum,
            "Password" : pass
        ]
        guard let request = networkClient.createRequest(url: driverLoginUrl!, body: body) else {
            completion(false)
            return
        }
        
        networkClient.networkCall(request: request) { data in
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(Login.self, from: data!) {
                print("driver Login : ", String(describing: model.Result))
                if model.Result == "success"{
                    check = true
                    completion(true)
                    print("Check = ", check)
                }
                else{
                    print("driver Login Error !!! ", String(describing: model.Result))
                    completion(false)
                    
                }
            }
        }
    }
    
    
    
    // MARK: Driver Sign Up
    
    func driverSignUp(phNum: String, pass: String , confirmPass: String, completion: @escaping (Bool) -> ()) {
        
        var check = false
        let body: [String: String] = [
            "PhoneNumber": phNum,
            "Password" : pass,
            "ConfirmPassword" : confirmPass
        ]
        guard let request = networkClient.createRequest(url: driverLoginUrl!, body: body) else {
            completion(false)
            return
        }
        
        networkClient.networkCall(request: request) { data in
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(Login.self, from: data!) {
                print("driver Login : ", String(describing: model.Result))
                if model.Result == "success"{
                    check = true
                    completion(true)
                    print("Check = ", check)
                }
                else{
                    print("driver Login Error !!! ", String(describing: model.Result))
                    completion(false)
                    
                }
            }
        }
    }
    
    
    // MARK: Get Available Driver
    
    func getAvailableDriver(completion: @escaping (GetAvailableDriverArray?) -> ()) {
        
        
        var request = URLRequest(url: getAvailableDriverUrl!)
        request.httpMethod = "GET"
        
        networkClient.networkCall(request: request) { data in
            do{
                let decoder = JSONDecoder()
                if let model = try? decoder.decode(GetAvailableDriverArray.self, from: data!) {
                    print("getAvailableDriver Decoding Success !")
                    completion(model)
                }else{
                    print("getAvailableDriver Decoding Error !!!")
                    completion(nil)
                }
                
            }
            
        }
    }
    
    
    // MARK: Get Driver
    
    func getDriver(completion: @escaping (GetAvailableDriverArray?) -> ()) {
        
        
        var request = URLRequest(url: getDriverUrl!)
        request.httpMethod = "GET"
        
        networkClient.networkCall(request: request) { data in
            do{
                let decoder = JSONDecoder()
                if let model = try? decoder.decode(GetAvailableDriverArray.self, from: data!) {
                    print("getDriver Decoding Success !")
                    completion(model)
                }else{
                    print("getDriver Decoding Error !!!")
                    completion(nil)
                }
                
            }
            
        }
    }
    
    
    // MARK: Get Driver Location
    
    func getDriverLocation(dId: Int, completion: @escaping (GetDriverLocationArray?) -> ()) {
        
        
        var request = URLRequest(url: makeGetDriverLocationUrl(driverId: dId))
        request.httpMethod = "GET"
        
        networkClient.networkCall(request: request) { data in
            do{
                let decoder = JSONDecoder()
                if let model = try? decoder.decode(GetDriverLocationArray.self, from: data!) {
                    print("getDriverLocation Decoding Success !")
                    completion(model)
                }else{
                    print("getDriverLocation Decoding Error !!!")
                    completion(nil)
                }
                
            }
            
        }
    }
    
    
    
    // MARK: UpdateDriver
    
    func updateDriver(fname: String, lname: String, dId: Int, phNum: String, completion: @escaping (Bool) -> ()) {
        
        var check = false
        let body: [String: Any] = [
            "PhoneNumber": phNum,
            "DriverId" : dId,
            "FirstName" : fname,
            "LastName": lname
        ]
        guard let request = networkClient.createRequest(url: updateDriverUrl!, body: body) else {
            completion(false)
            return
        }
        
        networkClient.networkCall(request: request) { data in
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(Login.self, from: data!) {
                print("update Driver : ", String(describing: model.Result))
                if model.Result == "success"{
                    check = true
                    completion(true)
                    print("Check = ", check)
                }
                else{
                    print("updateDriver Error !!! ", String(describing: model.Result))
                    completion(false)
                    
                }
            }
        }
    }
    
    
    
    
    
    // MARK: Add Vehicle
    
    func addVehicle(manuf: String, model: String, plateNum: String, vehicleId: Int, completion: @escaping (Bool) -> ()) {
        
        var check = false
        let body: [String: Any] = [
            "Manufacturer": manuf,
            "Model": model,
            "PlateNumber" : plateNum,
            "VehicleId": vehicleId
        ]
        guard let request = networkClient.createRequest(url: addVehicleUrl!, body: body) else {
            completion(false)
            return
        }
        
        networkClient.networkCall(request: request) { data in
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(Login.self, from: data!) {
                print("add Vehicle : ", String(describing: model.Result))
                if model.Result == "success"{
                    check = true
                    completion(true)
                    print("Check = ", check)
                }
                else{
                    print("add Vehicle Error !!! ", String(describing: model.Result))
                    completion(false)
                    
                }
            }
        }
    }
    
    
    
    // MARK: Delete Vehicle
    
    func deleteVehicle(vId: Int , completion: @escaping (Bool) -> ()) {
        
        var check = false
        let body: [String: Any] = [
            "VehicleId": vId
        ]
        guard let request = networkClient.createRequest(url: makeDeleteVehicleUrl(vehicleId: vId), body: body) else {
            completion(false)
            return
        }
        
        networkClient.networkCall(request: request) { data in
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(Login.self, from: data!) {
                print("Delete Vehicle : ", String(describing: model.Result))
                if model.Result == "success"{
                    check = true
                    completion(true)
                    print("Check = ", check)
                }
                else{
                    print("Delete Vehicle Error !!! ", String(describing: model.Result))
                    completion(false)
                    
                }
            }
        }
    }
    
    
    
    // MARK: Get Available Vehicle
    
    func getAvailableVehicle(completion: @escaping (GetAvailableVehicleArray?) -> ()) {
        
        
        var request = URLRequest(url: getAvailableVehicleUrl!)
        request.httpMethod = "GET"
        
        networkClient.networkCall(request: request) { data in
            do{
                let decoder = JSONDecoder()
                if let model = try? decoder.decode(GetAvailableVehicleArray.self, from: data!) {
                    print("get Available Vehicle Decoding Success !")
                    completion(model)
                }else{
                    print("get Available Vehicle Decoding Error !!!")
                    completion(nil)
                }
                
            }
            
        }
    }
    
    
    
    
    // MARK: Get Vehicle
    
    func getVehicle(completion: @escaping (GetAvailableVehicleArray?) -> ()) {
        
        
        var request = URLRequest(url: getVehicleUrl!)
        request.httpMethod = "GET"
        
        networkClient.networkCall(request: request) { data in
            do{
                let decoder = JSONDecoder()
                if let model = try? decoder.decode(GetAvailableVehicleArray.self, from: data!) {
                    print("get Vehicle Decoding Success !")
                    completion(model)
                }else{
                    print("get Vehicle Decoding Error !!!")
                    completion(nil)
                }
                
            }
            
        }
    }
    
    
    
    
    
    
    // MARK: Update Vehicle
    
    
    func updateVehicle(manuf: String, model: String, plateNum: String, vehicleId: Int, completion: @escaping (Bool) -> ()) {
        
        var check = false
        var body: [String: Any] = [
            "Manufacturer": manuf,
            "Model": model,
            "PlateNumber" : plateNum,
            "VehicleId": vehicleId
        ]
        
        body = body.compactMapValues { $0 }
        
        
        guard let request = networkClient.createRequest(url: updateVehicleUrl!, body: body) else {
            completion(false)
            return
        }
        
        networkClient.networkCall(request: request) { data in
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(Login.self, from: data!) {
                print("Update Vehicle: ", String(describing: model.Result))
                
                if model.Result == "success"{
                    check = true
                    completion(true)
                    print("Check = ", check)
                }
                else{
                    print("Update Vehicle Error !!!: ", String(describing: model.Result))
                    completion(false)
                    
                }
            }
        }
        
    }
    
    
    
    
    
    
    
    
    
}




