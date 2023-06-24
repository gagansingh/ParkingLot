//
//  Vehicles.swift
//  ParkingLot
//
//  Created by Gagan Singh on 6/24/23.
//

import Foundation

protocol Vehicle {
    var id: UUID { get }
    var size: Size { get }
    func isEqualTo(vehicle: Vehicle) -> Bool
}

extension Vehicle {
    func isEqualTo(vehicle: Vehicle) -> Bool {
        return self.id == vehicle.id 
    }
}

struct Motorcycle: Vehicle {
    let id: UUID = UUID()
    let size: Size = .small
}

struct Car: Vehicle {
    let id: UUID = UUID()
    let size: Size = .medium
}

struct Van: Vehicle {
    let id: UUID = UUID()
    let size: Size = .large
}

