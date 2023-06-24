//
//  ParkingLot.swift
//  ParkingLot
//
//  Created by Gagan Singh on 6/24/23.
//

import Foundation

class ParkingSpace {
    let size: Size
    var vehicle: Vehicle?

    internal init(size: Size, vehicle: Vehicle? = nil) {
        self.size = size
        self.vehicle = vehicle
    }

}

struct ParkingLot {
    var spaces: [ParkingSpace]

    init(smallSpaces: Int, mediumSpaces: Int, largeSpaces: Int) {
        spaces = []
        for _ in 0..<smallSpaces {
            spaces.append(ParkingSpace(size: .small))
        }
        for _ in 0..<mediumSpaces {
            spaces.append(ParkingSpace(size: .medium))
        }
        for _ in 0..<largeSpaces {
            spaces.append(ParkingSpace(size: .large))
        }
    }

    var spotsRemaining: Int {
        spaces.filter { $0.vehicle == nil }.count
    }

    var totalSpots: Int {
        spaces.count
    }

    var parkingLotIsFull: Bool {
        spotsRemaining == 0
    }

    var parkingLotIsEmpty: Bool {
        spotsRemaining == totalSpots
    }

    func isFull(size: Size) -> Bool {
        let spaces = spaces.filter{ $0.size == size }
        return (spaces.filter{ $0.vehicle == nil }.count == 0)
    }

    func spotsVansTakingUp() -> Int {
        let spacesOccupied = spaces.filter{ $0.vehicle != nil }
        return spacesOccupied.filter{ $0.vehicle!.size == .large }.count
    }


    func park(vehicle: Vehicle) throws {
        switch vehicle.size {
        case .small, .medium:
            guard let emptySpace = spaces.first(where: { $0.vehicle == nil }) else {
                throw ParkingError.noSpotsAvailable
            }
            emptySpace.vehicle = vehicle
        case .large:
            if let emptyLargeSpace = spaces.first(where: {$0.vehicle == nil && $0.size == .large}) {
                emptyLargeSpace.vehicle = vehicle
            }
            else {
                let spots = try find3ContiguousMediumSpaces()
                spots.forEach { $0.vehicle = vehicle }
            }
        }
    }

    func unpark(vehicle: Vehicle) throws {
        let spaces = spaces
            .filter{$0.vehicle != nil}
            .filter{ $0.vehicle!.isEqualTo(vehicle: vehicle) }
        if spaces.isEmpty {
            throw ParkingError.vehicleNotFound
        }
        spaces.forEach{$0.vehicle = nil}
    }

    // find an empty medium spot, if the next two in the array are also empty, return all 3 spots
    func find3ContiguousMediumSpaces() throws -> [ParkingSpace] {
        for (i, space) in spaces.enumerated() {
            if space.size == .medium && space.vehicle == nil {
                if let secondSpace = spaces[safe: i+1] {
                    if let thirdSpace = spaces[safe: i+2] {
                        let group = [space, secondSpace, thirdSpace]
                        if group.allSatisfy({ $0.vehicle == nil }) {
                            return group
                        }
                    }
                }
            }
        }
        throw ParkingError.noSpotsAvailable
    }
}
