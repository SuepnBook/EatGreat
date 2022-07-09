//
//  QuestionRepository.swift
//  EatGreat
//
//  Created by Book on 2022/7/8.
//


class QuestionRepository {
    
    static let shared:QuestionRepository = QuestionRepository()
    
    private var questions:[QuestionDomainObject.Question] = []
    
}

//MARK: - Create
extension QuestionRepository {
    func postAnswer(answer:[QuestionDomainObject.Question]) {
        for type in PhysiqueType.allCases {
            let percentage = getPercentage(physiqueType: type, answer: answer)
            UserDefaultManager.savePhysiquePercentage(type: type, percentage: percentage)
            print("type : \(type) , percentage : \(percentage)")
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

//MARK: - READ
extension QuestionRepository {
    func getQuestions(questionType:QuestionType) -> [QuestionDomainObject.Question] {
        var questions = questions.filter({$0.questionType == questionType})
        for (index,question) in questions.enumerated() {
            questions[index].title = "\(index + 1).\(question.title)"
        }
        return questions
    }
}

//MARK: - Update
extension QuestionRepository {
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
