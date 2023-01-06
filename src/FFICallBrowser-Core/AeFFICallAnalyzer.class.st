Class {
	#name : #AeFFICallAnalyzer,
	#superclass : #Object,
	#instVars : [
		'analysis',
		'ffiCallingSelectors',
		'ffiCalls',
		'methodSelectionBlock',
		'sortBlock',
		'referenceFinderBlock'
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
		| references |
		references := referenceFinderBlock value: eachFFICallingSelector.

		references do: [ :eachMethod |
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
	
	referenceFinderBlock := [ :aSymbol |
		SystemNavigation default allReferencesTo: aSymbol
"		SystemNavigation default allMethodsSelect: [ :each |
			each sendsSelector: aSymbol ] "].
	methodSelectionBlock := [ :aCompiledMethod | true ].
	ffiCallingSelectors := #(
		#'ffiCall:'
		#'ffiCall:module:'
		#'ffiCall:options:' ).
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

{ #category : #accessing }
AeFFICallAnalyzer >> referenceFinderBlock [

	^ referenceFinderBlock
]

{ #category : #accessing }
AeFFICallAnalyzer >> referenceFinderBlock: anObject [

	referenceFinderBlock := anObject
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
