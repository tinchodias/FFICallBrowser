Class {
	#name : #BaselineOfFFICallBrowser,
	#superclass : #BaselineOf,
	#category : #BaselineOfFFICallBrowser
}

{ #category : #baseline }
BaselineOfFFICallBrowser >> baseline: spec [
	<baseline>

	spec
		for: #common
		do: [ 
			spec
				package: 'FFICallBrowser-Core';
				package: 'FFICallBrowser-NewTools' with: [ spec requires: #('FFICallBrowser-Core') ];
				package: 'FFICallBrowser-Tests' with: [ spec requires: #('FFICallBrowser-Core') ] ]
]
