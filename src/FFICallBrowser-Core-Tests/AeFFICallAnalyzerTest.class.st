"
An AeFFICallAnalyzerTest is a test class for testing the behavior of AeFFICallAnalyzer
"
Class {
	#name : #AeFFICallAnalyzerTest,
	#superclass : #TestCase,
	#category : #'FFICallBrowser-Core-Tests'
}

{ #category : #tests }
AeFFICallAnalyzerTest >> testExample [

	| anAnalysis |
	anAnalysis := AeFFICallAnalyzer new
		methodSelectionBlock: [ :aFFICall |
			(aFFICall functionName beginsWith: 'fake_') and: [
			aFFICall method package name = self class package name ] ];
		run;
		newAnalysis.

	self assert: anAnalysis ffiCalls size equals: 2.
]
