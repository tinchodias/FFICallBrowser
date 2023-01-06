Class {
	#name : #AeFFICall,
	#superclass : #Object,
	#instVars : [
		'method',
		'ffiCallingSelector',
		'functionName'
	],
	#category : #'FFICallBrowser-Core'
}

{ #category : #'instance creation' }
AeFFICall class >> newWithMethod: aCompiledMethod ffiCallingSelector: aSymbol [

	^ self basicNew
		initializeWithMethod: aCompiledMethod
			ffiCallingSelector: aSymbol;
		yourself
]

{ #category : #accessing }
AeFFICall >> detectAstMessageNodeIfNone: absentBlock [

	method ast body nodesDo: [ :eachNode |
	 (eachNode isMessage and: [
		eachNode selector = ffiCallingSelector ])
			ifTrue: [ ^ eachNode ] ].

	absentBlock value

]

{ #category : #accessing }
AeFFICall >> ffiCallingSelector [

	^ ffiCallingSelector
]

{ #category : #accessing }
AeFFICall >> functionName [

	^ functionName
]

{ #category : #initialization }
AeFFICall >> initializeWithMethod: aCompiledMethod ffiCallingSelector: aSymbol [

	| astNode firstArgument |
	self initialize.
	
	method := aCompiledMethod.
	ffiCallingSelector := aSymbol.

	astNode := self detectAstMessageNodeIfNone: [ ^ self ].

	firstArgument := astNode arguments first.
	firstArgument isLiteralArray ifFalse: [ ^ self ].

	firstArgument value reversed readStreamDo: [:stream |
		"Ignore function parameters enclosed by parenthesis"
		stream next.
		functionName := stream next asSymbol ].
		

]

{ #category : #testing }
AeFFICall >> isValid [

	^ functionName notNil
]

{ #category : #accessing }
AeFFICall >> method [

	^ method
]

{ #category : #printing }
AeFFICall >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPut: $(;
		print: method;
		nextPut: $)

]
