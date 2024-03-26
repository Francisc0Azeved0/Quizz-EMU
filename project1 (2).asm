include emu8086.inc

ORG    100h
                          
jmp start   ;saltar para a funcao inicial do jogo

; declaracao de variaveis e mensagens                        

M1 DB '                     BEM VINDO AO QUIZ MANIA$'
M2 DB 'Regras : $'
M3 DB 'Vai responder a 5 perguntas. Por cada resposta correta ira receber um ponto.$'
M4 DB 'Precione qualquer tecla para iniciar $'
M5 DB 'Resposta certa!$'
M6 DB 'Resposta errada... :($'
M7 DB 'Acabou o quiz!.$'
M8 DB 'O seu total de pontos final foi: $'
M9 DB 'Pressione "a" para tentar novamente ou qualquer outra tecla para sair.$' 
M10 DB '                    Obrigado!$'
P1 DB 'De quem e a famosa frase Penso, logo existo?$'
R1 DB '   a) Platao   b) Galileu Galilei   c) Descartes d) Socrates$'
P2 DB 'Qual o livro mais vendido no mundo a seguir a Biblia?$'
R2 DB '   a) O Senhor dos Aneis    b) Dom Quixote    c) O Pequeno Principe d) Ela, a Feiticeira$'
P3 DB 'Quantas casas decimais tem o numero pi??$'
R3 DB '   a) Duas    b) Centenas    c) Infinitas d) Vinte$'
P4 DB 'Atualmente, quantos elementos quimicos a tabela periodica possui?$'
R4 DB '   a) 113    b) 109    c) 108 d) 118$'
P5 DB 'Quanto tempo a luz do Sol demora para chegar a Terra?$'
R5 DB '   a) 12 minutos    b) 1 dia    c) 12 horas d) 8 minutos$'
P6 DB 'Qual a nacionalidade de Che Guevara?$'
R6 DB '   a) Cubana    b) Peruana    c) Panamenha d) e) Argentina$'
P7 DB 'Qual a velocidade da luz?$'
R7 DB '   a) 300 000 000(m/s)    b) 150 000 000(m/s)    c) 199 792 458(m/s) d) 299 792 458(m/s)$'
P8 DB 'Em qual local da asia o portugues e lingua oficial?$'
R8 DB '   a) india    b) Filipinas    c) Mocambique d) Macau$'
P9 DB 'Qual foi o recurso utilizado inicialmente pelo homem para explicar a origem das coisas?$'
R9 DB '   a) Filosofia   b) Biologia   c) Matematica   d) Mitologia$'
P10 DB 'Qual o maior animal terrestre?$'
R10 DB '   a) Baleia Azul    b) Dinossauro    c) Elefante africano$ d) Tubarao Branco$'
P11 DB 'Qual o tema do famoso discurso Eu Tenho um Sonho, de Martin Luther King?$'
R11 DB '   a) Igualdade das racas    b) Justica para os menos favorecidos    c) Intolerancia religiosa d) Premio Nobel da Paz$'
P12 DB 'Quais os nomes dos tres Reis Magos?$'
R12 DB '   a) Gaspar, Nicolau e Natanael    b) Belchior, Gaspar e Baltazar    c) Belchior, Gaspar e Nataniel d) Gabriel, Benjamim e Melchior$'    

ii db 0

pontos db 0
 
ERR:            ;registar resposta errada
    LEA DX,M6
	MOV AH,9
	INT 21H  
	jmp PerLoop
	
CERT:            ;registar resposta certa
    LEA DX,M5
	MOV AH,9
	INT 21H   
	inc pontos[0]
	jmp PerLoop    
	
PrintPontos:    ; imprimir numero de pontos
    cmp pontos, 0  
    je Print0  
    
    cmp pontos, 1  
    je Print1 
    
    cmp pontos, 2  
    je Print2
    
    cmp pontos, 3  
    je Print3 
    
    cmp pontos, 4  
    je Print4 
    
    cmp pontos, 5  
    je Print5 
    
    ret

; funcao de imprimir para cada possivel pontuacao 0-5
Print0: 
    mov ah, 2
    mov dl, '0'
	INT 21H
	ret
	
Print1: 
    mov ah, 2
    mov dl, '1'
	INT 21H  
	ret
	
Print2: 
    mov ah, 2
    mov dl, '2'
	INT 21H 
	ret
	
Print3: 
    mov ah, 2
    mov dl, '3'
	INT 21H 
	ret
	
Print4: 
    mov ah, 2
    mov dl, '4'
	INT 21H 
	ret

Print5: 
    mov ah, 2
    mov dl, '5'
	INT 21H
	ret  
	
;funcao para fazer nova linha
NL: 
	MOV AH,2
	MOV DL, 0AH
	INT 21H   
    MOV DL, 0DH
    INT 21H
    RET 

;loop principal que imprime as perguntas    
PerLoop: 
           
    cmp ii[0], 5   ;verifica se ja fez 5 perguntas
    je end  
    inc ii[0]    
    
    ;gerar numero aleatoreo entre 0 e 11
    mov ah, 2ch
    int 21h
    
    mov ah, 0
    mov al, dl
    mov bl, 12
    div bl 
    
    ;ir para a pergunta correspondente
    cmp ah, 0
    je PER1 
    
    cmp ah, 1
    je PER2
    
    cmp ah, 2
    je PER3
    
    cmp ah, 3
    je PER4
    
    cmp ah, 4
    je PER5
    
    cmp ah, 5
    je PER6
    
    cmp ah, 6
    je PER7
    
    cmp ah, 7
    je PER8
    
    cmp ah, 8
    je PER9
    
    cmp ah, 9
    je PER10
    
    cmp ah, 10
    je PER11
    
    cmp ah, 11
    je PER12


