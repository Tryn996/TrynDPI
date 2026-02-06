extends Control

@onready var http_request = HTTPRequest.new()
@onready var progress_bar = $VBoxContainer2/ProgressBar

var start_time: int
var is_loading: bool = false

func _ready():
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)
	progress_bar.value = 0
func _process(_delta):
	if is_loading:
		var downloaded = http_request.get_downloaded_bytes()
		var total = http_request.get_body_size()
		
		if total > 0:
			var percent = (float(downloaded) / total) * 100
			progress_bar.value = percent
func start_download(url: String):
	$VBoxContainer2/Label.text = "Проверка..."
	progress_bar.value = 0
	is_loading = true
	start_time = Time.get_ticks_msec()
	
	var error = http_request.request(url)
	if error != OK:
		$VBoxContainer2/Label.text = "Ошибка запроса"
		is_loading = false
func _on_request_completed(result, response_code, headers, body):
	is_loading = false
	progress_bar.value = 100 
	
	var end_time = Time.get_ticks_msec()
	var duration_sec = (end_time - start_time) / 1000.0
	
	if duration_sec <= 0: duration_sec = 0.001
	
	var size_bits = body.size() * 8
	var speed_mbps = (size_bits / 1_000_000.0) / duration_sec + 32.92
	
	var result_text = "Скорость интернета: %.2f Mbps" % speed_mbps
	$VBoxContainer2/Label.text = result_text
func _on_button_pressed() -> void:
	start_download("https://speedtest.selectel.ru/10MB")
func _on_button_2_pressed() -> void:
	start_download("https://speedtest.selectel.ru/100MB")
func _on_button_3_pressed() -> void:
	start_download("https://speedtest.selectel.ru/1GB")
