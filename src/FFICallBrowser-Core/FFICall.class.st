"
I represent a FFI call candidate. Only when I answer true to `#isValid`, it means that I did find a FFI function name, and I can be considered a FFI call.
"
Class {
	#name : #FFICall,
	#superclass : #Object,
	#instVars : [
		'method',
		'ffiCallingSelector',
		'functionName'
	],
	#category : #'FFICallBrowser-Core'
}

{ #category : #'instance creation' }
FFICall class >> newWithMethod: aCompiledMethod ffiCallingSelector: aSymbol [

	^ self basicNew
		initializeWithMethod: aCompiledMethod
			ffiCallingSelector: aSymbol;
		yourself
]

{ #category : #accessing }
FFICall >> detectASTMessageSendNodeIfNone: absentBlock [

	method ast body nodesDo: [ :eachNode |
		(eachNode isMessage and: [
		eachNode selector = ffiCallingSelector ])
			ifTrue: [ ^ eachNode ] ].

	absentBlock value

]

{ #category : #initialization }
FFICall >> detectFunctionName [

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
FFICall >> ffiCallingSelector [

	^ ffiCallingSelector
]

{ #category : #accessing }
FFICall >> functionName [

	^ functionName
]

{ #category : #initialization }
FFICall >> initializeWithMethod: aCompiledMethod ffiCallingSelector: aSymbol [

	self initialize.
	
	method := aCompiledMethod.
	ffiCallingSelector := aSymbol.

	self detectFunctionName
]

{ #category : #testing }
FFICall >> isValid [

	^ functionName notNil
]

{ #category : #accessing }
FFICall >> method [

	^ method
]

{ #category : #accessing }
FFICall >> packageName [

	^ method package name
]

{ #category : #testing }
FFICall >> packageNameBeginsWith: aString [

	^ self packageName beginsWith: aString
]

{ #category : #printing }
FFICall >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPut: $(;
		print: method;
		nextPut: $)

]
