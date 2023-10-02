//
//  Brew Data Storage.swift
//  Cork
//
//  Created by David Bureš on 03.07.2022.
//

import Foundation
import IdentifiedCollections
import SwiftUI

@MainActor
class BrewDataStorage: ObservableObject
{
    @Published var installedFormulae: Set<BrewPackage> = .init()
    @Published var installedCasks: Set<BrewPackage> = .init()

    func removeFormulaFromTracker(withName name: String)
    {
        removePackageFromTracker(withName: name, tracker: .formula)
    }
    func removeCaskFromTracker(withName name: String)
    {
        removePackageFromTracker(withName: name, tracker: .formula)
    }

    private func removePackageFromTracker(withName name: String, tracker: PackageType)
    {
        switch tracker {
            case .formula:
                if let index = installedFormulae.firstIndex(where: { $0.name == name })
                {
                    installedFormulae.remove(at: index)
                }
            case .cask:
                if let index = installedCasks.firstIndex(where: { $0.name == name })
                {
                    installedCasks.remove(at: index)
                }
        }
    }
}

@MainActor
class AvailableTaps: ObservableObject
{
    @Published var addedTaps: Set<BrewTap> = .init()

    func insertTapIntoTracker(_ tap: BrewTap)
    {
        addedTaps.insert(tap)
    }
    func removeTapFromTracker(_ tap: BrewTap)
    {
        if let index = addedTaps.firstIndex(where: { $0.name == tap.name })
        {
            addedTaps.remove(at: index)
        }
    }
    func removeTapFromTrackerByName(_ tapName: String)
    {
        if let index = addedTaps.firstIndex(where: { $0.name == tapName })
        {
            addedTaps.remove(at: index)
        }
    }
}
