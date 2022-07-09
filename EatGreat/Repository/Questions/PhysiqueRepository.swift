//
//  QuestionRepository.swift
//  EatGreat
//
//  Created by Book on 2022/7/8.
//


class PhysiqueRepository {
    
    static let shared:PhysiqueRepository = PhysiqueRepository()
    
    private var questions:[QuestionDomainObject.Question] = []
    
}

//MARK: - Create
extension PhysiqueRepository {
    func savePhysiquePercentage(type:PhysiqueType, percentage:Float) {
        UserDefaultManager.savePhysiquePercentage(type: type, percentage: percentage)
        print("type : \(type) , percentage : \(percentage)")
    }
}

//MARK: - READ
extension PhysiqueRepository {
    func getQuestions(questionType:QuestionType) -> [QuestionDomainObject.Question] {
        var questions = questions.filter({$0.questionType == questionType})
        for (index,question) in questions.enumerated() {
            questions[index].title = "\(index + 1).\(question.title)"
        }
        return questions
    }
    
    func getPhysiquePercentage(type:PhysiqueType) -> Float {
        UserDefaultManager.getPhysiquePercentage(type: type)
    }
}

//MARK: - Update
extension PhysiqueRepository {
    func updateQuestion(questions:[RealTimeDatabaseDomainObject.Question]) {
        var result:[QuestionDomainObject.Question] = []
        
        for question in questions {
            result.append(.init(id: question.id,
                                title: question.title,
                                physicalType: question.physicalType,
                                questionType: question.questionType))
        }
        
        self.questions = result
    }
}
