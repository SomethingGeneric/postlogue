#[macro_use] extern crate rocket;

use std::collections::HashMap;

use rocket::serde::{Deserialize, json::Json};

#[derive(Deserialize)]
#[serde(crate = "rocket::serde")]
struct GiteaResponse {
    gref: Option<String>,
    action: Option<String>,
    repository: Option<HashMap<String,String>>
}

#[get("/")]
fn index() -> &'static str {
    "Go away"
}

#[post("/run", format="application/json", data="<webhook>")]
fn run(webhook: String) -> &'static str { 
    let webdat: GiteaResponse = serde_json::from_str(&webhook).unwrap();

    return "Foo";
}

#[launch]
fn rocket() -> _ {
    rocket::build().mount("/", routes![index, run])
}
