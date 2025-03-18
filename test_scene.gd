# DeckTest.gd
extends Node

func _ready():
	var deck = Deck.new()
	print("Deck initialized with %d cards" % deck.size())  # Should print 52
	
	# Deal and print 5 cards
	for i in 5:
		var card = deck.deal()
		print("Dealt: ", card.to_string())
	
	print("Remaining cards: ", deck.size())  # Should print 47
