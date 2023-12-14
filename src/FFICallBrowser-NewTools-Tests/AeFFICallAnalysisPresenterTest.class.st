"
An AeFFICallAnalysisPresenterTest is a test class for testing the behavior of AeFFICallAnalysisPresenter
"
Class {
	#name : #AeFFICallAnalysisPresenterTest,
	#superclass : #TestCase,
	#category : #'FFICallBrowser-NewTools-Tests'
}

{ #category : #tests }
AeFFICallAnalysisPresenterTest >> testOpenOnAllCalls [

	| window |
	window := AeFFICallAnalysisPresenter openOnAllCalls.
	window close
]
