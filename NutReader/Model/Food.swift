//
//  Food.swift
//  NutReader
//
//  Created by Frank Schmitt on 5/7/19.
//  Copyright © 2019 Nut Codes. All rights reserved.
//

import Foundation

protocol FoodOrServing {}

typealias Mass = Float

struct Food: FoodOrServing {
    // Values are in grams
    
    // Macronutrients
    var fatTotal: Mass = 0
    var carbohydrates: Mass = 0
    var protein: Mass = 0

    // Carbohydrate Detail
    var fiber: Mass = 0
    var sugar: Mass = 0

    // Fat Detail
    var fatMonounsaturated: Mass = 0
    var fatPolyunsaturated: Mass = 0
    var fatSaturated: Mass = 0
    var cholesterol: Mass = 0
    
    // Not in HealthKit
    var sugarAdded: Mass = 0
    var sugarAlcohols: Mass = 0
    var choline: Mass = 0
    var fluoride: Mass = 0

    // Vitamins
    var vitaminA: Mass = 0
    var thiamin: Mass = 0
    var riboflavin: Mass = 0
    var niacin: Mass = 0
    var pantothenicAcid: Mass = 0
    var vitaminB6: Mass = 0
    var biotin: Mass = 0
    var vitaminB12: Mass = 0
    var vitaminC: Mass = 0
    var vitaminD: Mass = 0
    var vitaminE: Mass = 0
    var vitaminK: Mass = 0
    var folate: Mass = 0
    
    // Minerals
    var calcium: Mass = 0
    var chloride: Mass = 0
    var iron: Mass = 0
    var magnesium: Mass = 0
    var phosphorus: Mass = 0
    var potassium: Mass = 0
    var sodium: Mass = 0
    var zinc: Mass = 0

    // Hydration
    var water: Mass = 0
    
    // Caffeination
    var caffeine: Mass = 0
    
    // Ultratrace Minerals
    var chromium: Mass = 0
    var copper: Mass = 0
    var iodine: Mass = 0
    var manganese: Mass = 0
    var molybdenum: Mass = 0
    var selenium: Mass = 0
    
    // This value is used to normalize values of other nutrients
    // (they are stored as a fraction of the total mass), as well as to indicate a
    // serving unit where applicable (e.g. the mass of one cookie)
    var totalMass: Mass = 100;
    
    init(fat: Mass, carbohydrates: Mass, protein: Mass) {
        self.fatTotal = fat
        self.carbohydrates = carbohydrates
        self.protein = protein
    }
    
    init() {
    }
}

struct Serving: FoodOrServing {
    var food: Food
    var mass: Mass
}

enum Nutrient: CaseIterable {
    case fatTotal
    case carbohydrates
    case protein
    case fiber
    case sugar
    case fatMonounsaturated
    case fatPolyunsaturated
    case fatSaturated
    case cholesterol
    case sugarAdded
    case sugarAlcohols
    case vitaminA
    case thiamin
    case riboflavin
    case niacin
    case pantothenicAcid
    case vitaminB6
    case biotin
    case vitaminB12
    case vitaminC
    case vitaminD
    case vitaminE
    case vitaminK
    case folate
    case calcium
    case chloride
    case iron
    case magnesium
    case phosphorus
    case potassium
    case sodium
    case zinc
    case water
    case caffeine
    case chromium
    case copper
    case iodine
    case manganese
    case molybdenum
    case selenium
    case choline
    case fluoride
    
    var name: String {
        get {
            switch self {
            case .fatTotal:
                return "Total Fat"
            case .carbohydrates:
                return "Carbohydrates"
            case .protein:
                return "Protein"
            case .fiber:
                return "Fiber"
            case .sugar:
                return "Sugar"
            case .fatMonounsaturated:
                return "Monounsaturated Fat"
            case .fatPolyunsaturated:
                return "Polyunsaturated Fat"
            case .fatSaturated:
                return "Saturated Fat"
            case .cholesterol:
                return "Cholesterol"
            case .sugarAdded:
                return "Added Sugar"
            case .sugarAlcohols:
                return "Sugar Alcohols"
            case .vitaminA:
                return "Vitamin A"
            case .thiamin:
                return "Thiamin"
            case .riboflavin:
                return "Riboflavin"
            case .niacin:
                return "Niacin"
            case .pantothenicAcid:
                return "Pantothenic Acid"
            case .vitaminB6:
                return "Vitamin B6"
            case .biotin:
                return "Biotin"
            case .vitaminB12:
                return "Vitamin B12"
            case .vitaminC:
                return "Vitamin C"
            case .vitaminD:
                return "Vitamin D"
            case .vitaminE:
                return "Vitamin E"
            case .vitaminK:
                return "Vitamin K"
            case .folate:
                return "Folate"
            case .calcium:
                return "Calcium"
            case .chloride:
                return "Chloride"
            case .iron:
                return "Iron"
            case .magnesium:
                return "Magnesium"
            case .phosphorus:
                return "Phosphorus"
            case .potassium:
                return "Potassium"
            case .sodium:
                return "Sodium"
            case .zinc:
                return "Zinc"
            case .water:
                return "Water"
            case .caffeine:
                return "Caffeine"
            case .chromium:
                return "Chromium"
            case .copper:
                return "Copper"
            case .iodine:
                return "Iodine"
            case .manganese:
                return "Manganese"
            case .molybdenum:
                return "Molybdenum"
            case .selenium:
                return "Selenium"
            case .choline:
                return "Choline"
            case .fluoride:
                return "Fluoride"
            }
        }
    }
    
    var keyPath: WritableKeyPath<Food, Mass> {
        get {
            switch self {
            case .fatTotal:
                return \.fatTotal
            case .carbohydrates:
                return \.carbohydrates
            case .protein:
                return \.protein
            case .fiber:
                return \.fiber
            case .sugar:
                return \.sugar
            case .fatMonounsaturated:
                return \.fatMonounsaturated
            case .fatPolyunsaturated:
                return \.fatPolyunsaturated
            case .fatSaturated:
                return \.fatSaturated
            case .water:
                return \.water
            case .cholesterol:
                return \.cholesterol
            case .sugarAdded:
                return \.sugarAdded
            case .sugarAlcohols:
                return \.sugarAlcohols
            case .vitaminA:
                return \.vitaminA
            case .thiamin:
                return \.thiamin
            case .riboflavin:
                return \.riboflavin
            case .niacin:
                return \.niacin
            case .pantothenicAcid:
                return \.pantothenicAcid
            case .vitaminB6:
                return \.vitaminB6
            case .biotin:
                return \.biotin
            case .vitaminB12:
                return \.vitaminB12
            case .vitaminC:
                return \.vitaminC
            case .vitaminD:
                return \.vitaminD
            case .vitaminE:
                return \.vitaminE
            case .vitaminK:
                return \.vitaminK
            case .folate:
                return \.folate
            case .calcium:
                return \.calcium
            case .chloride:
                return \.chloride
            case .iron:
                return \.iron
            case .magnesium:
                return \.magnesium
            case .phosphorus:
                return \.phosphorus
            case .potassium:
                return \.potassium
            case .sodium:
                return \.sodium
            case .zinc:
                return \.zinc
            case .chromium:
                return \.chromium
            case .copper:
                return \.copper
            case .iodine:
                return \.iodine
            case .manganese:
                return \.manganese
            case .molybdenum:
                return \.molybdenum
            case .selenium:
                return \.selenium
            case .caffeine:
                return \.caffeine
            case .choline:
                return \.choline
            case .fluoride:
                return \.fluoride
            }
        }
    }
}
