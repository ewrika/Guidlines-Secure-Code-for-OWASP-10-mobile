//
//  ExampleCod.swift
//  Kursach
//
//  Created by Георгий Борисов on 03.05.2025.
//

import Foundation


//
//let queue = DispatchQueue(label: "WithdrawalQueue", attributes: .concurrent)
//
//func someFunc() {
//
//    queue.async {
//        let firstATM = ATM(tag: "Банкомат#1")
//        firstATM.withdraw(value: 1000)
//    }
//
//    queue.async {
//        let secondATM = ATM(tag: "Банкомат#2")
//        secondATM.withdraw(value: 800)
//    }
//
//}
//


//var balance = 1200
//
//struct ATM {
//    let tag: String
//    func withdraw(value: Int) {
//        func isBalanceSufficent() -> Bool {
//            if balance > value {
//                return true
//            } else {
//                print("\(self.tag): Невозможно снять средства: недостаточный баланс")
//                return false
//            }
//        }
//
//        print("\(self.tag): Проверка наличия достаточной суммы на балансе")
//        if isBalanceSufficent() {
//            print("\(self.tag): Баланс достаточен, пожалуйста, подождите, пока обрабатывается снятие средств")
//            // имитация длительного процесса с помощью паузы
//            Thread.sleep(forTimeInterval: Double.random(in: 0...2))
//            if isBalanceSufficent() {
//                balance -= value
//                print("\(self.tag): Готово: \(value) снято")
//                print("\(self.tag): Текущий баланс: \(balance)")
//            }
//        }
//    }
//}

//var balance = 1200
//
//let lock = NSLock()
//
//struct ATM {
//    let tag: String
//    func withdraw(value: Int) {
//        // начало критической секции - захват мьютекса
//        lock.lock()
//        print("\(self.tag): проверка достаточности средств на балансе")
//        if balance > value {
//            print("\(self.tag): Баланс достаточен, пожалуйста, подождите, пока обрабатывается снятие")
//            Thread.sleep(forTimeInterval: Double.random(in: 0...2))
//            balance -= value //
//            print("\(self.tag): Готово: \(value) снято")
//            print("\(self.tag): текущий баланс \(balance)")
//        } else {
//            print("\(self.tag): Невозможно снять: недостаточный баланс")
//        }
//        // конец критической секции - освобождение мьютекса
//        lock.unlock()
//    }
//}


//var balance = 1200
//
//let serialQueue = DispatchQueue(label: "Serial Queue")
//struct ATM {
//    let tag: String
//    func withdraw(value: Int) {
//        serialQueue.async {
//            print("\(self.tag): проверка наличия достаточной суммы")
//            if balance > value {
//                print("\(self.tag): Баланс достаточен, пожалуйста, ожидайте обработки снятия")
//                Thread.sleep(forTimeInterval: Double.random(in: 0...2))
//                balance -= value
//                print("\(self.tag): Готово: \(value) снято")
//                print("\(self.tag): Текущий баланс: \(balance)")
//            } else {
//                print("\(self.tag): Невозможно снять: недостаточный баланс")
//            }
//        }
//    }
//}





