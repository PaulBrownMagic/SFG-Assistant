:- initialization((
	logtalk_load([
	% Logtalk stdlib
	]),
	logtalk_load([
	% Third-Party libs
		frames(loader),
		frames_persistency(loader)
	]),
	logtalk_load([
	% Local
		classic_inheritance,
		forward_chain_inverse_slots
	],
	[
		optimize(on)
	])
)).
