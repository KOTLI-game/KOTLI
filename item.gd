extends Control

var currentItem = Item.placeholder1

enum Item {
	placeholder1,
	placeholder2
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setItem(Item.placeholder1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func setItem(item: Item) -> void:
	currentItem = item
	match item:
		Item.placeholder1:
			(get_child(0).get_child(0) as TextureRect).texture = get_meta("placeholderTexture1")
		
