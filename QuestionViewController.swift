//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Domenica Torres on 3/1/22.
//

import UIKit

class QuestionViewController: UIViewController {
/*in here, I will set up questions array object and it will contain different types of questions and answers(objects) available*/
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var singleStackView: UIStackView!
    //action to each button:
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    

    var questions: [Question] = [
        Question(text: "Which food do you like the most?", type: .single, answers: [Answer(text: "Steak", type: .dog),
                                                                                    Answer(text: "Salmon", type: .cat),
                                                                                    Answer(text: "Eggs", type: .monkey),
                                                                                    Answer(text: "Ceasar Salad", type: .rabbit)]
                ),
        Question(text: "Which activities do you enjoy the most?", type: .multiple, answers: [Answer(text: "swimming", type: .dog), Answer(text: "rock climbing", type: .cat), Answer(text: "singing", type: .monkey), Answer(text: "sleeping", type: .rabbit)]
                ),
        Question(text: "How much do you enjoy car rides?", type: .ranged, answers: [Answer(text: "I do not like them", type: .cat), Answer(text: "I get a little nervous", type: .monkey), Answer(text: "I don't mind them", type: .rabbit), Answer(text: "I love them", type: .dog)]
                )
    ]

    var questionIndex = 0 //this index will keep track of the questions already displayed and it will increment the value by 1 after the player answers each question
    var answersChosen: [Answer] = [] //this will record what answer the user has chosen
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //create a new method:
        updateUI()
    }
    func updateUI(){
        //set up the initial views for view controller
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        //update the navigation title:
        navigationItem.title = "Question #\(questionIndex+1)"
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        //update question label:
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case.single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
    }
    func nextQuestion(){
        questionIndex += 1
        
        if questionIndex < questions.count{
            updateUI()
        }else{
            performSegue(withIdentifier: "Results", sender: nil)
        }
    }

    @IBSegueAction func showResults(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, responses: answersChosen)
    }
    
    func updateSingleStack(using answers: [Answer]){
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    func updateMultipleStack(using answers: [Answer]){
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        
        
        
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
        
    }
    func updateRangedStack(using answers: [Answer]){
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    //connect the same method
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers //array of answers of the "current question"
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        nextQuestion()
    }
    
    //identify when the submitted answer has been selected in multiple stack view
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers

        if multiSwitch1.isOn{
            answersChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn{
            answersChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn{
            answersChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn{
            answersChosen.append(currentAnswers[3])
        }
        nextQuestion()
    }
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        //identify the ranged based on the range (get the value)
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1 )))
        
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //prepare it before the segue happens, which one is the user calling
        if segue.identifier == "Results"{
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answersChosen
        }
    }
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
