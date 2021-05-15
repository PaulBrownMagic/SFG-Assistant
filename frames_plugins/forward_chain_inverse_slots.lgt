:- object(forward_chain_inverse_slots,
	implements([frames_on_add, frames_on_update, frames_on_delete])).

	:- info([
		version is 1:0:0,
		author is 'Paul Brown',
		date is 2021-05-14,
		comment is 'To speed up certain lookups we assert some inverse slots in the frames'
	]).

	% add
	after_add(Frames, Subject, ako, Value, UpdatedFrames) :-
		frames::add_frame(Frames, Value, ['ako-'-Subject], UpdatedFrames).

	after_add(Frames, Subject, isa, Value, UpdatedFrames) :-
		frames::add_frame(Frames, Value, ['isa-'-Subject], UpdatedFrames).

	% update
	after_update(Frames, Subject, ako, OldValue, NewValue, Updated) :-
		frames::delete_frame(Frames, OldValue, ['ako-'-Subject], AccFrames),
		frames::add_frame(AccFrames, NewValue, ['ako-'-Subject], Updated).

	after_update(Frames, Subject, isa, OldValue, NewValue, Updated) :-
		frames::delete_frame(Frames, OldValue, ['isa-'-Subject], AccFrames),
		frames::add_frame(AccFrames, NewValue, ['isa-'-Subject], Updated).

	% delete
	after_delete_slot(Frames, Subject, ako, Value, Updated) :-
		frames::delete_frame(Frames, Value, ['ako-'-Subject], Updated).

	after_delete_slot(Frames, Subject, isa, Value, Updated) :-
		frames::delete_frame(Frames, Value, ['isa-'-Subject], Updated).

:- end_object.
