"
I'm a result of searching FFI calls on the system, and provide a useful API for UIs.
"
Class {
	#name : #FFICallAnalysis,
	#superclass : #Object,
	#instVars : [
		'ffiCalls'
	],
	#category : #'FFICallBrowser-Core'
}

{ #category : #'instance creation' }
FFICallAnalysis class >> newWithAll: aCollectionOfFFICalls [

	^ self basicNew
		  initializeWith: aCollectionOfFFICalls;
		  yourself
]

{ #category : #accessing }
FFICallAnalysis >> ffiCalls [

	^ ffiCalls
]

{ #category : #accessing }
FFICallAnalysis >> ffiCalls: aCollection [

	ffiCalls := aCollection
]

{ #category : #query }
FFICallAnalysis >> ffiCallsByFunctionName [
	
	^ ffiCalls groupedBy: [ :each | each functionName ]
]

{ #category : #query }
FFICallAnalysis >> functionNames [
	
	^ ffiCalls collect: [ :each | each functionName ] as: Set
]

{ #category : #initialization }
FFICallAnalysis >> initializeWith: aCollectionOfFFICalls [

	self initialize.
	ffiCalls := aCollectionOfFFICalls
]

{ #category : #sorting }
FFICallAnalysis >> sortByFunctionName [

	ffiCalls sort: [ :x :y | x functionName < y functionName ]

]
