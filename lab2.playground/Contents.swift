import Cocoa

// problem 1
var results: [String] = []   // создаем пустой массив типа стринг чтобы туда в дальнейшем записывались резуьтаты вывода

for number in 1...100 {
    if number % 3 == 0 && number % 5 == 0 {     // если число делится на 3 и на 5 то мы в наш массив дабовляем физбаз
        results.append("FizzBuzz")
    } else if number % 3 == 0 {   // в противном случае если только на три то физз
        results.append("Fizz")
    } else if number % 5 == 0 { // если только на 5 то базз
        results.append("Buzz")
    } else {
        results.append("\(number)")    // если ни на что из этого то так и записываем число в массив
    }
}

print(results.joined(separator: ", "))   // выводим содержание массива через запятую



//problem 2
//число простое если делится только на себя и на 1
func isPrime(_ number: Int) -> Bool {      //принимает в себя число на проверку и возвращет бул правда ли он прайм или нет
    if number < 2 {                         // сразу рассматрвиаем случай что простое число начинаестя с двух
        return false
    }
    for i in 2..<number {         //перебирает все число от 2 до намбер не включительно
        if number % i == 0 {       // если пока пробегает находит хоть одно число на которое делится входящее в функцию намбер то фолс
            return false
        }
    }
    
    return true       // в противном случае это простое число
}

var primeNumbers: [Int] = []        // создаем пустую коллекцию типа массив типа инт чтобы сюда записывать результаты - все простые числа

for num in 1...100 {       // перебираем от 1 до 100
    if isPrime(num) {       // и для каждого числа запускаем функцию проверки
        primeNumbers.append(num)    // если тру то записываем в наш массив простых чисел
    }
}

print("Prime numbers between 1 and 100:")
print(primeNumbers)    // отдельно выводим потому что через джойнд можно только стринг выводить так



// problem 3

func celsiusToFahrenheit(_ celsius: Double) -> Double {     // по формуле пишем функции для конвертации
    return (celsius * 9/5) + 32
}

func celsiusToKelvin(_ celsius: Double) -> Double {
    return celsius + 273.15
}

func fahrenheitToCelsius(_ fahrenheit: Double) -> Double {
    return (fahrenheit - 32) * 5/9
}

func fahrenheitToKelvin(_ fahrenheit: Double) -> Double {
    return (fahrenheit - 32) * 5/9 + 273.15
}

func kelvinToCelsius(_ kelvin: Double) -> Double {
    return kelvin - 273.15
}

func kelvinToFahrenheit(_ kelvin: Double) -> Double {
    return (kelvin - 273.15) * 9/5 + 32
}
// так как пока с консолью не работаем захардкодим входыне данные и возьмем как примеры
let inputValue: Double = 40.0
let inputUnit: String = "C"

if inputUnit == "C" {
    let fahrenheit = celsiusToFahrenheit(inputValue)
    let kelvin = celsiusToKelvin(inputValue)
    print("\(inputValue)'C = \(fahrenheit)'F = \(kelvin)'K")
} else if inputUnit == "F" {
    let celsius = fahrenheitToCelsius(inputValue)
    let kelvin = fahrenheitToKelvin(inputValue)
    print("\(inputValue)'F = \(celsius)'C = \(kelvin)'K")
} else if inputUnit == "K" {
    let celsius = kelvinToCelsius(inputValue)
    let fahrenheit = kelvinToFahrenheit(inputValue)
    print("\(inputValue)'K = \(celsius)'C = \(fahrenheit)'F")
} else {
    print("Unknown unit. Please use C, F, or K.")   // при неправильном вводе измерительной шкалы
}


//problem 4

