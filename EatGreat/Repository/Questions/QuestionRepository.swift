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

//MARK: - READ
extension QuestionRepository {
    func getQuestions(questionType:QuestionType) -> [QuestionDomainObject.Question] {
        var questions = questions.filter({$0.questionType == questionType})
        for (index,question) in questions.enumerated() {
            questions[index].title = "\(index + 1).\(question.title)"
//        FIXME: - Remember to remove
            questions[index].frequency = Int.random(in: 1...5)
            questions[index].serious = Int.random(in: 1...5)
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
