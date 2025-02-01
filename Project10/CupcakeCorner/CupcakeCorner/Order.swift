//
//  Order.swift
//  CupcakeCorner
//

import Foundation

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }

    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0 { didSet { save() } }
    var quantity = 3 { didSet { save() } }

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }

    var extraFrosting = false { didSet { save() } }
    var addSprinkles = false { didSet { save() } }

    var name = "" { didSet { save() } }
    var streetAddress = "" { didSet { save() } }
    var city = "" { didSet { save() } }
    var zip = "" { didSet { save() } }


    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }

        return true
    }

    var cost: Decimal {
        var cost = Decimal(quantity) * 2

        cost += Decimal(type) / 2

        if extraFrosting {
            cost += Decimal(quantity)
        }

        if addSprinkles {
            cost += Decimal(quantity) / 2
        }

        return cost
    }
    
    private static let saveKey = "SavedOrder"

    init() {
        load()
    }

    private func save() {
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        }
    }

    private func load() {
        if let savedData = UserDefaults.standard.data(forKey: Self.saveKey),
           let decodedOrder = try? JSONDecoder().decode(Order.self, from: savedData) {
            self.type = decodedOrder.type
            self.quantity = decodedOrder.quantity
            self.specialRequestEnabled = decodedOrder.specialRequestEnabled
            self.extraFrosting = decodedOrder.extraFrosting
            self.addSprinkles = decodedOrder.addSprinkles
            self.name = decodedOrder.name
            self.streetAddress = decodedOrder.streetAddress
            self.city = decodedOrder.city
            self.zip = decodedOrder.zip
        }
    }
}
