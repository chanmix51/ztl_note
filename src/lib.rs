use anyhow::Result;

#[derive(Debug, Clone)]
pub struct Thinker {
    thinker_id: uuid::Uuid,
}

#[derive(Debug, Clone)]
pub struct PermanentNote<'a> {
    permanent_note_id: uuid::Uuid,
    thinker: &'a Thinker,
    headline: String,
    content: String,
}

#[derive(Debug)]
pub struct ZtlNoteSession {
    thinker: Thinker,
}

impl ZtlNoteSession {
    pub fn new(thinker: Thinker) -> Option<Self> {
        Some(Self { thinker })
    }

    pub fn save_permanent_note(&self, permanent_note: &PermanentNote) -> Result<()> {
        todo!()
    }

    pub fn get_permanent_notes(&self) -> Result<Vec<PermanentNote>> {
        todo!()
    }
}
