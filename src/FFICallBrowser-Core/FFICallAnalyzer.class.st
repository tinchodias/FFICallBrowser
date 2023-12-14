"
I query all FFI calls from Pharo that satisfy certain criteria.
"
Class {
	#name : #FFICallAnalyzer,
	#superclass : #Object,
	#instVars : [
		'ffiCallingSelectors',
		'ffiCalls',
		'methodSelectionBlock'
	],
	#category : #'FFICallBrowser-Core'
}

{ #category : #examples }
FFICallAnalyzer class >> example [

	(self new
		run;
		newAnalysis) inspect
]

{ #category : #private }
FFICallAnalyzer >> candidateCallsDo: aBlock [

	self ffiCallingSelectors do: [ :eachFFICallingSelector |
		(self sendersTo: eachFFICallingSelector) do: [ :eachMethod |
			aBlock
				value: eachMethod
				value: eachFFICallingSelector ] ]
]

{ #category : #accessing }
FFICallAnalyzer >> ffiCallingSelectors [

	^ ffiCallingSelectors
]

{ #category : #accessing }
FFICallAnalyzer >> ffiCallingSelectors: aCollectionOfSymbols [

	ffiCallingSelectors := aCollectionOfSymbols
]

{ #category : #analysis }
FFICallAnalyzer >> ffiCalls [ 

	^ ffiCalls
]

{ #category : #initialization }
FFICallAnalyzer >> initialize [

	super initialize.
	
	methodSelectionBlock := [ :aCompiledMethod | true ].
	ffiCallingSelectors :=
		Array streamContents: [ :stream |
			Object selectorsDo: [ :each |
				(each beginsWith: 'ffiCall:')
					ifTrue: [ stream nextPut: each ] ] ]
]

{ #category : #accessing }
FFICallAnalyzer >> methodSelectionBlock [

	^ methodSelectionBlock
]

{ #category : #accessing }
FFICallAnalyzer >> methodSelectionBlock: aBlock [

	methodSelectionBlock := aBlock
]

{ #category : #analysis }
FFICallAnalyzer >> newAnalysis [ 

	^ FFICallAnalysis newWithAll: ffiCalls
]

{ #category : #analysis }
FFICallAnalyzer >> run [

	ffiCalls := OrderedCollection new.

	self candidateCallsDo: [ :aMethod :aSelector |
		| aCallCandidate |
		aCallCandidate :=
			FFICall
				newWithMethod: aMethod
				ffiCallingSelector: aSelector.
		(aCallCandidate isValid and: [
		methodSelectionBlock value: aCallCandidate ])
			ifTrue: [ ffiCalls add: aCallCandidate ] ]
]

{ #category : #private }
FFICallAnalyzer >> sendersTo: aSelector [

	^ SystemNavigation default allReferencesTo: aSelector
]
