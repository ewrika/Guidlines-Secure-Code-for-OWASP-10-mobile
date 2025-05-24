//
//  Model.swift
//  Kursach
//
//  Created by Георгий Борисов on 29.04.2025.
//

import Foundation

let sections = [
    SectionData(header: "Insecure Data Storage", items: ["UserDefaults", "KeyChain"]),
    SectionData(header: "Insecure Communication", items: ["HTTP", "Certificate Pinning"]),
    SectionData(header: "Insecure Authentication", items: ["FaceID", "Pincode"]),
    SectionData(header: "Poor code", items: ["Race Conditions","Design System","NSLock","GCD"]),
    SectionData(header: "Code Tampering", items: ["DeviceCheck"]),
    SectionData(header: "Reverse Engineering", items: ["Detecting Jailbreak","Enviroments Check","Hooks","Code obfuscation","Control Flow","Dead code"])
]


struct SectionData {
    let header: String
    let items: [String]
}
