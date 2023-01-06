Extension { #name : #AeFFICallAnalysis }

{ #category : #'*FFICallBrowser-NewTools' }
AeFFICallAnalysis >> browse [

	^ SpTablePresenter new
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
		items: self ffiCalls;
		
		enableSearch;
		searchMatching: [ :each :patternString |
			each functionName includesSubstring: patternString ];
		
		activateOnDoubleClick;
		whenActivatedDo: [ :selection | selection selectedItem method browse ];
			
		open;
		yourself.
]

{ #category : #'*FFICallBrowser-NewTools' }
AeFFICallAnalysis >> inspectionOn: aBuilder [
	<inspectorPresentationOrder: 1 title: 'FFI Calls'>
	
	^ aBuilder newTable
		items: self ffiCalls;
		beResizable;

		searchMatching: [ :each :patternString |
			each functionName includesSubstring: patternString ];

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
		
		yourself.
]
