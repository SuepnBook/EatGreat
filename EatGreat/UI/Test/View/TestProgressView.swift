//
//  TestProgressView.swift
//  EatGreat
//
//  Created by Book on 2022/6/29.
//

import UIKit

protocol TestProgressViewDelegate:AnyObject {
    func selectSection(view:TestProgressView, index:Int)
}

class TestProgressView: UIView {
    
    struct Object{
        var section1:Section
        var section2:Section
        var section3:Section
        var section4:Section
    }
    
    struct Section {
        var completionRatio:Float
        var isFocus:Bool
    }
    
    weak var delegate:TestProgressViewDelegate?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceHorizontal = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let section1Button:SectionButton = SectionButton(title: "腹部", image: "BodySection1")
    private let progress2Line:ProgressBarView = ProgressBarView()
    private let section2Button:SectionButton = SectionButton(title: "腹部", image: "BodySection1")
    private let progress3Line:ProgressBarView = ProgressBarView()
    private let section3Button:SectionButton = SectionButton(title: "腹部", image: "BodySection1")
    private let progress4Line:ProgressBarView = ProgressBarView()
    private let section4Button:SectionButton = SectionButton(title: "腹部", image: "BodySection1")

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
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
        
        scrollView.addSubview(section1Button)
        scrollView.addSubview(progress2Line)
        scrollView.addSubview(section2Button)
        scrollView.addSubview(progress3Line)
        scrollView.addSubview(section3Button)
        scrollView.addSubview(progress4Line)
        scrollView.addSubview(section4Button)
        
        section1Button.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview()
        }
        progress2Line.snp.makeConstraints { make in
            make.leading.equalTo(section1Button.imageView.snp.trailing)
            make.centerY.equalTo(section1Button.imageView.snp.centerY)
            make.trailing.equalTo(section2Button.imageView.snp.leading)
        }
        section2Button.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
        }
        progress3Line.snp.makeConstraints { make in
            make.leading.equalTo(section2Button.imageView.snp.trailing)
            make.centerY.equalTo(section2Button.imageView.snp.centerY)
            make.trailing.equalTo(section3Button.imageView.snp.leading)
        }
        section3Button.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
        }
        progress4Line.snp.makeConstraints { make in
            make.leading.equalTo(section3Button.imageView.snp.trailing)
            make.centerY.equalTo(section3Button.imageView.snp.centerY)
            make.trailing.equalTo(section4Button.imageView.snp.leading)
        }
        section4Button.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
        }
    }
    
    func updateFrame(viewObject:Object) {
        
        let section1 = viewObject.section1
        section1Button.updateFrame(isComplete: section1.completionRatio >= 1,
                                   isSelected: section1.isFocus)
        let section2 = viewObject.section2
        section2Button.updateFrame(isComplete: section2.completionRatio >= 1,
                                   isSelected: section2.isFocus)
        progress2Line.updateFrame(completionRatio: section2.completionRatio)
        let section3 = viewObject.section3
        section3Button.updateFrame(isComplete: section3.completionRatio >= 1,
                                   isSelected: section3.isFocus)
        progress3Line.updateFrame(completionRatio: section3.completionRatio)
        let section4 = viewObject.section4
        section4Button.updateFrame(isComplete: section4.completionRatio >= 1,
                                   isSelected: section4.isFocus)
        progress4Line.updateFrame(completionRatio: section4.completionRatio)
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
        label.font = .SFProDisplay400?.withSize(13)
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
    
    init(title:String?,image:String) {
        super.init(frame: .zero)
        self.image = UIImage(named: image)
        titleLabel.text = title
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
        imageView.image = isComplete ? UIImage(named: "SectionComplete") : image
        titleLabel.textColor = isComplete ? .themePrimary : .white
        focusLine.isHidden = !isSelected
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
            make.width.equalTo(46)
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
        
        highlightView.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(-1)
            make.trailing.equalTo(self.snp.centerX).multipliedBy(multiplied)
        }
    }
}
