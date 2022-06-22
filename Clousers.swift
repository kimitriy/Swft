import Foundation

//CLOSURES_________________________________________________________________________
//a closure is a special type of function without the function name
//closures can be considered as a data type like Int or String
//thus a closure can be assigned to var or let

/*
{ (parameters) -> returnType in
	// statements
}

parameters - any value passed to closure
returnType - specifies the type of value returned by the closure
in (optional) - used to separate parameters/returnType from closure body
*/

let greet = {
	print("Hello, closure!")
}

//to execute the closure call the var or let it was assigned to as a function i.e. with ()
greet()

//CLOSURE PARAMETERS_______________________________________________________________

let greetUser = { (name: String) in
	print("Hey there, \(name).")
}

greetUser("Delilah")


//CLOSURE THAT RETURNS VALUE_______________________________________________________________

var findSquare = { (num: Int) -> (Int) in
	let square = num * num
	return square
}

var result: Int = findSquare(4)
print("Square:",result)


//CLOSURE AS FUNCTION PARAMETER_______________________________________________________________

func grabLunch(search: () -> ()) {
	print("Let's go out for lunch")
	search()
}

/*
search - function parameter
() -> () - represents the type of the closure
search() - call closure from the inside of the function
*/

//now, to call this function, we need to pass a closure as its argument
grabLunch(search: {
	print("Alfredo's Pizza: 2 miles away")
})


//TRAILING CLOSURES_________________________________________________________________
//RULE: in trailing closure, if a function accepts a closure as its last parameter:

func grabLunch(message: String, search: ()->()) {
	print(message)
	search()
}

//the function can be called by passing the closure argument as function definition:
grabLunch(message:"Let's go out for lunch") {
	print("Alfredo's Pizza: 2 miles away")
}


//CAPTURING VALUES_________________________________________________________________

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
	var runningTotal = 0
	func incrementer() -> Int {
		runningTotal += amount
		return runningTotal
	}
	return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)

print("incrementByTen: \(incrementByTen())")
print("incrementByTen: \(incrementByTen())")
print("incrementByTen: \(incrementByTen())")

let incrementBySeven = makeIncrementer(forIncrement: 7)

print("incrementBySeven: \(incrementBySeven())")
print("incrementByTen: \(incrementByTen())")

let alsoIncrementByTen = makeIncrementer(forIncrement: 10)
print("alsoIncrementByTen: \(alsoIncrementByTen())")






//ESCAPING CLOSURES_________________________________________________________________
//in order to save a closure after a function ending up, it should be saved in variable that declared outside of the function


var completionHandlers: [() -> Void] = []

func someFunctionWithEscapingClouser(completionHandler: @escaping () -> Void) {
	completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClouser(closure: () -> Void) {
	closure()
}

class SomeCLass {
	var x = 10
	func doSomething() {
		someFunctionWithEscapingClouser { [self] in x = 100 }
		someFunctionWithNonescapingClouser { x = 200 }
	}
}

let instance = SomeCLass()

instance.doSomething()
print(instance.x)

completionHandlers.first?() //completionHandlers[0]()
print(instance.x)



//AUTO CLOSURES_________________________________________________________________
//While calling a function, we can also pass the closure without using the braces {}
//To pass the closure argument without using braces, we must use the @autoclosure keyword in function definition.

func display(text: String, griit: @autoclosure () -> ()) {
	print(text)
	griit()
}

display(text: "Say something!", griit: print("Hello World!"))

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)

/*
//array.remove(at index: Int) -> String
//thus type of customProvider has been inferred as () -> String closure
//here we assign closure to customProvider, but the closure itself has not been called yet
let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)

print("Now serving \(customerProvider())!") //here we call the closure itself
print(customersInLine.count)
*/

/* 
func serve(customer customerProvider: () -> String) {
	print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )
print(customersInLine.count)
 */

/* 
func serve(customer customerProvider: @autoclosure () -> String) {
	print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))
print(customersInLine.count)
 */


var customerProviders: [() -> String] = []

func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
	customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) closures.")

for customerProvider in customerProviders {
	print("Now serving \(customerProvider())!")
}
