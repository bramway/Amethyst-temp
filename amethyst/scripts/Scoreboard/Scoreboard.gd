extends Node;

const SCOREBOARD_API_KEY = "EJ$JBaIUFdE4h3eE7$r*i(eG4L^aw%Zy"
const SCOREBOARD_ENDPOINT = "https://amethyst.hyperspace.zip"

func _post_score(username: String, kills: int, deaths: int, game_time: int):
	var http_request = HTTPRequest.new()
	add_child(http_request)
	#http_request.request_completed.connect(self._http_request_completed)

	var error = http_request.request(
		"%s/score" % SCOREBOARD_ENDPOINT,
		[
			"x-api-key: %s" % SCOREBOARD_API_KEY,
			],
		HTTPClient.METHOD_POST,
		JSON.new().stringify({
			"username": username,
			"kills": kills,
			"deaths": deaths,
			"game_time": game_time,
			})
		)
	if error != OK:
		#%Label.text = "Scoreboard error."
		push_error("An error occurred in the HTTP request.")
