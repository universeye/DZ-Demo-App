//
//  Profile.swift
//  ProtocolDemo
//
//  Created by Alex Nagy on 07/12/2019.
//  Copyright © 2019 Alex Nagy. All rights reserved.
//

import UIKit

struct Profile {
    let icon: String
    let accentColor: UIColor
    let name: String
    let info: String
}

struct ProfileColor {
    let accentColor: UIColor
}

struct Label {
    let title: String?
    let body: String?
}

struct logoImage {
    let imageName: String
}


extension Profile {
    static let dummydate: [Profile] = [Profile(icon: "icon2", accentColor: .blue, name: "Universeye", info: "Developer")]
}
