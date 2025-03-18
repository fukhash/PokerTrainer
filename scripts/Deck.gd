# cards/Deck.gd
extends RefCounted
class_name Deck


var cards: Array[Card] = []

func _init():
	_build_deck()
	shuffle()

# Initialize a standard 52-card deck
func _build_deck():
	cards.clear()
	for suit in Card.Suit.values():
		for rank in range(2, 15):  # 2-14 (Ace)
			cards.append(Card.new(suit, rank))

# Shuffle the deck
func shuffle():
	cards.shuffle()

# Deal the top card
func deal() -> Card:
	if cards.is_empty():
		push_error("Deck is empty!")
		return null
	return cards.pop_front()  # Remove and return the first card

# Reset the deck (for new hands)
func reset():
	_build_deck()
	shuffle()

# Get remaining card count
func size() -> int:
	return cards.size()
