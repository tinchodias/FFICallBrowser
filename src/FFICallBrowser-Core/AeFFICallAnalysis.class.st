Class {
	#name : #AeFFICallAnalysis,
	#superclass : #Object,
	#instVars : [
		'ffiCalls'
	],
	#category : #'FFICallBrowser-Core'
}

{ #category : #'instance creation' }
AeFFICallAnalysis class >> newWithAll: aCollectionOfFFICalls [

	^ self basicNew
		  initializeWith: aCollectionOfFFICalls;
		  yourself
]

{ #category : #accessing }
AeFFICallAnalysis >> ffiCalls [

	^ ffiCalls
]

{ #category : #accessing }
AeFFICallAnalysis >> ffiCalls: anObject [

	ffiCalls := anObject
]

{ #category : #query }
AeFFICallAnalysis >> ffiCallsByFunctionName [
	
	^ ffiCalls groupedBy: [ :each | each functionName ]
]

{ #category : #query }
AeFFICallAnalysis >> functionNames [
	
	^ ffiCalls collect: [ :each | each functionName ] as: Set
]

{ #category : #initialization }
AeFFICallAnalysis >> initializeWith: aCollectionOfFFICalls [

	self initialize.
	ffiCalls := aCollectionOfFFICalls
]

{ #category : #sorting }
AeFFICallAnalysis >> sortByFunctionName [

	ffiCalls sort: [ :x :y | x functionName < y functionName ]

]
