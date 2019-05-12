//
//  NutReaderTests.swift
//  NutReaderTests
//
//  Created by Frank Schmitt on 5/7/19.
//  Copyright © 2019 Nut Codes. All rights reserved.
//

import XCTest
@testable import NutReader

class NutCodeTest: XCTestCase {
    var food: Food!

    override func setUp() {
        food = Food(fat: 1, carbohydrates: 2, protein: 3)
        food.magnesium = 0.022;
    }
    
    func testBigMac() {
        var bigMacSample = Food(fat:14.96, carbohydrates: 20.08, protein: 11.82)
        bigMacSample.sugar = 3.97
        bigMacSample.fiber = 1.6
        bigMacSample.calcium = 0.116
        bigMacSample.iron = 0.002
        bigMacSample.magnesium = 0.02
        bigMacSample.phosphorus = 0.122
        bigMacSample.potassium = 0.181
        bigMacSample.sodium = 0.46
        bigMacSample.zinc = 0.00191
        bigMacSample.copper = 0.000098
        bigMacSample.manganese = 0.000206
        bigMacSample.vitaminC = 0.0004
        bigMacSample.thiamin = 0.000176
        bigMacSample.riboflavin = 0.000209
        bigMacSample.niacin = 0.003384
        bigMacSample.folate = 0.000046
        bigMacSample.vitaminB12 = 0.00000088
        bigMacSample.cholesterol = 0.036
        bigMacSample.fatSaturated = 3.803
        bigMacSample.fatMonounsaturated = 3.474
        bigMacSample.fatPolyunsaturated = 0.306

		let bigMac = Serving(food: bigMacSample, mass: 219)

        let code = NutCode.urlify(bigMac)
        
        guard let decodedServing = NutCode.parse(url: code) as? Serving else {
            XCTFail()
            return
        }

		let decodedFood = decodedServing.food

        XCTAssertEqual(decodedFood.fatTotal, 14.96, accuracy: 0.4)
        XCTAssertEqual(decodedFood.carbohydrates, 20.08, accuracy: 0.4)
        XCTAssertEqual(decodedFood.protein, 11.82, accuracy: 0.4)
        XCTAssertEqual(decodedFood.sugar, 3.97, accuracy: 0.4)
        XCTAssertEqual(decodedFood.fiber, 1.6, accuracy: 0.4)
        XCTAssertEqual(decodedFood.sugar, 3.97, accuracy: 0.4)
		XCTAssertEqual(decodedFood.fatSaturated, 3.803, accuracy: 0.4)
		XCTAssertEqual(decodedFood.fatMonounsaturated, 3.474, accuracy: 0.4)
		XCTAssertEqual(decodedFood.fatPolyunsaturated, 0.306, accuracy: 0.4)

        XCTAssertEqual(decodedFood.calcium, 0.116, accuracy: 0.116 * 0.02)
        XCTAssertEqual(decodedFood.iron, 0.002, accuracy: 0.002 * 0.02)
        XCTAssertEqual(decodedFood.magnesium, 0.02, accuracy: 0.02 * 0.02)
        XCTAssertEqual(decodedFood.phosphorus, 0.122, accuracy: 0.122 * 0.02)
        XCTAssertEqual(decodedFood.potassium, 0.181, accuracy: 0.181 * 0.02)
        XCTAssertEqual(decodedFood.sodium, 0.46, accuracy: 0.46 * 0.02)
        XCTAssertEqual(decodedFood.zinc, 0.00191, accuracy: 0.00191 * 0.02)
        XCTAssertEqual(decodedFood.copper, 0.000098, accuracy: 0.000098 * 0.03)
        XCTAssertEqual(decodedFood.manganese, 0.000206, accuracy: 0.000206 * 0.03)
        XCTAssertEqual(decodedFood.vitaminC, 0.0004, accuracy: 0.0004 * 0.02)
        XCTAssertEqual(decodedFood.thiamin, 0.000176, accuracy: 0.000176 * 0.03)
        XCTAssertEqual(decodedFood.riboflavin, 0.000209, accuracy: 0.000209 * 0.03)
        XCTAssertEqual(decodedFood.niacin, 0.003384, accuracy: 0.003384 * 0.03)
        XCTAssertEqual(decodedFood.folate, 0.000046, accuracy: 0.000046 * 0.03)
        XCTAssertEqual(decodedFood.vitaminB12, 0.00000088, accuracy: 0.00000088 * 0.02)
        XCTAssertEqual(decodedFood.cholesterol, 0.036, accuracy: 0.036 * 0.02)

		XCTAssertEqual(decodedServing.mass, 219, accuracy: 0.4)
    }

	func assertEqual(lhs: Float, rhs: Float, percentAccuracy: Float) {
		XCTAssertEqual(lhs, rhs, accuracy: rhs * percentAccuracy / 100)
	}
}

