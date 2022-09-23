use elephantry::Connection;

use ztl_note::ZtlNoteSession;

mod test_init;
use test_init::get_thinkers;

#[test]
fn list_notes() {
    let connection = Connection::new("postgres://greg@postgresql/greg").unwrap();
    let open_mind_session = ZtlNoteSession::new(connection);
    let thinker = get_thinkers(1).pop().unwrap();
    let thinker = open_mind_session.create_thinker("myself").unwrap();

    for note in get_permanent_notes(5, &thinker) {
        open_mind_session
            .save_permanent_note(&note)
            .expect("I should be able to save a note");
    }
    let notes = open_mind_session
        .get_permanent_notes()
        .expect("I should be able to get saved notes");
    assert_eq!(5, notes.len());
}
