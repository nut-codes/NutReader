//
//  ViewController.swift
//  NutReader
//
//  Created by Frank Schmitt on 5/7/19.
//  Copyright © 2019 Nut Codes. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
	let formatter = MeasurementFormatter()

	var food: Food? {
		didSet {
			if isViewLoaded {
				updateDisplay()
			}
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		if let _ = food {
			updateDisplay()
		}

		formatter.numberFormatter.maximumSignificantDigits = 2
		formatter.unitOptions = .providedUnit
    }

	func updateDisplay() {
		tableView.reloadData()
	}

	override func numberOfSections(in tableView: UITableView) -> Int {
		return (food?.extendedNutrients.count ?? 0) > 0 ? 2 : 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 0:
			return food?.standardNutrients.count ?? 0
		default:
			return food?.extendedNutrients.count ?? 0
		}
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Nutrient", for: indexPath)

		var nutrient: (Nutrient, Mass)!

		switch indexPath.section {
		case 0:
			nutrient = food?.standardNutrients[indexPath.row]
		default:
			nutrient = food?.extendedNutrients[indexPath.row]
		}


		let grams = Measurement(value: Double(nutrient.1) * nutrient.0.divisor, unit: nutrient.0.units)
		cell.textLabel?.text = nutrient.0.name
		cell.detailTextLabel?.text = formatter.string(for: grams)

		return cell
	}

}

extension Food {
	var standardNutrients: [(Nutrient, Mass)] {
		get {
			return Nutrient.standard.reduce(into: []) { (result, nutrient) in
				result.append((nutrient, self[keyPath:nutrient.keyPath]))
			}
		}
	}

	var extendedNutrients: [(Nutrient, Mass)] {
		get {
			return Nutrient.extended.reduce(into: []) { (result, nutrient) in
				let mass = self[keyPath:nutrient.keyPath]
				if (mass > 0) {
					result.append((nutrient, mass))
				}
			}
		}
	}
}

extension Nutrient {
	var units: Dimension {
		get {
			switch self {
			case .fatTotal, .carbohydrates, .protein, .fiber, .sugar, .fatMonounsaturated, .fatPolyunsaturated, .fatSaturated, .sugarAdded, .sugarAlcohols, .water:
				return UnitMass.grams
			case .cholesterol, .thiamin, .riboflavin, .niacin, .pantothenicAcid, .vitaminB6, .calcium, .iron, .magnesium, .phosphorus, .potassium, .sodium, .zinc, .copper, .caffeine, .chloride, .choline, .vitaminC, .vitaminE:
				return UnitMass.milligrams
			case .vitaminA, .vitaminB12, .fluoride, .selenium, .vitaminD, .vitaminK, .folate, .chromium, .iodine, .manganese, .molybdenum, .biotin:
				return UnitMass.micrograms
			}
		}
	}

	var divisor: Double {
		get {
			switch self {
			case .fatTotal, .carbohydrates, .protein, .fiber, .sugar, .fatMonounsaturated, .fatPolyunsaturated, .fatSaturated, .sugarAdded, .sugarAlcohols, .water:
				return 1
			case .cholesterol, .thiamin, .riboflavin, .niacin, .pantothenicAcid, .vitaminB6, .calcium, .iron, .magnesium, .phosphorus, .potassium, .sodium, .zinc, .copper, .caffeine, .chloride, .choline, .vitaminC, .vitaminE:
				return 1000
			case .vitaminA, .vitaminB12, .fluoride, .selenium, .vitaminD, .vitaminK, .folate, .chromium, .iodine, .manganese, .molybdenum, .biotin:
				return 1000000
			}
		}
	}

}
