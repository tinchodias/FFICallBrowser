"
I query all FFI calls from Pharo that satisfy certain criteria.
"
Class {
	#name : #AeFFICallAnalyzer,
	#superclass : #Object,
	#instVars : [
		'ffiCallingSelectors',
		'ffiCalls',
		'methodSelectionBlock'
	],
	#category : #'FFICallBrowser-Core'
}

{ #category : #examples }
AeFFICallAnalyzer class >> example [

	(self new
		run;
		newAnalysis) inspect
]

{ #category : #private }
AeFFICallAnalyzer >> candidateCallsDo: aBlock [

	self ffiCallingSelectors do: [ :eachFFICallingSelector |
		(self sendersTo: eachFFICallingSelector) do: [ :eachMethod |
			aBlock
				value: eachMethod
				value: eachFFICallingSelector ] ]
]

{ #category : #accessing }
AeFFICallAnalyzer >> ffiCallingSelectors [

	^ ffiCallingSelectors
]

{ #category : #accessing }
AeFFICallAnalyzer >> ffiCallingSelectors: aCollectionOfSymbols [

	ffiCallingSelectors := aCollectionOfSymbols
]

{ #category : #analysis }
AeFFICallAnalyzer >> ffiCalls [ 

	^ ffiCalls
]

{ #category : #initialization }
AeFFICallAnalyzer >> initialize [

	super initialize.
	
	methodSelectionBlock := [ :aCompiledMethod | true ].
	ffiCallingSelectors :=
		Array streamContents: [ :stream |
			Object selectorsDo: [ :each |
				(each beginsWith: 'ffiCall:')
					ifTrue: [ stream nextPut: each ] ] ]
]

{ #category : #accessing }
AeFFICallAnalyzer >> methodSelectionBlock [

	^ methodSelectionBlock
]

{ #category : #accessing }
AeFFICallAnalyzer >> methodSelectionBlock: aBlock [

	methodSelectionBlock := aBlock
]

{ #category : #analysis }
AeFFICallAnalyzer >> newAnalysis [ 

	^ AeFFICallAnalysis newWithAll: ffiCalls
]

{ #category : #analysis }
AeFFICallAnalyzer >> run [

	ffiCalls := OrderedCollection new.

	self candidateCallsDo: [ :aMethod :aSelector |
		| aCallCandidate |
		aCallCandidate :=
			AeFFICall
				newWithMethod: aMethod
				ffiCallingSelector: aSelector.
		(aCallCandidate isValid and: [
		methodSelectionBlock value: aCallCandidate ])
			ifTrue: [ ffiCalls add: aCallCandidate ] ]
]

{ #category : #private }
AeFFICallAnalyzer >> sendersTo: aSelector [

	^ SystemNavigation default allReferencesTo: aSelector
]
