"
I'm a stub object that implements a `ffiCall:module:` both on instance-side and class-side.
"
Class {
	#name : #FFICallTestObject,
	#superclass : #Object,
	#category : #'FFICallBrowser-Core-Tests'
}

{ #category : #'as yet unclassified' }
FFICallTestObject class >> fakeStr: aString cat: otherString [  
	^ self 
		ffiCall: #( char *fake_strcat ( void *aString, void *otherString ) )
		module: LibC

]

{ #category : #'as yet unclassified' }
FFICallTestObject >> fakeMemcpy: src to: dest size: n [
	^ self 
		ffiCall: #( void *fake_memcpy(void *dest, const void *src, size_t n) )
		module: LibC
]
