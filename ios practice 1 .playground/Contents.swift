let firstName: String = "Sayana"
let lastName: String  = "Zhumatay"
let surname: String? = "Akylbekqyzy" // u may have surname or not
let birthYear: Int = 2005
let birthMonth: Int = 10
let birthDay: Int = 8
let birthPlace : String = "Kokshetau, Kazakhstan"

var currentYear: Int = 2025  // may change so we use let
var currentMonth: Int = 9
var currentDay: Int = 16

var age: Int {
   if(currentMonth<birthMonth) || (currentMonth==birthMonth && currentDay<birthDay) {
        return currentYear-birthYear-1
    }
    else {
        return currentYear-birthYear
    }
}

var isStudent: Bool = true
var height: Double = 1.60
let eyeColor: String = "brown"
var hairColor: String = "black"
var familyMembers: Int = 5  //unfortunately or fortunately it can change

var hobbies: [String]=["poem writing","gym" , "reading", "cooking", "organization", "coloring coloring pages"]
var numberOfHobbies: Int = hobbies.count
var favoriteNumber: Int = 8
let zodiacSign: String = "Libra"

var futureGoals: [String] = [
    "To build a fulfilling career in a field that I truly love and enjoy", "To maintain good health, a strong body, and a sound mind throughout my life", "To achieve wealth in all dimensions — intellectual, physical, emotional, and financial", "To continue developing myself through lifelong learning and new experiences", "To cultivate meaningful relationships with family, friends, and colleagues", "To travel the world and broaden my perspective by discovering new cultures", "to be happy"]

let lifeStory = """
Good day, dear Professor, let me introduce myself, My name is \(firstName) \(lastName) \(surname ?? ""). I was born on \(birthDay) . \(birthMonth) . \(birthYear) in \(birthPlace), and I am \(age) years old, so based on the date of birth i am \(zodiacSign) and it matters. Am I a student? \(isStudent ? "Yes" : "No") nowadays and really enjoy it. Talking about the external characteristics by which you will be able to recognize me in the audience: my height is \(height) meters; I have \(eyeColor) eyes and \(hairColor) hair; I come from a family of \(familyMembers) members. I enjoy activities such as \(hobbies.joined(separator: ", ")). In total, I have \(numberOfHobbies) hobbies and I think that this is still not enough and we need to continue to develop in all directions. My favorite number is \(favoriteNumber) and I believe that this number describes me well and brings good luck. Looking ahead, my future goals include:
- \(futureGoals.joined(separator: "\n- "))and I hope that everything will come true
"""

print(lifeStory)


