"
I'm a Spec presenter for `AeFFICallAnalysis`.
"
Class {
	#name : #AeFFICallAnalysisPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'analysis',
		'callsTable',
		'sourceCode'
	],
	#category : #'FFICallBrowser-NewTools'
}

{ #category : #layout }
AeFFICallAnalysisPresenter >> defaultLayout [

	^ SpPanedLayout newTopToBottom
		add: #callsTable;
		add: #sourceCode;
		positionOfSlider: 0.5;
		yourself
]

{ #category : #initialization }
AeFFICallAnalysisPresenter >> initializePresenters [

	sourceCode :=
		self newCode
			beNotEditable;
			yourself.

	callsTable := self newTable
		addColumn: (SpStringTableColumn new 
			title: 'Function Name';
			evaluated: [ :each | each functionName ];
			beSortable;
			yourself);
		addColumn: (SpStringTableColumn new  
			title: 'FFI Method';
			evaluated: [ :each | each method name ];
			beSortable;
			yourself);
		items: analysis ffiCalls;
		
		enableSearch;
		searchMatching: [ :each :patternString |
			each functionName includesSubstring: patternString ];
		
		activateOnDoubleClick;
		whenActivatedDo: [ :selection | selection selectedItem method browse ];

		whenSelectedDo: [ :selection |
			sourceCode
				beForMethod: selection method;
				text: selection method sourceCode ];
			
		yourself.
]

{ #category : #initialization }
AeFFICallAnalysisPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'FFI Call Browser';
		initialExtent: 600 @ 800
]

{ #category : #'accessing - model' }
AeFFICallAnalysisPresenter >> setModelBeforeInitialization: anObject [

	analysis := anObject
]
