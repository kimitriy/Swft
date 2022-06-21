import Foundation

//CLOSURES_________________________________________________________________________


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
