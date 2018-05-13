//
//  ViewModel.swift
//  ReactiveExtension
//
//  Created by Akasaaa on 2018/05/02.
//  Copyright © 2018年 Akasaaa. All rights reserved.
//

import Foundation
import RxSwift

enum Operator: Int {
    case plus = 0
    case minus
    case times
    case divide
    
    var description: String {
        switch self {
        case .plus: return "＋"
        case .minus: return "−"
        case .times: return "×"
        case .divide: return "÷"
        }
    }
}

class ViewModel {
    
    // MARK: Observable
    
    let numObserver = Variable("0")
    
    let operatorObserver = Variable("")
    
    
    // MARK: initializer
    
    init() { }
    
    
    
    // MARK: property
    
    /// 計算式左辺
    private var lhs: Decimal?
    
    /// 計算式右辺
    private var rhs: Decimal?
    
    /// 演算子
    private var op: Operator?
    
    
    
    // MARK: functions
    
    /// 数値が入力された際の処理
    func input(num: Int) {
        
        // FIXME: もう少し綺麗に書けそう
        
        if let lhs = lhs {
            
            if let _ = op {
                if let rhs = rhs {
                    self.rhs = Decimal(string: rhs.description + "\(num)")
                    numObserver.value = "\(self.rhs!)"
                } else {
                    self.rhs = Decimal(num)
                    numObserver.value = "\(rhs!)"
                }
                
            } else {
                if lhs.isInfinite {
                    self.lhs = Decimal(num)
                } else {
                    
                }
                self.lhs = lhs * 10 + Decimal(num)
                self.lhs = Decimal(string: lhs.description + "\(num)")
                numObserver.value = "\(self.lhs!)"
            }
        } else {
            if num != 0 {
                lhs = Decimal(num)
                numObserver.value = "\(num)"
            }
        }
    }
    
    /// 演算子が入力された際の処理
    func input(operator op: Operator) {
        if let _ = rhs {
            lhs = calculation()
            self.rhs = nil
            self.op = op
            operatorObserver.value = op.description
            numObserver.value = "\(lhs!)"
            
        } else {
            self.op = op
            operatorObserver.value = op.description
        }
    }
    
    /// イコールが入力された際の処理
    func equal() {
        guard let _ = lhs, let _ = rhs, let _ = op else { return }
        lhs = calculation()
        rhs = nil
        op = nil
        operatorObserver.value = ""
        numObserver.value = "\(lhs!)"
    }
    
    /// クリアーが入力された際の処理
    func clear() {
        lhs = nil
        rhs = nil
        op = nil
        operatorObserver.value = ""
        numObserver.value = "0"
    }
    
    
    
    // MARK: private function
    
    /// 計算結果を返却する
    /// 要素が足らず、計算ができない場合はnilを返却する
    private func calculation() -> Decimal? {
        
        guard let lhs = lhs, let rhs = rhs, let op = op else {
            return nil
        }
        switch op {
        case .plus:
            return lhs + rhs
        case .minus:
            return lhs - rhs
        case .times:
            return lhs * rhs
        case .divide:
            return lhs / rhs
        }
    }
}

