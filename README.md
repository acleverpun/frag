# FRAG

Framework for Rather Awesome Games

![Dan Rather](http://cdn.newsbusters.org/images/2013/January/Rather%20123.jpg)

Game framework inspired by the illustrious [LÖVE](https://love2d.org/).

The plan for FRAG is to create a framework using the following tech stack
(subject to change):

- [Nim](https://nim-lang.org/) for the core framework code
	- Also have prototypes started in both [Rust](https://www.rust-lang.org/en-US/) and C++
		that I may fall back to if I don't like Nim for this.
- [bgfx](https://github.com/bkaradzic/bgfx) for rendering
- [OpenAL](https://www.openal.org/) for audio
- [SDL](https://www.libsdl.org/) (maybe) for input
- JavaScript for scripting
	- I've been experimenting with [ChakraCore](https://github.com/Microsoft/ChakraCore),
		[SpiderMonkey](https://developer.mozilla.org/en-US/docs/Mozilla/Projects/SpiderMonkey),
		[Duktape](https://github.com/svaarala/duktape),
		and [v8](https://github.com/v8/v8),
		and I have to say I like Chakra best for embedding so far.
		Modern, but still not too crazy to embed.

The goal is to facilitate writing games using modern JavaScript,
in a way similar to how LÖVE employs Lua.
I am a longtime user of LÖVE, and while there are of course things I löve about it,
I have issues with Lua's (lack of an) ecosystem,
which eventually managed to bother me enough to make me try my own hand.
I have a stretch goal of allowing combinations of Nim and JS, but who knows.
