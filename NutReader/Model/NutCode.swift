//
//  NutCode.swift
//  NutReader
//
//  Created by Frank Schmitt on 5/7/19.
//  Copyright © 2019 Nut Codes. All rights reserved.
//

import Foundation

class NutCode {
    class var version: UInt8 {
        get {
            return 1
        }
    }
    
    class func urlify(_ food: Food) -> URL {
        return URL(string: "nut://\(data(for: food).base64EncodedString())")!
    }
    
    class func urlify(_ serving: Serving) -> URL {
        var result = data(for: serving.food)
        result.append(contentsOf: [])
        return URL(string: "nut://\(result.base64EncodedString())")!
    }
    
    private class func data(for food: Food) -> Data {
        var result = Data()
        
        result.append(NutCode.version)
        
        result.append(contentsOf: Nutrient.standard.compactMap {
            food.byte(for: $0)
        })
        
        let extendedCodes: [[UInt8]] = Nutrient.extended.compactMap {
            guard let quantity = food.byte(for: $0), let code = $0.code, quantity > 0 else {
                return nil
            }
            
            return [code, quantity]
        }
        
        result.append(contentsOf: extendedCodes.joined())
        
        return result
    }
    
    class func parse(url: URL) -> FoodOrServing? {
        guard url.scheme?.lowercased() == "nut" else {
            print("Code scheme is not “nut”")
            return nil
        }
        
        guard let code = url.host, let data = Data(base64Encoded: code) else {
            print("Unable to base-64 decode")
            return nil
        }
        
        let codeVersion = data[0]
        
        guard codeVersion <= NutCode.version else {
            print("Incompatible version of code")
            return nil
        }
        
        var result = Food()
        
        Nutrient.standard.enumerated().forEach { (offset, nutrient) in
            result[keyPath: nutrient.keyPath] = result.decode(linearByte: data[offset + 1])
        }
        
        let extendedData = data.suffix(from: Nutrient.standard.count + 1)
        var iterator = extendedData.makeIterator()
		var servingSize: UInt8? = nil
		var servingSizeExponent: Int8? = nil

        while let code = iterator.next(), let quantity = iterator.next() {
            if let (nutrient, mass) = result.decode(bytePair: (code, quantity)) {
                result[keyPath: nutrient.keyPath] = mass
			} else if let specialCode = SpecialCode(rawValue: code) {
				switch specialCode {
				case .servingSize:
					servingSize = quantity
					break;
				case .servingSizeExponent:
					servingSizeExponent = Int8(bitPattern: quantity)
					break;
				}
			} else {
				print("Unrecognized code")
			}
        }

		if let servingSize = servingSize {
			let exponent = servingSizeExponent ?? 0

			return Serving(food: result, mass: Float(servingSize << exponent))
		} else {
        	return result
		}
    }
}

extension Food {
    func byte(for nutrient: Nutrient) -> UInt8? {
        if nutrient.minimumRepresentableMass < 1 {
            return logByte(for: nutrient)
        } else {
            return linearByte(for: nutrient)
        }
    }
    
    func linearByte(for nutrient: Nutrient) -> UInt8 {
        let value = self[keyPath: nutrient.keyPath]
        
        return UInt8(round(255.0 * value / totalMass))
    }
    
    func logByte(for nutrient: Nutrient) -> UInt8? {
        let value = self[keyPath: nutrient.keyPath]
        
        let number = value / nutrient.minimumRepresentableMass
        let base = nutrient.base
        let quantity = log(number) / log(base)
        
        if (quantity < 0) {
            return nil
        }
        
        return UInt8(min(255, round(quantity)))
    }
    
    func decode(linearByte: UInt8) -> Float {
        return Float(totalMass * Float(linearByte) / 255.0)
    }

	func decode(logByte: UInt8, for nutrient: Nutrient) -> Float {
		let quantity = Float(logByte)
		let base = nutrient.base

		let number = exp(quantity * log(base))

		return number * nutrient.minimumRepresentableMass
	}

    func decode(bytePair: (UInt8, UInt8)) -> (Nutrient, Float)? {
        guard let nutrient = Nutrient.decode(from: bytePair.0) else {
            print("unrecognized nutrient code")
            return nil
        }
                
        return (nutrient, decode(logByte: bytePair.1, for: nutrient))
    }
}

enum EncodingFormat {
	case linear
	case logarithmic
}

enum SpecialCode: UInt8 {
	case servingSize = 0xF0
	case servingSizeExponent = 0xF1
}

extension Nutrient {
    static var standard: [Nutrient] {
        get {
            return [.fatTotal, .carbohydrates, .protein, .fiber, .sugar, .fatSaturated, .fatMonounsaturated, .fatPolyunsaturated]
        }
    }
    
