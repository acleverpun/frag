#[macro_use]
extern crate js;

use js::jsapi::CompartmentOptions;
use js::jsapi::JS_NewGlobalObject;
use js::jsapi::OnNewGlobalHookOption;
use js::jsval::UndefinedValue;
use js::rust::{Runtime, SIMPLE_GLOBAL_CLASS};

use std::ptr;

fn evaluate() {
	let rt = Runtime::new();
	let cx = rt.cx();

	unsafe {
		rooted!(in(cx) let global =
			JS_NewGlobalObject(
				cx, &SIMPLE_GLOBAL_CLASS, ptr::null_mut(),
				OnNewGlobalHookOption::FireOnNewGlobalHook,
				&CompartmentOptions::default()
			)
		);
		rooted!(in(cx) let mut rval = UndefinedValue());
		let _ = rt.evaluate_script(global.handle(), "const foo = () => 5; let bar = foo(); bar;", "test", 1, rval.handle_mut());
		println!("{}", rval.is_number());
	}
}

fn main() {
	println!("Hi, Mom!");
	evaluate();
}
