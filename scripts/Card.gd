# scripts/Card.gd
extends RefCounted  # Lightweight memory management
class_name Card


enum Suit { HEARTS, DIAMONDS, CLUBS, SPADES }

var suit: Suit
var rank: int  # 2-14

func _init(suit_id: Suit, rank_value: int):
	suit = suit_id
	rank = clamp(rank_value, 2, 14)  # Ensure valid rank

# Convert to a readable string (e.g., "A♠")
func card_to_string() -> String:
	var rank_str: String = str(rank)
	match rank:
		11: rank_str = "J"
		12: rank_str = "Q"
		13: rank_str = "R"
		14: rank_str = "A"
	return rank_str + ["♥", "♦", "♣", "♠"][suit]
