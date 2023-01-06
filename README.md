# FFICallBrowser

A tool to query FFI calls from Pharo.

It is centered on the analyzer, that detects all message sends of `ffiCall:`, `ffiCall:module:` and similar, and detects the function name from the arguments.

It uses `SystemNavigation` and `AST`.


## Installation

Evaluate in Pharo 11:

```Smalltalk
Metacello new
	baseline: 'FFICallBrowser';
	repository: 'github://tinchodias/FFICallBrowser';
	load
```

## Example

Inspect:

```Smalltalk
AeFFICallAnalyzer new
	methodSelectionBlock: [ :aFFICall |
		(aFFICall functionName beginsWith: 'cairo_') and: [
		aFFICall method package name beginsWith: 'Athens'] ];
	run;
	newAnalysis.
```

To see:

<img width="712" alt="Screenshot 2023-01-05 at 22 34 44" src="https://user-images.githubusercontent.com/3044265/210911750-607bc412-0d58-4eb1-9566-e57e34b4bac9.png">

The analysis implements `browse`, which you can use to search and open method in Calypso on double-click.
