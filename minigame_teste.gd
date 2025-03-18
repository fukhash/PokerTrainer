extends Control

# Variáveis de estado
var score = 0
var time_left = 10
var current_answer = 0

# Referência aos nós da interface
@onready var question_label = $QuestionLabel
@onready var answer_line_edit = $AnswerLineEdit
@onready var feedback_label = $FeedbackLabel
@onready var timer_label = $TimerLabel
@onready var score_label = $ScoreLabel
@onready var countdown_timer = $CountdownTimer

func _ready():
	randomize()  # Inicializa o gerador de números aleatórios
	generate_problem()

# Função para gerar um novo problema aritmético
func generate_problem():
	# Gere dois números aleatórios entre 1 e 20
	var num1 = randi() % 20 + 1
	var num2 = randi() % 20 + 1
	
	# Escolhe aleatoriamente um operador
	var operators = ["+", "-", "*"]
	var op = operators[randi() % operators.size()]
	
	# Calcula a resposta correta
	match op:
		"+":
			current_answer = num1 + num2
		"-":
			current_answer = num1 - num2
		"*":
			current_answer = num1 * num2
	
	# Atualiza a exibição da pergunta
	question_label.text = str(num1) + " " + op + " " + str(num2) + " = ?"
	
	# Reseta o campo de resposta e o feedback
	answer_line_edit.text = ""
	feedback_label.text = ""
	
	# Reinicia o timer para o novo problema
	time_left = 10
	update_timer_label()
	countdown_timer.start()

# Atualiza a label do timer
func update_timer_label():
	timer_label.text = "Tempo: " + str(time_left) + "s"

# Callback chamado a cada segundo pelo CountdownTimer
func _on_CountdownTimer_timeout():
	time_left -= 1
	update_timer_label()
	
	if time_left <= 0:
		countdown_timer.stop()
		feedback_label.text = "Tempo esgotado! Resposta correta: " + str(current_answer)
		# Aguarda 2 segundos e gera um novo problema
		await(get_tree().create_timer(2).timeout)
		generate_problem()

# Callback executado quando o botão de enviar é pressionado
func _on_SendButton_pressed():
	# Interrompe a contagem
	countdown_timer.stop()
	
	# Converte a resposta do usuário para inteiro
	var user_input = int(answer_line_edit.text)
	
	if user_input == current_answer:
		feedback_label.text = "Correto!"
		score += 1
		score_label.text = "Pontuação: " + str(score)
	else:
		feedback_label.text = "Incorreto! Resposta correta: " + str(current_answer)
	
	# Aguarda 2 segundos antes de gerar o próximo problema
	await(get_tree().create_timer(2.0).timeout)
	generate_problem()
