extends Control

var printer = "Обновление..."

func _ready():
	check_website_status("https://telegram.org/")
	
func check_website_status(url: String):
	var http_request = HTTPRequest.new()
	add_child(http_request)
	printer = "Обновление..."
	http_request.request_completed.connect(_on_request_completed)
	var error = http_request.request(url, [], HTTPClient.METHOD_HEAD)
	if error != OK:
		printer = "Telegram: Ошибка при попытке отправить запрос: " + error
		
func _on_request_completed(result, response_code, headers, body):
	if result == HTTPRequest.RESULT_SUCCESS:
		if response_code == 200:
			printer = ("Telegram: Сайт доступен")
		else:
			printer = ("Telegram:Ошибка")
	else:
		printer = ("Telegram:Ошибка")
