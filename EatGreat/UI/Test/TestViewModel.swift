//
//  TestViewModel.swift
//  EatGreat
//
//  Created by Book on 2022/7/1.
//

import RxCocoa
import RxSwift

protocol TestViewModelDelegate:AnyObject {
    func updateProgressView(viewObject:TestProgressView.Object)
    func updateDataSource(testQuestions:[QuestionDomainObject.Question])
    func reloadTableView(testQuestions:[QuestionDomainObject.Question])
    func scrollToIndexPath(index:Int)
    func updateNextButton(title:String,isEnable:Bool)
    func gotoNextView(answer:[QuestionDomainObject.Question])
}

class TestViewModel: BaseViewModel {
    
    weak var delegate:TestViewModelDelegate?
    
    private let repo:PhysiqueRepository = .shared
    
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
        
        let isSelectedBefore:Bool = testObject.currentSection.testQuestions[index].frequency != nil
        
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
        
        let isSeriousDone = testObject.currentSection.testQuestions[index].serious != nil
        if isSeriousDone && !isSelectedBefore {
            let nextIndex = index + 1
            if nextIndex < testObject.currentSection.testQuestions.count {
                delegate?.scrollToIndexPath(index: nextIndex)
            }
        }
    }
    
    func selectSerious(index:Int, level: Int) {
        
        let isSelectedBefore:Bool = testObject.currentSection.testQuestions[index].serious != nil
        
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
        if isFrequencyDone && !isSelectedBefore {
            let nextIndex = index + 1
            if nextIndex < testObject.currentSection.testQuestions.count {
                delegate?.scrollToIndexPath(index: nextIndex)
            }
        }
    }
    
    func selectNextButton() {
        switch testObject.currentCategory {
        case .life:
            selectSection(category: .head)
        case .head:
            selectSection(category: .digestion)
        case .digestion:
            selectSection(category: .trunk)
        case .trunk:
            selectSection(category: .all)
        case .all:
            let answer = testObject.answer
            savePhysiquePercentage(answer: answer)
            Notification.post(name: .symptomRefresh)
            delegate?.gotoNextView(answer: answer)
        }
    }
}

// MARK: - Private Function
extension TestViewModel {
    
    private func updateTestQuestion() {
        testObject.life.testQuestions = repo.getQuestions(questionType: .life)
        testObject.head.testQuestions = repo.getQuestions(questionType: .head)
        testObject.digestion.testQuestions = repo.getQuestions(questionType: .digestion)
        testObject.trunk.testQuestions = repo.getQuestions(questionType: .trunk)
        testObject.all.testQuestions = repo.getQuestions(questionType: .all)
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
    
    private func savePhysiquePercentage(answer:[QuestionDomainObject.Question]) {
        for type in PhysiqueType.allCases {
            let percentage = getPercentage(physiqueType: type, answer: answer)
            repo.savePhysiquePercentage(type: type, percentage: percentage)
        }
    }
    
    private func getPercentage(physiqueType:PhysiqueType, answer:[QuestionDomainObject.Question]) -> Float {
        let totalQuestions = answer
        let conformQuestion = totalQuestions.filter({$0.physicalType.contains(where: {$0 == physiqueType})})
        if conformQuestion.count == 0 {
            return 0
        }
        let totalScore = conformQuestion.count * 25
        var getScore:Int = 0
        for question in conformQuestion {
            let frequency = question.frequency ?? 0
            let serious = question.serious ?? 0
            getScore += frequency * serious
        }
        let percentage = Float(getScore) / Float(totalScore)
        return percentage
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
        var answer:[QuestionDomainObject.Question] {
            var result:[QuestionDomainObject.Question] = []
            result.append(contentsOf: life.testQuestions)
            result.append(contentsOf: head.testQuestions)
            result.append(contentsOf: digestion.testQuestions)
            result.append(contentsOf: all.testQuestions)
            return result
        }
        
        struct Section {
            var testQuestions:[QuestionDomainObject.Question] = []
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
