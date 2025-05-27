//
//  DesignSystemViewModel.swift
//  Kursach
//
//  Created by Георгий Борисов on 27.05.2025.
//

import Foundation

class DesignSystemViewModel: ObservableObject {
    @Published var balance = 1100
    
    private let queue = DispatchQueue(label: "com.atm.transactions", attributes: .concurrent)
    
    
    struct ATM {
        let tag: String
        let viewModel: DesignSystemViewModel
        
        func withdraw(value: Int) {
            print("\n=== \(tag) начинает транзакцию ===")
            print("\(tag): Текущий баланс: \(viewModel.balance)")
            
            func isBalanceSufficent() -> Bool {
                if viewModel.balance >= value {
                    return true
                } else {
                    print("\(tag): Ошибка - недостаточно средств")
                    return false
                }
            }
            
            
            if isBalanceSufficent() {
                print("\(tag): Баланс достаточен, начинаю снятие \(value)")
                
                Thread.sleep(forTimeInterval: Double.random(in: 2.0...3.0))
                
                print("\(tag): Прочитал баланс: \(viewModel.balance)")
                
                Thread.sleep(forTimeInterval: Double.random(in: 2.0...3.0))
                if isBalanceSufficent() {
                    viewModel.balance = viewModel.balance - value
                    print("\(tag): Снял \(value), новый баланс: \(viewModel.balance)")
                }
            }
            print("=== \(tag) завершил транзакцию ===\n")
        }
    }
    
     
    
    func withdrawFromATM1() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
        let atm = ATM(tag: "ATM1", viewModel: self)
            atm.withdraw(value: 1000)
        }
    }
    
    func withdrawFromATM2() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
        let atm = ATM(tag: "ATM2", viewModel: self)
            atm.withdraw(value: 1000)
        }
    }
    
    
}
