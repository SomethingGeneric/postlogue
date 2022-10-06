#[macro_use] extern crate rocket;

use std::borrow::Cow;

use rocket::State;
use rocket::tokio::sync::Mutex;
use rocket::serde::json::{Json, Value, json};
use rocket::serde::{Serialize, Deserialize};

#[derive(Serialize, Deserialize)]
#[serde(crate = "rocket::serde")]
struct Gitea<'r> {
    rref: Option<str>,
    action: Option<str>,
    repository: Option<str>
}

#[get("/")]
fn index() -> &'static str {
    "Go away"
}

#[post("/run", format="json", data="<webhook>")]
fn run(webhook: Json<Gitea>) -> &'static str {
    println!(webhook);
    json!({"foo":"bar"})
}

#[launch]
fn rocket() -> _ {
    rocket::build()
        .mount("/", routes![index])
        .mount("/run", routes![run])
}
