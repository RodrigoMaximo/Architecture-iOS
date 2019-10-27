//
//  CountriesMock.swift
//  MVC-Example
//
//  Created by Rodrigo Máximo on 27/10/19.
//  Copyright © 2019 Rodrigo Máximo. All rights reserved.
//

import Foundation

enum CountriesProvider {
    static func provide(_ numberOfCountries: Int) -> [Country] {
        let numberOfCountriesReturned = min(numberOfCountries, MockCountries.countries.count)
        var randomCountries = Set<Country>()
        while randomCountries.count < numberOfCountriesReturned {
            if let randomElement = MockCountries.countries.randomElement() {
                randomCountries.insert(randomElement)
            }
        }
        return Array(randomCountries)
    }
}

enum MockCountries {
    static var countries: [Country] {
        return [
            Country(name: "Brazil", continent: .southAmerica, population: 0, hdi: 0.759),
            Country(name: "Argentina", continent: .southAmerica, population: 0, hdi: 0.825),
            Country(name: "Australia", continent: .oceania, population: 0, hdi: 0.939),
            Country(name: "Belgium", continent: .europe, population: 0, hdi: 0.916),
            Country(name: "Colombia", continent: .southAmerica, population: 0, hdi: 0.747),
            Country(name: "Croatia", continent: .europe, population: 0, hdi: 0.831),
            Country(name: "Denmark", continent: .europe, population: 0, hdi: 0.929),
            Country(name: "England", continent: .europe, population: 0, hdi: 0.922),
            Country(name: "France", continent: .europe, population: 0, hdi: 0.901),
            Country(name: "Germany", continent: .europe, population: 0, hdi: 0.936),
            Country(name: "Iceland", continent: .europe, population: 0, hdi: 0.935),
            Country(name: "Japan", continent: .asia, population: 0, hdi: 0.909),
            Country(name: "Mexico", continent: .northAmerica, population: 0, hdi: 0.774),
            Country(name: "Nigeria", continent: .africa, population: 0, hdi: 0.532),
            Country(name: "Panama", continent: .centralAmerica, population: 0, hdi: 0.789),
            Country(name: "Peru", continent: .southAmerica, population: 0, hdi: 0.750),
            Country(name: "Poland", continent: .europe, population: 0, hdi: 0.865),
            Country(name: "Portugal", continent: .europe, population: 0, hdi: 0.847),
            Country(name: "Russia", continent: .asia, population: 0, hdi: 0.816),
            Country(name: "Saudi Arabia", continent: .asia, population: 0, hdi: 0.853),
            Country(name: "Spain", continent: .europe, population: 0, hdi: 0.891),
        ]
    }
}
