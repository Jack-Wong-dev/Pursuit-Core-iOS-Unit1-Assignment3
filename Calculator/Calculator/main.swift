//
//  main.swift
//  CalculatorCommand
//
//  Created by Jack Wong on 7/19/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import Foundation

var operations: ([String: (Double, Double) -> Double]) = ["+": { $0 + $1 },
                                                          "-": { $0 - $1 },
                                                          "*": { $0 * $1 },
                                                          "/": { $0 / $1 }]

func menu(){
    print("Enter type of calculation, 1 (regular) or 2 (high order)?")
    let regOrHigh = readLine()
    
    if let decision = regOrHigh?.trimmingCharacters(in: .whitespacesAndNewlines){
        switch decision{
        case "1":
            binaryOption()
        case "2":
            higherOrderOp()
        default:
            print("Invalid Input. Try Again")
            print()
            sleep(1)
            menu()
        }
    }
}


func binaryOption(){
    var input = String()
    var input1 = String()
    var f = String()
    var s = String()
    var first: Double = 0.0
    var second: Double = 0.0
    var arr = [String]()
    var op = String()
    var op1 = String()
    var randomOperator = String()
    var keyword = String()
    
    func checkOperator(){
        op1 = input1.trimmingCharacters(in: .whitespacesAndNewlines)
        switch op1 {
        case "+":
            displayRightOrWrong(op1)
        case "-":
            displayRightOrWrong(op1)
        case "*":
            displayRightOrWrong(op1)
        case "/":
            displayRightOrWrong(op1)
        default:
            print("Invalid input. Try again.")
            if let chooseOp = readLine(){
                input1 = chooseOp
            }
            checkOperator()
        }
    }
    
    func getInput(){
        print("Enter your operation, e.g 5+3")
        let someInput = readLine()
        if let mehInput = someInput{
            input = mehInput
        }
    }
    
    
    func checkInput(){
        let pattern = "(\\+|\\-|\\*|\\/|\\?)"
        //        let doesItMatch = userInput.range(of: pattern, options: .regularExpression) != nil
        //        print(doesItMatch)
        if let range = input.range(of:pattern, options: .regularExpression) {
            let result = input[range]
            //print(result)
            keyword = String(result)
        }
        
        switch keyword {
        case "+":
            op = "+"
        case "-":
            op = "-"
        case "*":
            op = "*"
        case "/":
            op = "/"
        case "?":
            op = "?"
        default:
            print("No operator detected. Try again.")
            print()
            sleep(1)
            binaryOption()
        }
        //        if input.contains("+"){
        //            op = "+"
        //        }else if input.contains("-"){
        //            op = "-"
        //        }else if input.contains("*"){
        //            op = "*"
        //        }else if input.contains("/"){
        //            op = "/"
        //        }else if input.contains("?"){
        //            op = "?"
        //        }
        //        else{
        //            print("No operator detected. Try again.")
        //            print()
        //            sleep(1)
        //            binaryOption()
        //        }
        arr = input.components(separatedBy: op)
        f = arr[0].trimmingCharacters(in: .whitespacesAndNewlines)
        s = arr[1].trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func displayRightOrWrong(_ oper:String){
        if randomOperator == oper{
            print("Correct!")
        }else{
            print("Wrong! Try again!")
            if let chooseOp = readLine(){
                input1 = chooseOp
            }
            checkOperator()
        }
    }
    
    func getAnswer(){
        switch op {
        case "?":
            if let randomOp = operations.randomElement()?.key{
                randomOperator = randomOp
                if let a = Double(f), let b = Double(s){
                    first = a
                    second = b
                    if let answer = operations[randomOp]{
                        print(answer(first,second))
                        print("Guess the operator being used? +,-,*,/")
                        if let chooseOp = readLine(){
                            input1 = chooseOp
                        }
                        checkOperator()
                    }
                }
            }
        default:
            if let a = Double(f), let b = Double(s){
                first = a
                second = b
                
                if let answer = operations[op]{
                    print(answer(first,second))
                }
                
            }else{
                print("Invalid arguments. Try again.")
                print()
                sleep(1)
                binaryOption()
            }
        }
    }
    
    getInput() //Retrieve input first
    checkInput() //verify input
    getAnswer() //Find answer
    
}

func playAgain(){
    print("Play again? Y/N", terminator:" ")
    let again = readLine()
    if let a = again{
        if a.uppercased() == "Y"{
            main()
        }else if a.uppercased() != "N" {
            print("invalid input")
            playAgain()
        }else{
            
        }
    }
}

func higherOrderOp(){
    var intArray = [Int]()
    var userCondition = String()
    var userNumberCondition = 0
    
    func customFilter(_ condition: String,_ numCondition: Int){
    
        func getAnswer(_ arr: [Int],_ filterClosure: (Int) -> Bool )->[Int]{
            var answer = [Int]()
            for i in arr{
                if filterClosure(i){
                    answer.append(i)
                }
            }
            return answer
        }
        
        switch condition{
        case ">":
            let greaterThan = {(x: Int) -> Bool in
                x > Int(numCondition) ? true : false
            }
            print(getAnswer(intArray, greaterThan))
            
        case "<":
            let lessThan = {(x: Int) -> Bool in
                x < Int(numCondition) ? true : false
            }
            print(getAnswer(intArray, lessThan))
        default:
            print("Invalid input. Try again")
            print()
            sleep(1)
            higherOrderOp()
        }
        
    }
    
    func customMap(_ condition: String,_ numCondition: Int){
        
        var output = [Int]()
        
        func getAnswer(_ arr: [Int],_ mapClosure: (Int) -> Int )->[Int]{
            var answer = [Int]()
            for i in arr{
                answer.append(mapClosure(i))
            }
            return answer
        }
        
        switch condition {
        case "+":
            let add = {(n: Int) -> Int in
                return n + numCondition
            }
            print(getAnswer(intArray, add))
        case "-":
            let sub = {(n: Int) -> Int in
                return n - numCondition
            }
            print(getAnswer(intArray, sub))
        case "*":
            let multiply = {(n: Int) -> Int in
                return n * numCondition
            }
            print(getAnswer(intArray, multiply))
        case "/":
            let divide = {(n: Int) -> Int in
                return n / numCondition
            }
            print(getAnswer(intArray, divide))
        default:
            print("Valid input not found.  Try again")
            print()
            sleep(1)
            higherOrderOp()
        }
    }
    
    
    func customReduce(_ condition: String,_ numCondition: Int){
        
        switch condition {
        case "+":
            let answer = {(arr: [Int]) -> Int in
                var sum = numCondition
                for i in arr{
                    sum += i
                }
                return sum
            }
            print(answer(intArray))
        case "-":
            let answer = {(arr: [Int]) -> Int in
                var difference = 0 - numCondition
                for i in arr{
                    difference -= i
                }
                return difference
            }
            print(answer(intArray))
        case "*":
            let answer = {(arr: [Int]) -> Int in
                var product = numCondition
                for i in arr{
                    product *= i
                }
                return product
            }
            print(answer(intArray))
        case "/":
            let answer = {(arr: [Int]) -> Int in
                var quotient = numCondition
                for i in arr{
                    quotient /= i
                }
                return quotient
            }
            print(answer(intArray))
        default:
            print("Invalid Input. Try again")
            print()
            sleep(1)
            higherOrderOp()
        }
    }
    
    
    var userInput = String()
    var keyword = String()
    
    func checkUserInput(){
        print("Enter filter/reduce/map")
        let user = readLine()
        if let a = user{
            userInput = a
        }
        //print(userInput)
    }
    func checkPat(){
        let pattern = "(filter|reduce|map)"
        //        let doesItMatch = userInput.range(of: pattern, options: .regularExpression) != nil
        //        print(doesItMatch)
        if let range = userInput.range(of:pattern, options: .regularExpression) {
            let result = userInput[range]
            //print(result)
            keyword = String(result)
        }
    }
    func keywordDecision(){
        switch keyword {
        case "filter":
            let pattern = "^\\s*filter\\s*([\\d+\\s*,\\s*]+\\d+)\\s*by\\s*(<|>)\\s*(\\d+)\\s*$"
            let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            
            if let match = regex?.firstMatch(in: userInput, options: [], range: NSRange(location: 0, length: userInput.utf16.count)) {
                if let arrRange = Range(match.range(at: 1), in: userInput) {
                    let arr = String(userInput[arrRange]).components(separatedBy: ",")
                    //print(arr)
                    intArray = arr.compactMap({ Int($0.trimmingCharacters(in: .whitespacesAndNewlines)) })
                    //   print(intArray)
                }
                if let greaterOrLessThanRange = Range(match.range(at: 2), in: userInput) {
                    let greatOrless = String(userInput[greaterOrLessThanRange])
                    userCondition = greatOrless
                    //  print(greatOrless)
                }
                if let numberRange = Range(match.range(at: 3), in: userInput) {
                    let number = String(userInput[numberRange])
                    userNumberCondition = Int(number) ?? 0
                    // print(number)
                }
                customFilter(userCondition, userNumberCondition)
            }else{
                print("You entered an invalid input.  Try again")
                print()
                sleep(1)
                higherOrderOp()
            }
            
        case "reduce":
            let pattern = "^\\s*reduce\\s*([\\d+,]+\\d+)\\s*by\\s*(\\+|\\-|\\*|\\/)\\s*(\\d+)\\s*$"
            let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            
            if let match = regex?.firstMatch(in: userInput, options: [], range: NSRange(location: 0, length: userInput.utf16.count)) {
                if let arrRange = Range(match.range(at: 1), in: userInput) {
                    let arr = String(userInput[arrRange]).components(separatedBy: ",")
                    intArray = arr.compactMap({ Int($0.trimmingCharacters(in: .whitespacesAndNewlines)) })
                }
                if let addSubMulDivRange = Range(match.range(at: 2), in: userInput) {
                    let addSubMulDiv = String(userInput[addSubMulDivRange])
                    userCondition = addSubMulDiv
                }
                if let numberRange = Range(match.range(at: 3), in: userInput) {
                    let number = String(userInput[numberRange])
                    userNumberCondition = Int(number) ?? 0
                }
                customReduce(userCondition, userNumberCondition)
            }else{
                print("You entered an invalid input.  Try again")
                print()
                higherOrderOp()
            }
            
        case "map":
            let pattern = "^\\s*map\\s*([\\d+,]+\\d+)\\s*by\\s*(\\+|\\-|\\*|\\/)\\s*(\\d+)\\s*$"
            let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            
            if let match = regex?.firstMatch(in: userInput, options: [], range: NSRange(location: 0, length: userInput.utf16.count)) {
                if let arrRange = Range(match.range(at: 1), in: userInput) {
                    let arr = String(userInput[arrRange]).components(separatedBy: ",")
                    intArray = arr.compactMap({ Int($0.trimmingCharacters(in: .whitespacesAndNewlines)) })
                }
                if let addSubMulDivRange = Range(match.range(at: 2), in: userInput) {
                    let greatOrless = String(userInput[addSubMulDivRange])
                    userCondition = greatOrless
                }
                if let numberRange = Range(match.range(at: 3), in: userInput) {
                    let number = String(userInput[numberRange])
                    userNumberCondition = Int(number) ?? 0
                }
                customMap(userCondition, userNumberCondition)
            }else{
                print("You entered an invalid input.  Try again")
                print()
                higherOrderOp()
            }
        default:
            print("You entered an invalid input.  Try again")
            print()
            higherOrderOp()
        }
    }
    checkUserInput()
    checkPat()
    keywordDecision()
}

func main(){
    menu()
    playAgain()
}

main()