var shoppingList: [String] = []     // создаем пустой массив - лист наших покупок чтобы в дальнейшем его наполнять или удалять
// так как мы не работаем пока с консолью делаем так можем
let userActions = [    // создаем массив тюплс -> здесь мы храним то что нам нужно сделать и с чем именно нам это нужно сделать
    ("add", "Water"),
    ("add", "Bread"),
    ("add", "Banana"),
    ("remove", "Bread"),
    ("add", "Eggs"),
    ("exit", "")    // добавлен для того чтобы когда была консоль можно было останавливаться и выводить лист
]

for action in userActions {    // перебираем все команды юзера
    let command = action.0     // и обозначаем что певрое что в масииве это акшн который нам нужно сделать
    let item = action.1        // а второй по очереди это наш продукт
    
    if command == "add" {      // добавляем в наш массив продукт
        shoppingList.append(item)
        print(" Added: \(item)")
    } else if command == "remove" {    // логика удаления продукта из списка
        if let index = shoppingList.firstIndex(of: item) {    // если найден продукт в списке то вариабл индексу присваивается его индекс
            shoppingList.remove(at: index)    // и удается в массиве по этому индексу
            print("Removed: \(item)")
        } else {
            print("Item '\(item)' not found in shopping list")   // если товар не найден -> индекс будет нил и вернется принт ошибки
        }
    } else if command == "exit" {
        print("Exiting Shopping List Manager")     // так же в консоль будет выводиться при опшн exit
        break
    }
    
    print("Current shopping list: \(shoppingList)")
}

//problem 5
let sentence = "Hey, today is today! Today is a thursday. Thursday is today. Goodbuy!"  //предложение на проверку

let lowercased = sentence.lowercased() // встроенная функция -> приводим к нижнему регистру

let cleaned = lowercased.filter { $0.isLetter || $0.isWhitespace }   // встроенная функция для коллекций - принимает клоуже и оставляет толкьо то что соответствует условию - оставляет толкьо буквы и пробелы

let words = cleaned.split(separator: " ").map { String($0) } //делит строку по пробелам - массив


var wordFrequency: [String: Int] = [:]        // создаем словарь

for word in words {    // пробегаемся по массиву
    if let count = wordFrequency[word] {  //пытаемся достать текущее значение из словаря по ключу
        wordFrequency[word] = count + 1   // если слово уже встречалось то инкримент делаем
    } else {
        wordFrequency[word] = 1   // если нет то записываем в значение 1
    }
}

print("Word Frequencies:")
for (word, count) in wordFrequency {
    print("\(word): \(count)")
}



//problem 6
//Каждое число = сумма двух предыдущих
func fibonacci(_ n: Int) -> [Int] {
    if n <= 0 {         // первый кейс сразу рассматриваем -  если n меньше или равно нулю то пустой массив
        return []
    }
    if n == 1 {         // рассматриваем второй кейс -  если n равно 1 то  только [0]   - потому что это первые числа дальше уже за счет них будем высчитывать
        return [0]
    }
    var sequence: [Int] = [0, 1]   // начальные два числа последовательности - создали массив и заполнили первыми двумя - дальше будем высчитывать
    for i in 2..<n {        // с 2 и до заданного числа не включительно
        let next = sequence[i - 1] + sequence[i - 2]    // добавляем пред и пред пред
        sequence.append(next)     // добавляем в наш созданный пустой массив для результата
    }
    
    return sequence    // возвращаем массив
}

// пока нет консоли - инпуты берем для примера
print(fibonacci(0))
print(fibonacci(1))
print(fibonacci(10))
print(fibonacci(20))


//problem 7
let studentScores: [String: Int] = [   // создаем дикшинари где ключ - студент    значение - балл
    "Alice": 85,
    "Bob": 72,
    "Charlie": 95,
    "Diana": 60,
    "Eve": 78
]


let totalScore = studentScores.values.reduce(0, +)    // вытаскиваем с дикшинари только вальюс и за счет встроенной функции reduce сворачиваем все в одно значение и применяем операцию +    и того она берет значения , записывает их в массив и сворачивает в одно число
let averageScore = Double(totalScore) / Double(studentScores.count)   //формула для вычисления сред значения


