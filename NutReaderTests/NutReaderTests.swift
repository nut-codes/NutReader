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
        var bigMac = Food(fat:14.96, carbohydrates: 20.08, protein: 11.82)
        bigMac.sugar = 3.97
        bigMac.fiber = 1.6
        bigMac.calcium = 0.116
        bigMac.iron = 0.002
        bigMac.magnesium = 0.02
        bigMac.phosphorus = 0.122
        bigMac.potassium = 0.181
        bigMac.sodium = 0.46
        bigMac.zinc = 0.00191
        bigMac.copper = 0.000098
        bigMac.manganese = 0.000206
        bigMac.vitaminC = 0.0004
        bigMac.thiamin = 0.000176
        bigMac.riboflavin = 0.000209
        bigMac.niacin = 0.003384
        bigMac.folate = 0.000046
        bigMac.vitaminB12 = 0.00000088
        bigMac.cholesterol = 0.036
        bigMac.fatSaturated = 3.803
        bigMac.fatMonounsaturated = 3.474
        bigMac.fatPolyunsaturated = 0.306

        let code = NutCode.urlify(bigMac)
        
        guard let decodedFood = NutCode.parse(url: code) as? Food else {
            XCTFail()
            return
        }
    
        XCTAssertEqual(decodedFood.fatTotal, 14.96, accuracy: 0.1)
        XCTAssertEqual(decodedFood.carbohydrates, 20.08, accuracy: 0.1)
        XCTAssertEqual(decodedFood.protein, 11.82, accuracy: 0.1)
        XCTAssertEqual(decodedFood.sugar, 3.97, accuracy: 0.1)
        XCTAssertEqual(decodedFood.fiber, 1.6, accuracy: 0.1)
        
        XCTAssertEqual(decodedFood.sugar, 3.97, accuracy: 0.1)
        XCTAssertEqual(decodedFood.fiber, 1.6, accuracy: 0.1)
        XCTAssertEqual(decodedFood.calcium, 0.116, accuracy: 0.002)
        XCTAssertEqual(decodedFood.iron, 0.002, accuracy: 0.002)
        XCTAssertEqual(decodedFood.magnesium, 0.02, accuracy: 0.002)
        XCTAssertEqual(decodedFood.phosphorus, 0.122, accuracy: 0.002)
        XCTAssertEqual(decodedFood.potassium, 0.181, accuracy: 0.002)
        XCTAssertEqual(decodedFood.sodium, 0.46, accuracy: 0.002)
        XCTAssertEqual(decodedFood.zinc, 0.00191, accuracy: 0.002)
        XCTAssertEqual(decodedFood.copper, 0.000098, accuracy: 0.002)
        XCTAssertEqual(decodedFood.manganese, 0.000206, accuracy: 0.002)
        XCTAssertEqual(decodedFood.vitaminC, 0.0004, accuracy: 0.002)
        XCTAssertEqual(decodedFood.thiamin, 0.000176, accuracy: 0.002)
        XCTAssertEqual(decodedFood.riboflavin, 0.000209, accuracy: 0.002)
        XCTAssertEqual(decodedFood.niacin, 0.003384, accuracy: 0.002)
        XCTAssertEqual(decodedFood.folate, 0.000046, accuracy: 0.002)
        XCTAssertEqual(decodedFood.vitaminB12, 0.00000088, accuracy: 0.002)
        XCTAssertEqual(decodedFood.cholesterol, 0.036, accuracy: 0.002)
        XCTAssertEqual(decodedFood.fatSaturated, 3.803, accuracy: 0.2)
        XCTAssertEqual(decodedFood.fatMonounsaturated, 3.474, accuracy: 0.1)
        XCTAssertEqual(decodedFood.fatPolyunsaturated, 0.306, accuracy: 0.1)
    }
}
