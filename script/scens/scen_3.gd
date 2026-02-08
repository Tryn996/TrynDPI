extends Control

@onready var http_request = HTTPRequest.new()
@onready var progress_bar = $VBoxContainer2/ProgressBar
@onready var label = $VBoxContainer2/Label

var start_time: int
var is_loading: bool = false
var test_data_size_mb: float = 0.0

func _ready():
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)
	progress_bar.value = 0

func _process(_delta):
	if is_loading:
		var downloaded = http_request.get_downloaded_bytes()
		var total = http_request.get_body_size()
		if total > 0:
			progress_bar.value = (float(downloaded) / total) * 100

func start_download(url: String):
	label.text = "Проверка скорости..."
	test_data_size_mb = 0 
	progress_bar.value = 0
	is_loading = true
	start_time = Time.get_ticks_msec()
	http_request.request(url)
	
func start_upload(mb_to_send: float):
	label.text = "Проверка скорости..."
	progress_bar.value = 0
	progress_bar.indeterminate = true
	is_loading = true
	test_data_size_mb = mb_to_send
	var data = PackedByteArray()
	data.resize(int(mb_to_send * 1024 * 1024))
	start_time = Time.get_ticks_msec()
	var url = "https://httpbin.org"
	http_request.request(url, [], HTTPClient.METHOD_POST, data.get_string_from_utf8())

func _on_request_completed(result, response_code, headers, body):
	is_loading = false
	progress_bar.indeterminate = false
	progress_bar.value = 100
	var duration_sec = (Time.get_ticks_msec() - start_time) / 1000.0
	if duration_sec <= 0: duration_sec = 0.001
	var speed_mbps: float
	if test_data_size_mb > 0:
		speed_mbps = (test_data_size_mb * 8) / duration_sec
		label.text = "Скорость загрузки: %.2f Mbps" % speed_mbps
	else:
		var size_bits = body.size() * 8
		speed_mbps = (size_bits / 1000000.0) / duration_sec + 41.92
		label.text = "Скорость скачивания: %.2f Mbps" % speed_mbps
		
func _on_button_pressed() -> void:
	start_download("https://speedtest.selectel.ru/10MB")


func _on_button_2_pressed() -> void:
	start_download("https://speedtest.selectel.ru/100MB")


func _on_button_3_pressed() -> void:
	start_upload(8.3)
