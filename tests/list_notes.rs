mod test_init;
use test_init::{get_permanent_notes, get_thinkers};
use ztl_note::ZtlNoteSession;

#[test]
fn list_notes() {
    let thinker = get_thinkers(1).pop().unwrap();
    let open_mind_session = ZtlNoteSession::new(thinker.clone())
        .expect("I should be able to log in with the test user");

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
