extends Control

var progress : Vector2 = Vector2(10,20)
const link: Array = [
	["https//rifqideveloper.github.io/code-art-Launcher/Launcher/window/codeartLauncher.exe","https//rifqideveloper.github.io/code-art-Launcher/Launcher/exe.sha"],
	["https//rifqideveloper.github.io/code-art-Launcher/Launcher/linux/codeartLauncher.x86_64","https//rifqideveloper.github.io/code-art-Launcher/Launcher/x86_64.sha"],
	["https//rifqideveloper.github.io/code-art-Launcher/Launcher/mac/codeartLauncher.zip","https//rifqideveloper.github.io/code-art-Launcher/Launcher/zip.sha"]
]
const alamat : String = "codeartLouncher.bin"
var index : int = 0
func _ready() -> void:
	if OS.has_feature("Windows") :
		print("berjalan di window")
		index = 0
	elif OS.has_feature("X11") :
		print("berjalan di linux/bsd")		
		index = 1
	elif OS.has_feature("OSX") :
		print("berjalan di mac os")				
		index = 2
	
	_download(alamat)

func _process(delta) -> void:
	$ProgressBar.value = $HTTPRequest.get_downloaded_bytes()
	$ProgressBar.max_value = $HTTPRequest.get_body_size()
	
func _download(alamat_tujuan:String) -> void :
	if File.new().file_exists(alamat) :
		print("binary sudah ada")
		print("binary cek pembaharuan")
		$sha.set_download_file(alamat_tujuan.replace(".bin",".sha"))
		if OK != $sha.request(link[index][1]) :
			print("error")
			$error.visible = true
	else :
		print("binary tidak ada")
		print("binary download binary")
		$HTTPRequest.set_download_file(alamat_tujuan)
		if OK != $HTTPRequest.request(link[index][0]) :
			print("error")
			$error.visible = true
	
func _download_selesai(result, response_code, headers, body) -> void:
	$sha.set_download_file(alamat.replace(".bin",".sha"))
	$sha.request(link[index][1])

func _selesai() -> void :
	print("memulai applikasi")
	OS.execute(alamat,[])
	get_tree().quit(0)

func _on_sha_request_completed(result, response_code, headers, body):
	var file : File = File.new()
	file.open(alamat.replace(".bin",".sha"),File.READ)
	if file.get_sha256(alamat) == file.get_as_text():
		file.close()
		print("binary pembaharuan selesai")
		_selesai()
	else :
		file.close()
		print("binary butuh pembaharuan ")
		print("binary download binary")		
		$HTTPRequest.set_download_file(alamat)
		$HTTPRequest.request(link[index][0])
	


func _on_error_confirmed():
	get_tree().quit(0)

func _on_error_visibility_changed():
	if !$error.visible:
		get_tree().quit(0)
	pass # Replace with function body.
