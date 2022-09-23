use crate::Thinker;
use anyhow::Result;
use elephantry::Connection;
use thiserror::Error;

pub struct ZtlNoteSession {
    connection: Connection,
}

#[derive(Error, Debug)]
enum ZtlNoteSessionError {
    #[error("database error: {context} (original error: {error:?}")]
    Database {
        context: String,
        error: Box<dyn std::error::Error>,
    },
}

impl ZtlNoteSession {
    pub fn new(connection: Connection) -> Self {
        Self { connection }
    }

    pub fn create_thinker(&self, name: &str) -> Result<Thinker> {
        todo!()
    }
}
