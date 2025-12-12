use std::convert::Infallible;
use std::sync::Arc;
use warp::Filter;
use warp::http::StatusCode;
use warp::reply::with_status;

use crate::schema;
use crate::db;
use crate::auth;
use crate::appstate::AppState;

pub async fn post_record(
        state: Arc<AppState>,
        payload: schema::PostRecord,
        //payload_bytes: bytes::Bytes,
    ) -> Result<impl warp::Reply, Infallible> {

    Ok(match db::post_record(&state.conn, &payload) {
        Ok(()) => with_status(
            String::from("Ok!"), StatusCode::OK),
        Err(e) => with_status(
            format!("{:#?}", e), StatusCode::INTERNAL_SERVER_ERROR),
    })

}

pub async fn get_top(
        state: Arc<AppState>,
        payload: schema::GetTop,
    ) -> Result<Box<dyn warp::Reply>, Infallible> {

    // Here the response type is Box because
    // there are two possible responses
    // warp::reply::json and String
    // which have different sizes
    // so we need to have indirection.

    Ok(match db::get_top(&state.conn, &payload) {
        Ok(v) => Box::new(with_status(
            warp::reply::json(&v),
            StatusCode::OK
            )),
        Err(e) => Box::new(with_status(
            format!("{:#?}", e),
            StatusCode::INTERNAL_SERVER_ERROR
            )),
    })
}

pub async fn run(
        state: Arc<AppState>,
    ) {

    // TODO how to do this in a non-stupid way?
    let state1 = state.clone();
    let state2 = state.clone();
    let state3 = state.clone();

    let auth_filter = warp::header::header(auth::API_KEY_HEADER)
        .and_then(
            move |header| {
                auth::authenticate(state3.clone(), header)
                }
            );

    warp::serve(
        (
            warp::path::end()
            .and_then(hello)
        ).or(
            warp::path!("score")
            .and(auth_filter.clone())  // ??
            .and(warp::post())
            .and(warp::body::json())
            .and_then(
                //
                //    .----  I think, for some reason,
                //    |      the x-api-key header value
                //    |      also gets propagated here?
                //    |      Either way don't need it
                //    |      in the actual endpoint
                //    V
                move |_, payload: schema::PostRecord| {
                    post_record(state1.clone(), payload)
                }
            )
        ).or(

            warp::path!("score" / "top")
            .and(warp::get())
            .and(warp::query::<schema::GetTop>())
            .and_then(
                move |payload: schema::GetTop| {
                    get_top(state2.clone(), payload)
                }
            )

        )
    )
        .run(([0, 0, 0, 0], 3030))
        .await
        ;
}

async fn hello() -> Result<String, warp::Rejection> {
    //return Ok(
    //    format!(
    //        "Hello! I am {} version {}. I am licensed under {}, \
    //        and my source code is at {}.",
    //        env!("CARGO_PKG_NAME"),
    //        env!("CARGO_PKG_VERSION"),
    //        env!("CARGO_PKG_LICENSE"),
    //        env!("CARGO_PKG_REPOSITORY"),
    //    ).to_string()
    //);

    Ok(
        format!(
            "Hello! I am {} version {}. ",
            env!("CARGO_PKG_NAME"),
            env!("CARGO_PKG_VERSION"),
        ).to_string()
    )
}


