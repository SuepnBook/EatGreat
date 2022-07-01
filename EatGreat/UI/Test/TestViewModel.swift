//
//  TestViewModel.swift
//  EatGreat
//
//  Created by Book on 2022/7/1.
//

import RxCocoa
import RxSwift

struct TestQuestion {
    var title:String
    var frequency:Int?
    var serious:Int?
    var isFinish:Bool {
        frequency != nil && serious != nil
    }
}

protocol TestViewModelDelegate:AnyObject {
    func updateProgressView(viewObject:TestProgressView.Object)
    func updateDataSource(testQuestions:[TestQuestion])
    func reloadTableView(testQuestions:[TestQuestion])
    func scrollToIndexPath(index:Int)
    func updateNextButton(title:String,isEnable:Bool)
    func gotoNextView()
}

class TestViewModel: BaseViewModel {
    
    weak var delegate:TestViewModelDelegate?
    
    private var testObject:TestObject = .init()
    
    func setup() {
        updateTestQuestion()
        selectSection(category: .life)
        reloadTableView()
    }
    
    func selectSection(category:Category) {
        testObject.currentCategory = category
        updateProgressView()
        reloadTableView()
        updateNextButton()
    }
    
    func selectFrequency(index:Int, level: Int) {
        switch testObject.currentCategory {
        case .life:
            testObject.life.testQuestions[index].frequency = level
        case .head:
            testObject.head.testQuestions[index].frequency = level
        case .digestion:
            testObject.digestion.testQuestions[index].frequency = level
        case .trunk:
            testObject.trunk.testQuestions[index].frequency = level
        case .all:
            testObject.all.testQuestions[index].frequency = level
        }
        updateProgressView()
        updateDataSource()
        updateNextButton()
    }
    
    func selectSerious(index:Int, level: Int) {
        
        switch testObject.currentCategory {
        case .life:
            testObject.life.testQuestions[index].serious = level
        case .head:
            testObject.head.testQuestions[index].serious = level
        case .digestion:
            testObject.digestion.testQuestions[index].serious = level
        case .trunk:
            testObject.trunk.testQuestions[index].serious = level
        case .all:
            testObject.all.testQuestions[index].serious = level
        }
            
        updateProgressView()
        updateDataSource()
        updateNextButton()
        
        let isFrequencyDone = testObject.currentSection.testQuestions[index].frequency != nil
        if isFrequencyDone {
            let nextIndex = index + 1
            if nextIndex < testObject.currentSection.testQuestions.count {
                delegate?.scrollToIndexPath(index: nextIndex)
            }
        }
    }
    
    func selectNextButton() {
        let nextCategory:Category
        switch testObject.currentCategory {
        case .life:
            nextCategory = .head
        case .head:
            nextCategory = .digestion
        case .digestion:
            nextCategory = .trunk
        case .trunk:
            nextCategory = .all
        case .all:
            delegate?.gotoNextView()
            return
        }
        selectSection(category: nextCategory)
    }
}

// MARK: - Private Function
extension TestViewModel {
    
    private func updateTestQuestion() {
        var testQuestions:[TestQuestion] = []
        for i in 0...3 {
            testQuestions.append(.init(title: "\(i).題目？"))
        }
        testObject.life.testQuestions = testQuestions
        testObject.head.testQuestions = testQuestions
        testObject.digestion.testQuestions = testQuestions
        testObject.trunk.testQuestions = testQuestions
        testObject.all.testQuestions = testQuestions
    }
    
    private func updateProgressView() {
        let category = testObject.currentCategory
        let viewObject:TestProgressView.Object =
            .init(life: .init(completionRatio: testObject.life.completionRatio,
                              isFocus: category == .life),
                  head: .init(completionRatio: testObject.head.completionRatio,
                              isFocus: category == .head),
                  digestion: .init(completionRatio: testObject.digestion.completionRatio,
                                   isFocus: category == .digestion),
                  trunk: .init(completionRatio: testObject.trunk.completionRatio,
                               isFocus: category == .trunk),
                  all: .init(completionRatio: testObject.all.completionRatio,
                             isFocus: category == .all))
        delegate?.updateProgressView(viewObject: viewObject)
    }
    
    private func reloadTableView() {
        let testQuestions = testObject.currentSection.testQuestions
        delegate?.reloadTableView(testQuestions: testQuestions)
        if !testQuestions.isEmpty {
            delegate?.scrollToIndexPath(index: 0)
        }
    }
    
    private func updateDataSource() {
        let testQuestions = testObject.currentSection.testQuestions
        delegate?.updateDataSource(testQuestions: testQuestions)
    }
    
    private func updateNextButton() {
        let isEnable = testObject.currentSection.completionRatio >= 1
        let title:String
        if testObject.currentCategory == .all && isEnable{
            title = "完成"
        } else {
            title = "下一步"
        }
        delegate?.updateNextButton(title: title, isEnable: isEnable)
    }
}

extension TestViewModel {
    enum Category {
        case life
        case head
        case digestion
        case trunk
        case all
    }
    
    struct TestObject{
        var currentCategory: Category = .life
        var currentSection:Section {
            switch currentCategory {
            case .life:
                return life
            case .head:
                return head
            case .digestion:
                return digestion
            case .trunk:
                return trunk
            case .all:
                return all
            }
        }
        var life:Section = .init()
        var head:Section = .init()
        var digestion:Section = .init()
        var trunk:Section = .init()
        var all:Section = .init()
        
        struct Section {
            var testQuestions:[TestQuestion] = []
            var completionRatio:Float {
                let totalCount:Float = Float(testQuestions.count)
                if totalCount == 0 {
                    return 1
                }
                var finishCount:Float = 0
                testQuestions.forEach({
                    if $0.isFinish {
                        finishCount += 1
                    }
                })
                return finishCount / totalCount
            }
        }
    }
}
