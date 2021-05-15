:- initialization((
	logtalk_load([
	% Logtalk stdlib
	]),
	logtalk_load([
	% Third-Party libs
		frames(loader)
	]),
	logtalk_load([
	% Local
		frames_plugins(loader)
	],
	[
		optimize(on)
	])
)).
