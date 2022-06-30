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
    func reloadTableView(testQuestions:[TestQuestion])
    func updateProgressView(viewObject:TestProgressView.Object)
}

class TestViewModel: BaseViewModel {
    
    weak var delegate:TestViewModelDelegate?
    
    private var testObject:TestObject = .init()
    
    func setup() {
        let testQuestions = testObject.life.testQuestions
        delegate?.reloadTableView(testQuestions: testQuestions)
        selectSection(category: .life)
    }
    
    func selectSection(category:Category) {
        testObject.life.isFocus = category == .life
        testObject.head.isFocus = category == .head
        testObject.digestion.isFocus = category == .digestion
        testObject.trunk.isFocus = category == .trunk
        testObject.all.isFocus = category == .all
        
        switch category {
        case .life:
            delegate?.reloadTableView(testQuestions: testObject.life.testQuestions)
        case .head:
            delegate?.reloadTableView(testQuestions: testObject.head.testQuestions)
        case .digestion:
            delegate?.reloadTableView(testQuestions: testObject.digestion.testQuestions)
        case .trunk:
            delegate?.reloadTableView(testQuestions: testObject.trunk.testQuestions)
        case .all:
            delegate?.reloadTableView(testQuestions: testObject.all.testQuestions)
        }
        
        let viewObject:TestProgressView.Object =
            .init(life: .init(completionRatio: testObject.life.completionRatio,
                              isFocus: testObject.life.isFocus),
                  head: .init(completionRatio: testObject.head.completionRatio,
                              isFocus: testObject.head.isFocus),
                  digestion: .init(completionRatio: testObject.digestion.completionRatio,
                                   isFocus: testObject.digestion.isFocus),
                  trunk: .init(completionRatio: testObject.trunk.completionRatio,
                               isFocus: testObject.trunk.isFocus),
                  all: .init(completionRatio: testObject.all.completionRatio,
                             isFocus: testObject.all.isFocus))
        delegate?.updateProgressView(viewObject: viewObject)
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
        var life:Section = .init(isFocus:true)
        var head:Section = .init()
        var digestion:Section = .init()
        var trunk:Section = .init()
        var all:Section = .init()
        
        struct Section {
            var testQuestions:[TestQuestion] = []
            var completionRatio:Float {
                let totalCount:Float = Float(testQuestions.count)
                if totalCount == 0 {
                    return 0
                }
                var finishCount:Float = 0
                testQuestions.forEach({
                    if $0.isFinish {
                        finishCount += 1
                    }
                })
                return finishCount / totalCount
            }
            var isFocus:Bool = false
        }
    }
}
