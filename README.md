# FRAG

Framework for Rather Awesome Games

![Dan Rather](http://cdn.newsbusters.org/images/2013/January/Rather%20123.jpg)

Game framework inspired by the illustrious [LÖVE](https://love2d.org/).

The plan for FRAG is to create a framework using the following tech stack
(subject to change):

- [Rust](https://www.rust-lang.org/en-US/) for the core framework code
	- Also have a prototype started locally in C++ that I may fall back to if I don't like Rust for this.
- [bgfx](https://github.com/bkaradzic/bgfx) for rendering
- [OpenAL](https://www.openal.org/) for audio
- [SDL](https://www.libsdl.org/) (maybe) for input
- [ChakraCore](https://github.com/Microsoft/ChakraCore) for JavaScript scripting
	- I've been experimenting with this, [Duktape](https://github.com/svaarala/duktape), and [v8](https://github.com/v8/v8), and I have to say I like this best so far. Very modern, but still not too crazy to embed, using [JSRT](https://github.com/Microsoft/ChakraCore/wiki/JavaScript-Runtime-%28JSRT%29-Overview).

The goal is to facilitate writing games using modern JavaScript,
in a way similar to how LÖVE employs Lua.
I am a longtime user of LÖVE, and while there are of course things I löve about it,
I have issues with Lua's (lack of an) ecosystem,
which eventually managed to bother me enough to make me try my own hand.
