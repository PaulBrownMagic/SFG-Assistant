:- object(tests,
	extends(lgtunit)).

	:- info([
		version is 1:0:0,
		author is 'Paul Brown',
		date is 2021-05-14,
		comment is 'Unit tests for Frames Plugins'
	]).

	cover(forward_chain_inverse_slots).

	frames(Frames) :-
		frames::new(F0),
		frames::add_frame(F0, 'Plant', [], F1),
		frames::add_frame(F1, 'Vegetable', [ako-'Plant'], F2),
		frames::add_frame(F2, 'Onion', [isa-'Vegetable', spacing-16, height-12], F3),
		Frames = F3.

	test(on_add_ako_inversed, true) :-
		frames(Frames),
		frames::add_frame(Frames, 'Herb', [ako-'Plant'], Updated),
		^^assertion(frames::get_frame(Updated, 'Plant', ['ako-'-'Herb'])).
	test(on_add_isa_inversed, true) :-
		frames(Frames),
		frames::add_frame(Frames, 'Potato', [isa-'Vegetable'], Updated),
		^^assertion(frames::get_frame(Updated, 'Vegetable', ['isa-'-'Potato'])).

	test(on_update_ako_inversed, true) :-
		frames(Frames),
		frames::add_frame(Frames, 'Herb', [ako-'Vegetable'], Frames0),
		frames::update_frame(Frames0, 'Herb', [ako-'Plant'], Updated),
		^^assertion(frames::get_frame(Updated, 'Plant', ['ako-'-'Herb'])),
		^^assertion(\+ frames::get_frame(Updated, 'Vegetable', ['ako-'-'Herb'])).

	test(on_update_isa_inversed, true) :-
		frames(Frames),
		frames::add_frame(Frames, 'Herb', [ako-'Plant'], Frames0),
		frames::update_frame(Frames0, 'Onion', [isa-'Herb'], Updated),
		^^assertion(frames::get_frame(Updated, 'Herb', ['isa-'-'Onion'])),
		^^assertion(\+ frames::get_frame(Updated, 'Vegetable', ['isa-'-'Onion'])).

	test(on_update_ako_inversed_to, true) :-
		frames(Frames),
		frames::add_frame(Frames, 'Herb', [ako-'Vegetable'], Frames0),
		frames::update_frame(Frames0, 'Herb', [ako-'Vegetable' to 'Plant'], Updated),
		^^assertion(frames::get_frame(Updated, 'Plant', ['ako-'-'Herb'])),
		^^assertion(\+ frames::get_frame(Updated, 'Vegetable', ['ako-'-'Herb'])).

	test(on_update_isa_inversed_to, true) :-
		frames(Frames),
		frames::add_frame(Frames, 'Herb', [ako-'Plant'], Frames0),
		frames::update_frame(Frames0, 'Onion', [isa-'Vegetable' to 'Herb'], Updated),
		^^assertion(frames::get_frame(Updated, 'Herb', ['isa-'-'Onion'])),
		^^assertion(\+ frames::get_frame(Updated, 'Vegetable', ['isa-'-'Onion'])).

	test(on_delete_ako, true) :-
		frames(Frames),
		frames::delete_frame(Frames, 'Vegetable', [ako-'Plant'], Updated),
		^^assertion(\+ frames::get_frame(Updated, 'Plant', ['ako-'-'Vegetable'])).

	test(on_delete_isa, true) :-
		frames(Frames),
		frames::delete_frame(Frames, 'Onion', [isa-'Vegetable'], Updated),
		^^assertion(\+ frames::get_frame(Updated, 'Vegetable', ['isa-'-'Onion'])).

:- end_object.
