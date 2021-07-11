extends Control

onready var coins_txt = $Panel/Coins
onready var claim_btn = $Panel/Claim
onready var instance_pos = $Panel/Claim/Start_pos
onready var tween = $Panel/Tween

var coin_scene = preload("res://Coin.tscn")

func _on_Claim_pressed():
	animation_tween(5,Vector2(claim_btn.rect_global_position.x+75,claim_btn.rect_global_position.y),coins_txt.rect_global_position)
	claim_btn.disabled = true

func instance_coin(i):
	var coin = coin_scene.instance()
	coin.rect_global_position = Vector2(claim_btn.rect_global_position.x+75,claim_btn.rect_global_position.y)
	coin.name += str(i)
	get_tree().get_root().get_node("Home/Panel/Claim/Start_pos").add_child(coin)

func animation_tween(coins,init_pos,final_pos):
	for i in range(coins):
		instance_coin(i)
		var coin = get_tree().get_root().get_node("Home/Panel/Claim/Start_pos/Coin"+str(i))
		tween.interpolate_property(coin,"rect_position",
		init_pos,final_pos,0.8,Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
		tween.start()
		yield(get_tree().create_timer(0.1), "timeout")

	if yield(tween,"tween_completed"):
		yield(get_tree().create_timer(0.6), "timeout")
		claim_btn.disabled = false
		var Coins = get_tree().get_root().get_node("Home/Panel/Claim/Start_pos").get_children()
		for i in Coins:
			i.queue_free()
	
