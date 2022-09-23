use anyhow::Result;
use chrono::{DateTime, Utc};
use uuid::Uuid;

mod ztln_session;

pub use ztln_session::ZtlNoteSession;

#[derive(Debug, Clone, elephantry::Entity)]
#[elephantry(model = "Model", structure = "Structure")]
pub struct Thinker {
    thinker_id: Uuid,
    name: String,
    personal_organization_id: Uuid,
}

impl Thinker {
    pub fn new(thinker_id: &Uuid, name: &str, personal_organization_id: &Uuid) -> Self {
        Self {
            thinker_id: thinker_id.to_owned(),
            name: name.to_string(),
            personal_organization_id: personal_organization_id.to_owned(),
        }
    }
}

#[derive(Debug, Clone)]
pub struct Thought {
    thought_id: Uuid,
    thinker_id: Uuid,
    organization_id: Uuid,
    parent_thought_id: Option<Uuid>,
    created_at: DateTime<Utc>,
    content: String,
    medias: String,
    tags: String,
}

impl Thought {
    pub fn Thought(
        thought_id: &Uuid,
        thinker_id: &Uuid,
        organization_id: &Uuid,
        parent_thought_id: Option<&Uuid>,
        created_at: &DateTime<Utc>,
        content: &str,
        medias: &str,
        tags: &str,
    ) -> Self {
        Self {
            thought_id: thought_id.to_owned(),
            thinker_id: thinker_id.to_owned(),
            organization_id: organization_id.to_owned(),
            parent_thought_id: parent_thought_id.cloned(),
            created_at: created_at.to_owned(),
            content: content.to_string(),
            medias: medias.to_string(),
            tags: tags.to_string(),
        }
    }
}

#[derive(Debug, Clone)]
pub struct Organization {
    organization_id: Uuid,
    owner_id: Uuid,
    name: String,
    description: String,
    is_personal: bool,
    is_private: bool,
}

impl Organization {
    pub fn new(
        organization_id: &Uuid,
        owner_id: &Uuid,
        name: &str,
        description: &str,
        is_personal: bool,
        is_private: bool,
    ) -> Self {
        Self {
            organization_id: organization_id.to_owned(),
            owner_id: owner_id.to_owned(),
            name: name.to_string(),
            description: description.to_string(),
            is_personal,
            is_private,
        }
    }
}
