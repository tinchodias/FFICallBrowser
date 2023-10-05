"
I represent a FFI call candidate. Only when I answer true to `#isValid`, it means that I did find a FFI function name, and I can be considered a FFI call.
"
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
AeFFICall >> detectASTMessageSendNodeIfNone: absentBlock [

	method ast body nodesDo: [ :eachNode |
		(eachNode isMessage and: [
		eachNode selector = ffiCallingSelector ])
			ifTrue: [ ^ eachNode ] ].

	absentBlock value

]

{ #category : #initialization }
AeFFICall >> detectFunctionName [

	| astNode firstArgument |
	astNode := self detectASTMessageSendNodeIfNone: [ ^ self ].

	firstArgument := astNode arguments first.
	firstArgument isLiteralArray ifFalse: [ ^ self ].

	firstArgument value reversed readStreamDo: [:stream |
		"Ignore function parameters enclosed by parenthesis"
		stream next.
		functionName := stream next asSymbol ]
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

	self initialize.
	
	method := aCompiledMethod.
	ffiCallingSelector := aSymbol.

	self detectFunctionName
]

{ #category : #testing }
AeFFICall >> isValid [

	^ functionName notNil
]

{ #category : #accessing }
AeFFICall >> method [

	^ method
]

{ #category : #accessing }
AeFFICall >> packageName [

	^ method package name
]

{ #category : #testing }
AeFFICall >> packageNameBeginsWith: aString [

	^ self packageName beginsWith: aString
]

{ #category : #printing }
AeFFICall >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPut: $(;
		print: method;
		nextPut: $)

]
