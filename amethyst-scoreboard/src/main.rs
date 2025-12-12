use std::sync::Arc;
use std::env;

use crate::appstate::AppState;

mod db;
mod api;
mod schema;
mod auth;
mod appstate;

#[tokio::main]
async fn main() {
    let conn = Arc::new(
        AppState {
            api_key: env::var("AMETHYST_API_KEY")
                .expect("AMETHYST_API_KEY not set."),
            conn: db::get_db().expect("Failed to init db")
            }
        );

    api::run(conn).await;
}


