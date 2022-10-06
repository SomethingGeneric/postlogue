#[macro_use] extern crate rocket;

use serde_json::{Result, Value};

#[get("/")]
fn index() -> &'static str {
    "Go away"
}

#[post("/run", format="application/json", data="<webhook>")]
fn run(webhook: String) -> &'static str { 
    let webdat: Value = serde_json::from_str(&webhook).unwrap();

    // These fail if there is no such key, and I continue to fail
    // in regards to figuring out how to check the available values
    let rref = webdat.get("ref").unwrap();
    let action = webdat.get("action").unwrap();

    return "Foo";
}

#[launch]
fn rocket() -> _ {
    rocket::build().mount("/", routes![index, run])
}