let highestScore = studentScores.values.max() ?? 0     // находим максимальное занчение за счет встроенной функции, по дефолту 0
let lowestScore = studentScores.values.min() ?? 0      // то же самое но мин


print("Class Average: \(averageScore)")
print("Highest Score: \(highestScore)")
print("Lowest Score: \(lowestScore)")


for (name, score) in studentScores {          //перебираем словарь в цикле и каждый элемент возвращается как тюплс
    let status = score >= Int(averageScore) ? "above average " : "below average "    //тернарный оператор   - если больше то это если нет то это
    print("\(name): \(score) -> \(status)")
}

//problem 8

func isPalindrome(_ text: String) -> Bool {      // функция для проверки - возвращает буллиан   принимает нашу строку

    let cleaned = text.lowercased().filter { $0.isLetter }     // нижний регистр и оставляем только буквы
    
    return cleaned == String(cleaned.reversed())    //Сравниваем строку сама с собой наоборот
}

let examples = [
    "Sayanaanayas",
    "COCOAcocoa",
    "AbAbbaba",
    "i see the crystal raindrops fall"
]

for example in examples {
    print("\"\(example)\" ->  \(isPalindrome(example))")
}



//problem 9

enum CalculatorError: Error {  //список возможных ошибок калькулятора
    case divisionByZero
    case unknownOperation
}

func add(_ lhs: Double, _ rhs: Double) -> Double { lhs + rhs }         //прописываем функция для операций калькулятора
func subtract(_ lhs: Double, _ rhs: Double) -> Double { lhs - rhs }
func multiply(_ lhs: Double, _ rhs: Double) -> Double { lhs * rhs }
func divide(_ lhs: Double, _ rhs: Double) throws -> Double {    // сроун фанкшн чтобы можно было возвращать
    if rhs == 0 {             //Если b == 0, мы делаем throw CalculatorError.divisionByZero → бросаем ошибку
        throw CalculatorError.divisionByZero
    }
    return lhs / rhs
}

func calculate(_ lhs: Double, _ rhs: Double, _ op: String) throws -> Double {
    switch op {
    case "+":
        return add(lhs, rhs)
    case "-":
        return subtract(lhs, rhs)
    case "*":
        return multiply(lhs, rhs)
    case "/":
        return try divide(lhs, rhs)   // тут может вылететь ошибка
    default:
        throw CalculatorError.unknownOperation
    }
}

let testCases = [
    (5.0, 3.0, "+"),
    (10.0, 2.0, "-"),
    (4.0, 7.0, "*"),
    (20.0, 0.0, "/"),
    (15.0, 5.0, "/"),
    (20.0, 5.0, "/"),
    (7.0, 2.0, "?")   // неверная операция
]


for (num1, num2, op) in testCases {
    do {
        let result = try calculate(num1, num2, op)
        print(" \(num1) \(op) \(num2) = \(result)")
    } catch CalculatorError.divisionByZero {
        print(" Error: Division by zero (\(num1) / \(num2))")
    } catch CalculatorError.unknownOperation {
        print(" Error: Unknown operation '\(op)'")
    } catch {
        print(" Unexpected error: \(error)")
    }
}

print("Calculator finished (hardcoded version)")



//problem 10

func hasUniqueCharacters(_ text: String) -> Bool {
    var seenCharacters = Set<Character>()    //создаём пустой сет для хранения встреченных символов
    for char in text {                       //идём по каждому символу строки
        if seenCharacters.contains(char) {    //если символ уже есть в сет - встроенная функция
            
            return false   //значит повтор -> сразу false
        }
        seenCharacters.insert(char)    //иначе добавляем его в сет
    }
    
    return true          //если прошли весь текст без повторов → true
}
print(hasUniqueCharacters("Swift"))
print(hasUniqueCharacters("Teacher"))
print(hasUniqueCharacters("AaBbCc"))
print(hasUniqueCharacters("Sayana"))









