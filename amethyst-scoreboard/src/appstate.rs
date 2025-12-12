use sqlite::ConnectionThreadSafe;

pub struct AppState {
    pub api_key: String,
    pub conn: ConnectionThreadSafe
}

