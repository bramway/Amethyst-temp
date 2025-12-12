extends Node

var sample_score = {
  "top": [
	{
	  "username": "Dennis",
	  "country": "NL",
	  "score": 9001
	},
	{
	  "username": "Bram",
	  "country": "NL",
	  "score": 666
	},
	{
	  "username": "Joris",
	  "country": "NL",
	  "score": 420
	},
	{
	  "username": "Nikita",
	  "country": "RU",
	  "score": 69
	},
  ]
}

func _ready():
	self._load_scoreboard()


func _load_scoreboard():

	%Label.text = "Loading scoreboard..."

	#self._populate_tree(
	#	%Tree,
	#	sample_score
	#	)

	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)

	var error = http_request.request(
		"%s/score/top?num=100" % Scoreboard.SCOREBOARD_ENDPOINT,
		[
			"x-api-key: %s" % Scoreboard.SCOREBOARD_API_KEY,
			],
		)
	if error != OK:
		%Label.text = "Scoreboard error."
		#push_error("An error occurred in the HTTP request.")

	# Perform a POST request. The URL below returns JSON as of writing.
	# Note: Don't make simultaneous requests using a single HTTPRequest node.
	# The snippet below is provided for reference only.
	#var body = JSON.new().stringify({"name": "Godette"})
	#error = http_request.request("https://httpbin.org/post", [], HTTPClient.METHOD_POST, body)
	#if error != OK:
	#	push_error("An error occurred in the HTTP request.")

	#$Label.text = "Scoreboard Loaded!"

func _http_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()

	self._populate_tree(
		%Tree,
		response
		)

	%Label.text = "Loaded scoreboard."


	# Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	#print(response.headers["User-Agent"])

func _populate_tree(tree: Tree, scores: Dictionary):
	tree.clear()
	var root_item = tree.create_item()

	#tree.set_columns(3)
	#tree.set_column_title(0, "Username")
	#tree.set_column_title(1, "Country")
	#tree.set_column_title(2, "Score")

	root_item.set_text(0, "Username")
	root_item.set_text(1, "Country")
	root_item.set_text(2, "Kills")
	root_item.set_text(3, "Deaths")
	root_item.set_text(4, "Game Time")
	
	for row in scores["top"]:
		var item = tree.create_item(root_item)
		item.set_text(0, row.get("username"))
		item.set_text(1, row.get("country"))
		item.set_text(2, str(int(row.get("kills"))))
		item.set_text(3, str(int(row.get("deaths"))))
		item.set_text(4, str(int(row.get("game_time"))))

@onready var root = get_tree().get_root()
@onready var main_menu_resource = load("res://scenes/Menus/main_menu.tscn")

func _on_back_button_pressed() -> void:
	var curr_scene = root.get_child(root.get_child_count() - 1)
	curr_scene.queue_free()
	var main_menu = main_menu_resource.instantiate()
	root.add_child(main_menu)


func _on_refresh_button_pressed() -> void:
	%Tree.clear()
	self._load_scoreboard()


func _on_post_sample_button_pressed() -> void:
	Scoreboard._post_score(
		"username here",
		420,
		69,
		666,
		)
	self._load_scoreboard()
