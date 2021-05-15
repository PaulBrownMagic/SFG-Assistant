:- initialization((
	set_logtalk_flag(report, warnings),
	logtalk_load([
		frames(loader)
	]),
	logtalk_load(lgtunit(loader)),
	logtalk_load([
		forward_chain_inverse_slots
	], [
		source_data(on),
		debug(on)
	]),
	logtalk_load(tests, [hook(lgtunit)]),
	tests::run
)).
