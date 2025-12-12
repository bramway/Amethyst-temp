use sqlite::ConnectionThreadSafe;
use sqlite::Connection;
use sqlite::Error;
use sqlite::State;

use crate::schema::PostRecord;
use crate::schema::GetTop;
use crate::schema::ResponseGetTop;
use crate::schema::ResponseGetTopInner;

pub fn get_db() -> Result<ConnectionThreadSafe, Error> {
    let connection = Connection::open_thread_safe("scoreboard.sqlite")?;

    init_db(&connection)?;

    Ok(connection)
}

pub fn init_db(conn: &ConnectionThreadSafe) -> Result<(), Error> {
    conn.execute("
        CREATE TABLE IF NOT EXISTS records (
            timestamp INTEGER,
            ip STRING,
            username TEXT,
            country TEXT,
            kills INTEGER,
            deaths INTEGER,
            game_time INTEGER
            );
        ")
}

const QUERY_POST_RECORD: &str = "
    INSERT INTO records (
        timestamp,
        ip,
        username,
        country,
        kills,
        deaths,
        game_time
    )
    VALUES (
        :timestamp,
        :ip,
        :username,
        :country,
        :kills,
        :deaths,
        :game_time
        );
    ";

pub fn post_record(
        conn: &ConnectionThreadSafe,
        payload: &PostRecord,
        ) -> Result<(), Error> {

    let mut statement = conn.prepare(QUERY_POST_RECORD)?;

    statement.bind((":timestamp", 0))?;
    statement.bind((":ip", "foo"))?;
    statement.bind((":username", payload.username.as_str()))?;
    statement.bind((":country", "foo"))?;
    statement.bind((":kills", payload.kills))?;
    statement.bind((":deaths", payload.deaths))?;
    statement.bind((":game_time", payload.game_time))?;

    // TODO is this correct?
    while let Ok(State::Row) = statement.next() {};

    Ok(())
}

const QUERY_GET_TOP: &str = "
    SELECT * FROM records ORDER BY kills DESC LIMIT :num;
    ";

pub fn get_top(
        conn: &ConnectionThreadSafe,
        payload: &GetTop,
        ) -> Result<ResponseGetTop, Error> {

    let mut response = ResponseGetTop{top: vec![]};

    let mut statement = conn.prepare(QUERY_GET_TOP)?;

    statement.bind((":num", payload.num))?;

    // TODO I know this pattern of appending to vec
    // is not very good rust style
    // but idk how to make it better lol.
    // If it works it works so whatever.

    while let Ok(State::Row) = statement.next() {
        response.top.push(ResponseGetTopInner {
            username: statement.read::<String, _>("username")?,
            country: statement.read::<String, _>("country")?,
            kills: statement.read::<i64, _>("kills")?,
            deaths: statement.read::<i64, _>("deaths")?,
            game_time: statement.read::<i64, _>("game_time")?,
            })
    };

    Ok(response)
}