    static var extended: [Nutrient] {
        get {
            return Array(Set(Nutrient.allCases).subtracting(Nutrient.standard))
        }
    }

    var code: UInt8? {
        get {
            switch self {
            case .water:
                return 0x00
            case .cholesterol:
                return 0x10
            case .sugarAdded:
                return 0x11
            case .sugarAlcohols:
                return 0x12
            case .vitaminA:
                return 0x20
            case .thiamin:
                return 0x21
            case .riboflavin:
                return 0x22
            case .niacin:
                return 0x23
            case .pantothenicAcid:
                return 0x24
            case .vitaminB6:
                return 0x25
            case .biotin:
                return 0x26
            case .vitaminB12:
                return 0x27
            case .vitaminC:
                return 0x28
            case .vitaminD:
                return 0x29
            case .vitaminE:
                return 0x2A
            case .vitaminK:
                return 0x2B
            case .folate:
                return 0x2C
            case .calcium:
                return 0x30
            case .chloride:
                return 0x31
            case .iron:
                return 0x32
            case .magnesium:
                return 0x33
            case .phosphorus:
                return 0x34
            case .potassium:
                return 0x35
            case .sodium:
                return 0x36
            case .zinc:
                return 0x37
            case .chromium:
                return 0x38
            case .copper:
                return 0x39
            case .iodine:
                return 0x3A
            case .manganese:
                return 0x3B
            case .molybdenum:
                return 0x3C
            case .selenium:
                return 0x3D
            case .caffeine:
                return 0xD0
            case .choline:
                return 0x2D
            case .fluoride:
                return 0x3E
            default:
                return nil
            }
        }
    }
    
    var minimumRepresentableMass: Float {
        get {
            switch self {
            case .cholesterol:
                return 0.001
            case .vitaminA:
                return 0.000001
            case .thiamin:
                return 0.000001
            case .riboflavin:
                return 0.000001
            case .niacin:
                return 0.00001
            case .pantothenicAcid:
                return 0.0001
            case .vitaminB6:
                return 0.000001
            case .biotin:
                return 0.00001
            case .vitaminB12:
                return 0.00000001
            case .vitaminC:
                return 0.0001
            case .vitaminD:
                return 0.00000001
            case .vitaminE:
                return 0.00001
            case .vitaminK:
                return 0.0000001
            case .folate:
                return 0.000001
            case .calcium:
                return 0.001
            case .chloride:
                return 0.001
            case .iron:
                return 0.001
            case .magnesium:
                return 0.001
            case .phosphorus:
                return 0.001
            case .potassium:
                return 0.01
            case .sodium:
                return 0.001
            case .zinc:
                return 0.00001
            case .caffeine:
                return 0.001
            case .chromium:
                return 0.0000001
            case .copper:
                return 0.000001
            case .iodine:
                return 0.000001
            case .manganese:
                return 0.00001
            case .molybdenum:
                return 0.0000001
            case .selenium:
                return 0.0000001
            case .choline:
                return 0.001
            case .fluoride:
                return 0.00001
            default:
                return 1
            }
        }
    }
    
    var maximumRepresentableMass: Float {
        get {
            return 255.0
        }
    }
    
    var base: Float {
        get {
            return exp(log(maximumRepresentableMass / minimumRepresentableMass) / 256)
        }
    }
    
    static func decode(from code: UInt8) -> Nutrient? {
        switch code {
        case 0x00:
            return .water
        case 0x10:
            return .cholesterol
        case 0x11:
            return .sugarAdded
        case 0x12:
            return .sugarAlcohols
        case 0x20:
            return .vitaminA
        case 0x21:
            return .thiamin
        case 0x22:
            return .riboflavin
        case 0x23:
            return .niacin
        case 0x24:
            return .pantothenicAcid
        case 0x25:
            return .vitaminB6
        case 0x26:
            return .biotin
        case 0x27:
            return .vitaminB12
        case 0x28:
            return .vitaminC
        case 0x29:
            return .vitaminD
        case 0x2A:
            return .vitaminE
        case 0x2B:
            return .vitaminK
        case 0x2C:
            return .folate
        case 0x30:
            return .calcium
        case 0x31:
            return .chloride
        case 0x32:
            return .iron
        case 0x33:
            return .magnesium
        case 0x34:
            return .phosphorus
        case 0x35:
            return .potassium
        case 0x36:
            return .sodium
        case 0x37:
            return .zinc
        case 0x38:
            return .chromium
        case 0x39:
            return .copper
        case 0x3A:
            return .iodine
        case 0x3B:
            return .manganese
        case 0x3C:
            return .molybdenum
        case 0x3D:
            return .selenium
        case 0xD0:
            return .caffeine
        case 0x2D:
            return .choline
        case 0x3E:
            return .fluoride
        default:
            return nil
        }
    }
}
