//
//  ParkingLotTests.swift
//  ParkingLotTests
//
//  Created by Gagan Singh on 6/24/23.
//

import XCTest
@testable import ParkingLot

final class ParkingLotTests: XCTestCase {

    func testCount() {
        let lot = ParkingLot(smallSpaces: 5, mediumSpaces: 5, largeSpaces: 1)
        XCTAssertEqual(lot.totalSpots, 11)
        XCTAssertEqual(lot.parkingLotIsEmpty, true)
        XCTAssertEqual(lot.parkingLotIsFull, false)
    }

    func testErrors() {
        // parking in 0 init lot should throw error
        var lot = ParkingLot(smallSpaces: 0, mediumSpaces: 0, largeSpaces: 0)
        let motorcycle = Motorcycle()
        XCTAssertThrowsError(try lot.park(vehicle: motorcycle))

        //unparking non-parked vehicle should throw error
        lot = ParkingLot(smallSpaces: 0, mediumSpaces: 0, largeSpaces: 0)
        XCTAssertThrowsError(try lot.unpark(vehicle: motorcycle))
    }

    func testSimplePark() {
        let lot = ParkingLot(smallSpaces: 5, mediumSpaces: 5, largeSpaces: 1)
        let car = Car()
        XCTAssertNoThrow(try lot.park(vehicle: car))
        XCTAssertEqual(lot.parkingLotIsEmpty, false)
        XCTAssertEqual(lot.parkingLotIsFull, false)
        XCTAssertEqual(lot.spotsRemaining, 10)
    }

    func testVan() {
        let lot = ParkingLot(smallSpaces: 5, mediumSpaces: 5, largeSpaces: 1)
        let van = Van()
        XCTAssertNoThrow(try lot.park(vehicle: van))
        XCTAssertEqual(lot.spotsRemaining, 10)

        let van2 = Van()
        XCTAssertNoThrow(try lot.park(vehicle: van2))
        XCTAssertEqual(lot.spotsRemaining, 7)

        XCTAssertNoThrow(try lot.unpark(vehicle: van))
        XCTAssertEqual(lot.spotsRemaining, 8)

        XCTAssertNoThrow(try lot.unpark(vehicle: van2))
        XCTAssertEqual(lot.spotsRemaining, 11)
    }

}
