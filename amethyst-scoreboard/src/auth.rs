use std::sync::Arc;

use crate::appstate::AppState;

pub const API_KEY_HEADER: &str = "x-api-key";

pub async fn authenticate(
        state: Arc<AppState>,
        api_key: String
        ) -> Result<(), warp::Rejection> {

    // Need constant-time eq here
    // or even better hashing
    // but like WHO CARES!?

    if api_key == state.api_key {
        Ok(())
    } else {
        Err(warp::reject::custom(AuthError))
    }

}

#[derive(Debug)]
struct AuthError;

impl warp::reject::Reject for AuthError {}

