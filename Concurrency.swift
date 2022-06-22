import Foundation

/* self.geocoder.geocodeAddressString(combinedAddress, completionHandler: {(placemarks, error) -> Void in
	if let placemark = placemarks?[0] {
		let placemark = placemarks![0]
		self.placemarkLatitude = (placemark.location?.coordinate.latitude)!
		self.placemarkLongitude = (placemark.location?.coordinate.longitude)!
	}
})
let eventLatitude = self.placemarkLatitude // 0.0!
let eventLongitude = self.placemarkLongitude // 0.0! */

let num = 11
var rv: Int = 0

func myFunc(param: Int, completionHandler: (Int) -> Void) {
	rv = param + num
	print("in func body. rv: \(rv)")
}

myFunc(param: 10, completionHandler: {num in 
	rv = 10 * num
	print("in closure. rv: \(rv)")
})

let b = rv

print("out of closure. b: \(b)")

// 1
/* self.geocoder.geocodeAddressString(combinedAddress, completionHandler: {(placemarks, error) -> Void in
	// 2, some time later
	if let placemark = placemarks?[0] {
		// 3
		let placemark = placemarks![0]
		// 4
		self.placemarkLatitude = (placemark.location?.coordinate.latitude)!
		// 5
		self.placemarkLongitude = (placemark.location?.coordinate.longitude)!
		// 6
		let eventLatitude = self.placemarkLatitude
		// 7
		let eventLongitude = self.placemarkLongitude
		// and so on...
	}
}) */