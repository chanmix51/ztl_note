use uuid::Uuid;
use ztl_note::Thinker;

/*
pub fn get_permanent_notes<'a>(nb_notes: usize, thinker: &'a Thinker) -> Vec<PermanentNote<'a>> {
    let mut notes: Vec<PermanentNote> = Vec::new();

    for i in 0..=nb_notes {
        let note = PermanentNote::new(
            Uuid::new_v4(),
            thinker,
            &format!("headline {:04}", i),
            &format!("Content of the permanent note n°{:04}.", i),
        );
        notes.push(note);
    }

    notes
}
 */

pub fn get_thinkers(nb_thinkers: usize) -> Vec<Thinker> {
    (0..=nb_thinkers)
        .map(|idx| {
            Thinker::new(
                &Uuid::new_v4(),
                &format!("thinker {}", idx),
                &Uuid::new_v4(),
            )
        })
        .collect()
}
