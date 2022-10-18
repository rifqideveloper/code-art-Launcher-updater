extends Control

var progress : Vector2 = Vector2(10,20)
var link_dan_alamat_file : Array = [
	[]
]

func _ready() -> void:
	pass # Replace with function body.

func _process(delta) -> void:
	$ProgressBar.value = $HTTPRequest.get_downloaded_bytes()
	$ProgressBar.max_value = $HTTPRequest.get_body_size()
	
func _download(link:String,alamat_tujuan:String) -> void :
	pass	

func _download_selesai(result, response_code, headers, body) -> void:
	var download_file_selenjutnya : Array = link_dan_alamat_file.pop_back()
	if download_file_selenjutnya != null :
		pass

func _selesai(mulai:String) -> void :
	if !mulai.empty() :
		pass
	get_tree().quit(0)
