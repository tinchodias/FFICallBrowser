# FFICallBrowser

A tool to query FFI calls from Pharo.

It is centered on the analyzer, that detects all message sends of `ffiCall:` and variants, and detects the function name from the arguments.
It uses `SystemNavigation` and `AST` for that.

Please check our [wiki](../../wiki) for more information.

## License

This code is licensed under the [MIT license](./LICENSE).
