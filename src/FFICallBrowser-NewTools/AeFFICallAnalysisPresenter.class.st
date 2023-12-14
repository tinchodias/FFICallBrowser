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

{ #category : #example }
AeFFICallAnalysisPresenter class >> openOnAllCalls [
	<script: 'self openOnAllCalls'>

	| analysis |
	analysis := AeFFICallAnalyzer new
		methodSelectionBlock: [ :aFFICall | true ];
		run;
		newAnalysis.
	^ analysis
		sortByFunctionName;
		openBrowser
]

{ #category : #accessing }
AeFFICallAnalysisPresenter >> analysis: anAnalysis [

	analysis := anAnalysis.
	
	self refreshOnAnalysisUpdate
]

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
AeFFICallAnalysisPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'FFI Call Browser';
		initialExtent: 600 @ 800
]

{ #category : #accessing }
AeFFICallAnalysisPresenter >> refreshOnAnalysisUpdate [

	(callsTable isNil or: [ analysis isNil ])
		ifFalse: [ callsTable items: analysis ffiCalls ]
]

{ #category : #'accessing - model' }
AeFFICallAnalysisPresenter >> setModelBeforeInitialization: anAnalysis [

	self analysis: anAnalysis
]
