import Foundation



func myFunc(param: String, closure: (Int) -> ()) {
	closure(10)
	print("in func body: \(param)")
}

myFunc(param: "wtf", closure: { num in
	var rv = 11
	rv += num
	print("in closure: \(rv)")
})

print("out of closure")

// func add(a: Int, b: Int, _ action: (Int) -> Void) {
// 	let sum = a + b
// 	action(sum)
// }

// add(a: 10, b: 20, { res in
// 	print(res)
// })

func add(a: Int, b: Int, _ action: (Int, Int) -> Int) {
	print(action(a, b))
}

add(a: 10, b: 20, { num1, num2 in
	return (num1 * num2)
})

func howAreYou(_ responseHandler: @escaping (String) -> Void) {
	print("Hey, how are you?") // you ask how are you
  
	// It takes 2 seconds for your friend to answer:
	DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
		responseHandler("Hi, I'm doing really good.")
	})

	print("Responding takes a while...")
}
howAreYou({ friendResponse in
	print(friendResponse) // print the response that arrives later
})