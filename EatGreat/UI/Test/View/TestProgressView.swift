//
//  TestProgressView.swift
//  EatGreat
//
//  Created by Book on 2022/6/29.
//

import UIKit
import RxCocoa
import RxSwift

protocol TestProgressViewDelegate:AnyObject {
    func selectSection(view:TestProgressView, category:TestProgressView.Category)
}

class TestProgressView: UIView {
    
    enum Category {
        case life
        case head
        case digestion
        case trunk
        case all
        
        var title:String {
            switch self {
            case .life:
                return "生活型態"
            case .head:
                return "頭部"
            case .digestion:
                return "消化系統"
            case .trunk:
                return "軀幹"
            case .all:
                return "全部位"
            }
        }
        
        var image:String {
            switch self {
            case .life:
                return "BodySection1"
            case .head:
                return "BodySection1"
            case .digestion:
                return "BodySection1"
            case .trunk:
                return "BodySection1"
            case .all:
                return "BodySection1"
            }
        }
    }
    
    struct Object{
        var life:Section = .init(isFocus:true)
        var head:Section = .init()
        var digestion:Section = .init()
        var trunk:Section = .init()
        var all:Section = .init()
        
        struct Section {
            var completionRatio:Float = 0
            var isFocus:Bool = false
        }
    }
    
    weak var delegate:TestProgressViewDelegate?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceHorizontal = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let lifeButton:SectionButton = SectionButton(category: .life)
    private let progress2Line:ProgressBarView = ProgressBarView()
    private let headButton:SectionButton = SectionButton(category: .head)
    private let progress3Line:ProgressBarView = ProgressBarView()
    private let digestionButton:SectionButton = SectionButton(category: .digestion)
    private let progress4Line:ProgressBarView = ProgressBarView()
    private let trunkButton:SectionButton = SectionButton(category: .trunk)
    private let progress5Line:ProgressBarView = ProgressBarView()
    private let allButton:SectionButton = SectionButton(category: .all)
    
    private var disposeBag:DisposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        reactiveX()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        backgroundColor = .themeBackground2

        addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(68)
        }
        
        scrollView.addSubview(lifeButton)
        scrollView.addSubview(progress2Line)
        scrollView.addSubview(headButton)
        scrollView.addSubview(progress3Line)
        scrollView.addSubview(digestionButton)
        scrollView.addSubview(progress4Line)
        scrollView.addSubview(trunkButton)
        scrollView.addSubview(progress5Line)
        scrollView.addSubview(allButton)
        
        lifeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview()
        }
        progress2Line.snp.makeConstraints { make in
            make.leading.equalTo(lifeButton.imageView.snp.trailing)
            make.centerY.equalTo(lifeButton.imageView.snp.centerY)
            make.trailing.equalTo(headButton.imageView.snp.leading)
        }
        headButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
        }
        progress3Line.snp.makeConstraints { make in
            make.leading.equalTo(headButton.imageView.snp.trailing)
            make.centerY.equalTo(headButton.imageView.snp.centerY)
            make.trailing.equalTo(digestionButton.imageView.snp.leading)
        }
        digestionButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
        }
        progress4Line.snp.makeConstraints { make in
            make.leading.equalTo(digestionButton.imageView.snp.trailing)
            make.centerY.equalTo(digestionButton.imageView.snp.centerY)
            make.trailing.equalTo(trunkButton.imageView.snp.leading)
        }
        trunkButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
        }
        progress5Line.snp.makeConstraints { make in
            make.leading.equalTo(trunkButton.imageView.snp.trailing)
            make.centerY.equalTo(trunkButton.imageView.snp.centerY)
            make.trailing.equalTo(allButton.imageView.snp.leading)
        }
        allButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
        }
    }
    
    private func reactiveX() {
        lifeButton.rxControlEvent()
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.selectSection(view: self, category: .life)
            }.disposed(by: disposeBag)
        headButton.rxControlEvent()
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.selectSection(view: self, category: .head)
            }.disposed(by: disposeBag)
        digestionButton.rxControlEvent()
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.selectSection(view: self, category: .digestion)
            }.disposed(by: disposeBag)
        trunkButton.rxControlEvent()
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.selectSection(view: self, category: .trunk)
            }.disposed(by: disposeBag)
        allButton.rxControlEvent()
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.selectSection(view: self, category: .all)
            }.disposed(by: disposeBag)
    }
    
    func updateFrame(viewObject:Object) {
        
        let life = viewObject.life
        lifeButton.updateFrame(isComplete: life.completionRatio >= 1,
                                   isSelected: life.isFocus)
        let head = viewObject.head
        headButton.updateFrame(isComplete: head.completionRatio >= 1,
                                   isSelected: head.isFocus)
        progress2Line.updateFrame(completionRatio: head.completionRatio)
        let digestion = viewObject.digestion
        digestionButton.updateFrame(isComplete: digestion.completionRatio >= 1,
                                   isSelected: digestion.isFocus)
        progress3Line.updateFrame(completionRatio: digestion.completionRatio)
        let trunk = viewObject.trunk
        trunkButton.updateFrame(isComplete: trunk.completionRatio >= 1,
                                   isSelected: trunk.isFocus)
        progress4Line.updateFrame(completionRatio: trunk.completionRatio)
        let all = viewObject.all
        allButton.updateFrame(isComplete: all.completionRatio >= 1,
                              isSelected: all.isFocus)
        progress5Line.updateFrame(completionRatio: all.completionRatio)
    }
}

private class SectionButton:UIControl {
    
    let imageView:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .themePrimary
        label.font = .footnote
        return label
    }()
    
    private lazy var focusLine:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        view.backgroundColor = .themePrimary
        return view
    }()
    
    private var image:UIImage?
    
    init(category:TestProgressView.Category) {
        super.init(frame: .zero)
        self.image = UIImage(named: category.image)
        titleLabel.text = category.title
        imageView.image = self.image
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(focusLine)
        
        self.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(42)
            make.height.equalTo(68)
        }
        
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.top.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        focusLine.snp.makeConstraints { make in
            make.height.equalTo(4)
            make.width.equalTo(24)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    func updateFrame(isComplete:Bool,isSelected:Bool) {
        UIView.transition(with: self,
                          duration: 0.5,
                          options: .transitionCrossDissolve) {
            self.imageView.image = isComplete ? UIImage(named: "SectionComplete") : self.image
            self.titleLabel.textColor = isComplete ? .themePrimary : .white
            self.focusLine.isHidden = !isSelected
            self.isEnabled = isComplete
        }
    }
}

private class ProgressBarView:UIView {
    
    private let highlightView:UIView = {
        let view = UIView()
        view.backgroundColor = .themePrimary
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        initView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        backgroundColor = .white
        
        addSubview(highlightView)
        
        self.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(2)
        }
        
        highlightView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(-1)
        }
    }
    
    func updateFrame(completionRatio:Float) {
        var multiplied = completionRatio * 2
        if multiplied >= 2 {
            multiplied = 2
        }
        
        UIView.transition(with: self,
                          duration: 0.5,
                          options: .curveLinear) {
            self.highlightView.snp.remakeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.leading.equalToSuperview().offset(-1)
                if multiplied > 0 {
                    make.trailing.equalTo(self.snp.centerX).multipliedBy(multiplied)
                } else {
                    make.width.equalTo(0)
                }
            }
        }
    }
}

