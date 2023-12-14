"
I'm a Spec presenter for `AeFFICallAnalysis`.
"
Class {
	#name : #FFICallAnalysisPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'analysis',
		'callsTable',
		'sourceCode'
	],
	#category : #'FFICallBrowser-NewTools'
}

{ #category : #example }
FFICallAnalysisPresenter class >> openOnAllCalls [
	<script: 'self openOnAllCalls'>

	| analysis |
	analysis := FFICallAnalyzer new
		methodSelectionBlock: [ :aFFICall | true ];
		run;
		newAnalysis.
	^ analysis
		sortByFunctionName;
		openBrowser
]

{ #category : #accessing }
FFICallAnalysisPresenter >> analysis: anAnalysis [

	analysis := anAnalysis.
	
	self refreshOnAnalysisUpdate
]

{ #category : #layout }
FFICallAnalysisPresenter >> defaultLayout [

	^ SpPanedLayout newTopToBottom
		add: #callsTable;
		add: #sourceCode;
		positionOfSlider: 0.5;
		yourself
]

{ #category : #initialization }
FFICallAnalysisPresenter >> initializePresenters [

	sourceCode :=
		self newCode
			beNotEditable;
			yourself.

	callsTable := self newTable.

	callsTable
		alternateRowsColor;

		addColumn: (SpStringTableColumn new 
			title: 'Function Name';
			evaluated: [ :each | each functionName ];
			beSortable;
			yourself);
		addColumn: (SpStringTableColumn new  
			title: 'Method origin';
			evaluated: [ :each | each method origin name ];
			beSortable;
			yourself);
		addColumn: (SpStringTableColumn new  
			title: 'Method selector';
			evaluated: [ :each | each method selector ];
			beSortable;
			yourself);
		
		enableSearch;
		searchMatching: [ :each :patternString |
			each functionName includesSubstring: patternString ];
		
		activateOnDoubleClick;
		whenActivatedDo: [ :selection | selection selectedItem method browse ];

		whenSelectedDo: [ :selection |
			sourceCode
				beForMethod: selection method;
				text: selection method sourceCode ].
			
	self refreshOnAnalysisUpdate
]

{ #category : #initialization }
FFICallAnalysisPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'FFI Call Browser';
		initialExtent: 600 @ 800
]

{ #category : #accessing }
FFICallAnalysisPresenter >> refreshOnAnalysisUpdate [

	(callsTable isNil or: [ analysis isNil ])
		ifFalse: [ callsTable items: analysis ffiCalls ]
]

{ #category : #'accessing - model' }
FFICallAnalysisPresenter >> setModelBeforeInitialization: anAnalysis [

	self analysis: anAnalysis
]