;funcao de inicializacao que mostra as instrucoes
start:    
    
    LEA DX,M1
	MOV AH,9
	INT 21H 
	
	CALL NL
	
	LEA DX,M2
	MOV AH,9
	INT 21H
	
	CALL NL
	
	LEA DX,M3
	MOV AH,9
	INT 21H   
	
	CALL NL
	
	LEA DX,M4
	MOV AH,9
	INT 21H 
	
	MOV AH, 1
	INT 21H  
	          
    CMP AL, 0DH  
    MOV CX, 10 
	JE PerLoop   
	JNE PerLoop    
	

;funcao quando acaba as 5 perguntas	
end:     
    CALL NL 
    
    LEA DX,M7
	MOV AH,9
	INT 21H
	
    CALL NL
       
    LEA DX,M8
	MOV AH,9
	INT 21H  
	
    call PrintPontos
	
	CALL NL  
	
	LEA DX,M9
	MOV AH,9
	INT 21H 
	
	CALL NL 
	
	mov pontos[0], 0
	mov ii[0], 0
	
	MOV AH, 1
	INT 21H  
	
	CMP AL, 'a'  
	MOV CX, 10 
	JE PerLoop   
	
    RET
    
;funcoes das perguntas	
PER1:
	CALL NL
    
	LEA DX,P1
	MOV AH,9
	INT 21H
	
	CALL NL
    
	LEA DX,R1
	MOV AH,9
	INT 21H
	
	CALL NL
    
	MOV AH, 1
	INT 21H
	CMP AL, 'c'
	JE CERT
    JNE ERR
	        
PER2:
	CALL NL
    
	LEA DX,P2
	MOV AH,9
	INT 21H
	
	CALL NL
    
	LEA DX,R2
	MOV AH,9
	INT 21H
	
	CALL NL
    
	MOV AH, 1
	INT 21H
	CMP AL, 'b'
	JE CERT
    JNE ERR 
    
PER3:
	CALL NL
    
	LEA DX,P3
	MOV AH,9
	INT 21H
	
	CALL NL
    
	LEA DX,R3
	MOV AH,9
	INT 21H
	
	CALL NL
    
	MOV AH, 1
	INT 21H
	CMP AL, 'c'
	JE CERT
    JNE ERR	
    RET
    
PER4:
	CALL NL
    
	LEA DX,P4
	MOV AH,9
	INT 21H
	
	CALL NL
    
	LEA DX,R4
	MOV AH,9
	INT 21H
	
	CALL NL
    
	MOV AH, 1
	INT 21H
	CMP AL, 'd'
	JE CERT
    JNE ERR
    
PER5:
	CALL NL
    
	LEA DX,P5
	MOV AH,9
	INT 21H
	
	CALL NL
    
	LEA DX,R5
	MOV AH,9
	INT 21H
	
	CALL NL
    
	MOV AH, 1
	INT 21H
	CMP AL, 'a'
	JE CERT
    JNE ERR 
    
PER6:
	CALL NL
    
	LEA DX,P6
	MOV AH,9
	INT 21H
	
	CALL NL
    
	LEA DX,R6
	MOV AH,9
	INT 21H
	
	CALL NL
    
	MOV AH, 1
	INT 21H
	CMP AL, 'd'
	JE CERT
    JNE ERR 
    
PER7:
	CALL NL
    
	LEA DX,P7
	MOV AH,9
	INT 21H
	
	CALL NL
    
	LEA DX,R7
	MOV AH,9
	INT 21H
	
	CALL NL
    
	MOV AH, 1
	INT 21H
	CMP AL, 'd'
	JE CERT
    JNE ERR 
    
PER8:
	CALL NL
    
	LEA DX,P8
	MOV AH,9
	INT 21H
	
	CALL NL
    
	LEA DX,R8
	MOV AH,9
	INT 21H
	
	CALL NL
    
	MOV AH, 1
	INT 21H
	CMP AL, 'd'
	JE CERT
    JNE ERR 
    
PER9:
	CALL NL
    
	LEA DX,P9
	MOV AH,9
	INT 21H
	
	CALL NL
    
	LEA DX,R9
	MOV AH,9
	INT 21H
	
	CALL NL
    
	MOV AH, 1
	INT 21H
	CMP AL, 'd'
	JE CERT
    JNE ERR 
    
PER10:
	CALL NL
    
	LEA DX,P10
	MOV AH,9
	INT 21H
	
	CALL NL
    
	LEA DX,R10
	MOV AH,9
	INT 21H
	
	CALL NL
    
	MOV AH, 1
	INT 21H
	CMP AL, 'c'
	JE CERT
    JNE ERR  
    
PER11:
	CALL NL
    
	LEA DX,P11
	MOV AH,9
	INT 21H
	
	CALL NL
    
	LEA DX,R11
	MOV AH,9
	INT 21H
	
	CALL NL
    
	MOV AH, 1
	INT 21H
	CMP AL, 'a'
	JE CERT
    JNE ERR
    
PER12:
	CALL NL
    
	LEA DX,P12
	MOV AH,9
	INT 21H
	
	CALL NL
    
	LEA DX,R12
	MOV AH,9
	INT 21H
	
	CALL NL
    
	MOV AH, 1
	INT 21H
	CMP AL, 'b'
	JE CERT
    JNE ERR     


RET               ; return to operating system.
END               ; directive to stop the compiler.
      
      
    