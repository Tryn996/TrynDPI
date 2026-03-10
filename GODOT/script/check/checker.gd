extends Control

var statuses = {
	"Discord": "Обновление...",
	"Telegram": "Обновление...",
	"YouTube": "Обновление..."
}

func _ready():
	check_website_status("https://discord.com", "Discord")
	check_website_status("https://telegram.org", "Telegram")
	check_website_status("https://youtube.com", "YouTube")
func check_website_status(url: String, service_name: String):
	var http_request = HTTPRequest.new()
	add_child(http_request)
	
	http_request.request_completed.connect(
		func(result, response_code, headers, body): 
			_on_request_completed(result, response_code, service_name, http_request)
	)
	
	var error = http_request.request(url, [], HTTPClient.METHOD_HEAD)
	if error != OK:
		update_ui(service_name, "Ошибка сети")

func _on_request_completed(result, response_code, service_name, request_node):
	if result == HTTPRequest.RESULT_SUCCESS and response_code == 200:
		update_ui(service_name, "Доступен")
	else:
		update_ui(service_name, "Недоступен")
	request_node.queue_free()
	
func update_ui(service_name: String, status_text: String):
	statuses[service_name] = status_text
	match service_name:
		"Discord":
			$Check/Discord.text = "Discord: " + status_text
		"Telegram":
			$Check/Telegram.text = "Telegram: " + status_text
		"YouTube":
			$Check/YouTube.text = "YouTube: " + status_text
	

func _on_updeate_pressed():
	$Check/Discord.text = "Discord: Обновление..."
	$Check/Telegram.text = "Telegram: Обновление..."
	$Check/YouTube.text = "YouTube: Обновление..."
	
	check_website_status("https://discord.com", "Discord")
	check_website_status("https://telegram.org", "Telegram")
	check_website_status("https://youtube.com", "YouTube") 
