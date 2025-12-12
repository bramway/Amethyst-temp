use serde::{Deserialize, Serialize};

// We use i64 for everything because that's
// the native datatype of sqlite.
// Using the more common i32 would involve casts everywhere.

#[derive(Debug, Deserialize, Serialize)]
pub struct PostRecord {
    pub username: String,
    pub kills: i64,
    pub deaths: i64,
    pub game_time: i64,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct GetTop {
    pub num: i64,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct ResponseGetTop {
    pub top: Vec<ResponseGetTopInner>,
}

#[derive(Debug, Deserialize, Serialize)]
pub struct ResponseGetTopInner {
    pub username: String,
    pub country: String,
    pub kills: i64,
    pub deaths: i64,
    pub game_time: i64,
}



