//
//  NSLockViewModel.swift
//  Kursach
//
//  Created by Георгий Борисов on 27.05.2025.
//

import Foundation

class NSLockViewModel : ObservableObject {
    
    @Published var balance = 1100
    private let queue = DispatchQueue(label: "com.atm.transactions", attributes: .concurrent)
    var lock = NSLock()

    struct ATM {
        let tag: String
        let viewModel: NSLockViewModel

        func withdraw(value: Int) {
            //Начало критической секции
            viewModel.lock.lock()
            print("\n=== \(tag) начинает транзакцию ===")
            print("\(tag): Текущий баланс: \(viewModel.balance)")
            
            if viewModel.balance >= value {
                print("\(tag): Баланс достаточен, начинаю снятие \(value)")
                
                Thread.sleep(forTimeInterval: Double.random(in: 2.0...3.0))
                
                print("\(tag): Прочитал баланс: \(viewModel.balance)")
                
                Thread.sleep(forTimeInterval: Double.random(in: 2.0...3.0))
                    viewModel.balance = viewModel.balance - value
                    print("\(tag): Снял \(value), новый баланс: \(viewModel.balance)")
                
            } else {
                print("\(tag): Ошибка - недостаточно средств")
            }
            
            print("=== \(tag) завершил транзакцию ===\n")
            // Конец критической секции
            viewModel.lock.unlock()
        }
    }
    
    
    func withdrawFromATM1() {
        let atm = ATM(tag: "ATM1", viewModel: self)
        DispatchQueue.global().async {
            atm.withdraw(value: 1000)
        }
    }
    
    func withdrawFromATM2() {
        let atm = ATM(tag: "ATM2", viewModel: self)
        DispatchQueue.global().async {
            atm.withdraw(value: 1000)
        }
    }
}
