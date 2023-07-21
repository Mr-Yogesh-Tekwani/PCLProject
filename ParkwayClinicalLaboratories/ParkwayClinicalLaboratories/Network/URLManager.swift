//
//  URLManager.swift
//  ParkwayClinicalLaboratories
//
//  Created by Yogesh on 7/12/23.
//

import Foundation

var link = "https://gapinternationalwebapi20200521010239.azurewebsites.net"
var url = URL(string: link)

var createUserLink = link + "/api/User/CreateUserAccount"
var createUserUrl = URL(string: createUserLink)

var userLoginLink = link + "/api/User/UserLogin"
var userLoginUrl = URL(string: userLoginLink)


var addCustomerLink = "https://pclwebapi.azurewebsites.net/api/Customer/AddCustomer"
var addCustomerUrl = URL(string: addCustomerLink)

func makeDeleteCustomerUrl(custId: Int) -> URL{
    
    let id = "\(custId)"
    let deleteCustomerLink = "https://pclwebapi.azurewebsites.net/api/Customer/DeleteCustomer/?CustomerId=" + id
    return URL(string: deleteCustomerLink) ?? URL(string: "google.com")!

}

var getAvailableCustomerLink = "https://pclwebapi.azurewebsites.net/api/Customer/GetAvailableCustomer"
var getAvailableCustomerUrl = URL(string: getAvailableCustomerLink)


var getCustomerLink = "https://pclwebapi.azurewebsites.net/api/Customer/GetCustomer"
var getCustomerUrl = URL(string: getCustomerLink)

let updateCustomerLink = "https://pclwebapi.azurewebsites.net/api/Customer/UpdateCustomer"
let updateCustomerUrl = URL(string: updateCustomerLink)


let addRouteLink = "https://pclwebapi.azurewebsites.net/api/Route/AddRoute"
let addRouteUrl = URL(string: addRouteLink)

func makeDeleteRouteUrl(routeNumber: Int) -> URL{
    
    let id = "\(routeNumber)"
    let deleteRouteLink = "https://pclwebapi.azurewebsites.net/api/Route/DeleteRoute/?RouteNumber=" + id
    return URL(string: deleteRouteLink) ?? URL(string: "google.com")!

}


let editRouteLink = "https://pclwebapi.azurewebsites.net/api/Route/EditRoute"
let editRouteUrl = URL(string: editRouteLink)

let getLatestRouteNumberLink = "https://pclwebapi.azurewebsites.net/api/Route/GetLatestRouteNumber"
let getLatestRouteNumberUrl = URL(string: getLatestRouteNumberLink)


let getRouteLink = "https://pclwebapi.azurewebsites.net/api/Route/GetRoute"
let getRouteUrl = URL(string: getRouteLink)


func makeGetRouteDetailUrl(routeNumber: Int) -> URL{
    
    let id = "\(routeNumber)"
    let getRouteLink = "https://pclwebapi.azurewebsites.net/api/Route/GetRouteDetail/?RouteNumber=" + id
    return URL(string: getRouteLink) ?? URL(string: "google.com")!

}

let addUpdateTransactionStatusLink = "https://pclwebapi.azurewebsites.net/api/Admin/AddUpdateTransactionStatus"
let addUpdateTransactionStatusUrl = URL(string: addUpdateTransactionStatusLink)

let getDetailForAdminLink = "https://pclwebapi.azurewebsites.net/api/Admin/GetDetailForAdmin"
let getDetailForAdminUrl = URL(string: getDetailForAdminLink)

let getTotalSpecimensCollectedLink = "https://pclwebapi.azurewebsites.net/api/Admin/GetTotalSpecimensCollected"
let getTotalSpecimensCollectedUrl = URL(string: getTotalSpecimensCollectedLink)


let addDriverLink = "https://pclwebapi.azurewebsites.net/api/Driver/AddDriver"
let addDriverUrl = URL(string: addDriverLink)


let addDriverLocationLink = "https://pclwebapi.azurewebsites.net/api/Driver/AddDriverLocation"
let addDriverLocationUrl = URL(string: addDriverLocationLink)


func makeDeleteDriverUrl(driverId: Int) -> URL{
    
    let id = "\(driverId)"
    let deleteDriverLink = "https://pclwebapi.azurewebsites.net/api/Driver/DeleteDriver/?DriverId=" + id
    return URL(string: deleteDriverLink) ?? URL(string: "google.com")!

}


let driverLoginLink = "https://pclwebapi.azurewebsites.net/api/Driver/DriverLogin"
let driverLoginUrl = URL(string: driverLoginLink)


let driverSignUpLink = "https://pclwebapi.azurewebsites.net/api/Driver/DriverSignUp"
let driverSignUpUrl = URL(string: driverSignUpLink)

let getAvailableDriverLink = "https://pclwebapi.azurewebsites.net/api/Driver/GetAvailableDriver"
let getAvailableDriverUrl = URL(string: getAvailableDriverLink)


let getDriverLink = "https://pclwebapi.azurewebsites.net/api/Driver/GetDriver"
let getDriverUrl = URL(string: getDriverLink)

func makeGetDriverLocationUrl(driverId: Int) -> URL{
    
    let id = "\(driverId)"
    let link = "https://pclwebapi.azurewebsites.net/api/Driver/GetDriverLocation?DriverId=" + id
    return URL(string: link) ?? URL(string: "google.com")!

}


let updateDriverLink = "https://pclwebapi.azurewebsites.net/api/Driver/UpdateDriver"
let updateDriverUrl = URL(string: updateDriverLink)


let addVehicleLink = "https://pclwebapi.azurewebsites.net/api/vehicle/AddVehicle"
let addVehicleUrl = URL(string: addVehicleLink)


func makeDeleteVehicleUrl(vehicleId: Int) -> URL{
    
    let id = "\(vehicleId)"
    let deleteVehicleLink = "https://pclwebapi.azurewebsites.net/api/vehicle/DeleteVehicle?VehicleId=" + id
    return URL(string: deleteVehicleLink) ?? URL(string: "google.com")!

}


let getAvailableVehicleLink = "https://pclwebapi.azurewebsites.net/api/vehicle/GetAvailableVehicle"
let getAvailableVehicleUrl = URL(string: getAvailableVehicleLink)


let getVehicleLink = "https://pclwebapi.azurewebsites.net/api/vehicle/GetVehicle"
let getVehicleUrl = URL(string: getVehicleLink)


let updateVehicleLink = "https://pclwebapi.azurewebsites.net/api/vehicle/UpdateVehicle"
let updateVehicleUrl = URL(string: updateVehicleLink)


















































