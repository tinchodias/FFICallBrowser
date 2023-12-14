"
An AeFFICallAnalysisPresenterTest is a test class for testing the behavior of AeFFICallAnalysisPresenter
"
Class {
	#name : #FFICallAnalysisPresenterTest,
	#superclass : #TestCase,
	#category : #'FFICallBrowser-NewTools-Tests'
}

{ #category : #tests }
FFICallAnalysisPresenterTest >> testSmokeOpenOnAllCalls [

	| window |
	window := FFICallAnalysisPresenter openOnAllCalls.
	window close
]
