	.text
	.globl	main
solve:
	pushq %rbp
	movq %rsp, %rbp
	subq $88, %rsp
	movq 24(%rbp), %rdi
	pushq %rdi
	movq 8(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	sete %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L27
	pushq $1
	popq %rax
	ret
	jmp .L28
.L27:
.L28:
check:
	pushq %rbp
	movq %rsp, %rbp
	subq $56, %rsp
abs:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq 32(%rbp), %rdi
	pushq %rdi
	pushq $0
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setl %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L25
	movq 32(%rbp), %rdi
	pushq %rdi
	popq %rax
	negq %rax
	pushq %rax
	popq %rax
	ret
	jmp .L26
.L25:
	movq 32(%rbp), %rdi
	pushq %rdi
	popq %rax
	ret
.L26:
	movq %rbp, %rsp
	popq %rbp
	pushq $0
	popq %rsi
	movq %rsi, -32(%rbp)
	jmp .L21
.L19:
	movq -32(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -32(%rbp)
	movq -32(%rbp), %rdi
	pushq %rdi
	movq 16(%rbp), %rdi
	pushq %rdi
	movq -32(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	movq 16(%rbp), %rdi
	pushq %rdi
	movq 24(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	sete %al
	pushq %rax
	movq 16(%rbp), %rdi
	pushq %rdi
	movq -32(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	movq 16(%rbp), %rdi
	pushq %rdi
	movq 24(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	call abs
	addq $8, %rsp
	movq -32(%rbp), %rdi
	pushq %rdi
	movq 24(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	call abs
	addq $8, %rsp
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	sete %al
	pushq %rax
	popq %rbx
	popq %rax
	cmpq $0, %rax
	movq $1, %rax
	jne .L24
	cmpq $0, %rbx
	jne .L24
	movq $0, %rax
.L24:
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L22
	pushq $0
	popq %rax
	ret
	jmp .L23
.L22:
.L23:
.L21:
	movq -32(%rbp), %rdi
	pushq %rdi
	movq 24(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setl %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	jne .L19
.L20:
	pushq $1
	popq %rax
	ret
	movq %rbp, %rsp
	popq %rbp
	pushq $0
	popq %rsi
	movq %rsi, -32(%rbp)
	jmp .L15
.L13:
	movq -32(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -32(%rbp)
	movq -32(%rbp), %rdi
	pushq %rdi
	movq -32(%rbp), %rdi
	pushq %rdi
	movq 16(%rbp), %rdi
	pushq %rdi
	movq 24(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
	call check
	addq $0, %rsp
	movq 24(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	movq 16(%rbp), %rdi
	pushq %rdi
	movq 8(%rbp), %rdi
	pushq %rdi
	call solve
	addq $24, %rsp
	popq %rbx
	popq %rax
	cmpq $0, %rax
	movq $0, %rax
	je .L18
	cmpq $0, %rbx
	je .L18
	movq $1, %rax
.L18:
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L16
	pushq $1
	popq %rax
	ret
	jmp .L17
.L16:
.L17:
.L15:
	movq -32(%rbp), %rdi
	pushq %rdi
	movq 8(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setl %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	jne .L13
.L14:
	pushq $0
	popq %rax
	ret
	movq %rbp, %rsp
	popq %rbp
print:
	pushq %rbp
	movq %rsp, %rbp
	subq $128, %rsp
	pushq $0
	popq %rsi
	movq %rsi, -24(%rbp)
	jmp .L7
.L5:
	movq -24(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -24(%rbp)
	movq -24(%rbp), %rdi
	pushq %rdi
	pushq $124
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	pushq $0
	popq %rsi
	movq %rsi, -32(%rbp)
	jmp .L10
.L8:
	movq -32(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -32(%rbp)
	movq -32(%rbp), %rdi
	pushq %rdi
	movq -32(%rbp), %rdi
	pushq %rdi
	movq 16(%rbp), %rdi
	pushq %rdi
	movq -24(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	sete %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L11
	pushq $81
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	jmp .L12
.L11:
	pushq $46
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
.L12:
	pushq $124
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
.L10:
	movq -32(%rbp), %rdi
	pushq %rdi
	movq 8(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setl %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	jne .L8
.L9:
	pushq $10
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
.L7:
	movq -24(%rbp), %rdi
	pushq %rdi
	movq 8(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setl %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	jne .L5
.L6:
	pushq $10
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	movq %rbp, %rsp
	popq %rbp
queens:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movq 8(%rbp), %rdi
	pushq %rdi
	pushq $8
	popq %rbx
	popq %rax
	imulq %rbx, %rax
	pushq %rax
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call malloc
	movq %rbx, %rsp
	pushq %rax
	popq %rsi
	movq %rsi, -16(%rbp)
	pushq $0
	movq -16(%rbp), %rdi
	pushq %rdi
	movq 8(%rbp), %rdi
	pushq %rdi
	call solve
	addq $24, %rsp
	popq %rdi
	cmpq $0, %rdi
	je .L3
	movq -16(%rbp), %rdi
	pushq %rdi
	movq 8(%rbp), %rdi
	pushq %rdi
	call print
	addq $16, %rsp
	jmp .L4
.L3:
.L4:
	movq %rbp, %rsp
	popq %rbp
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq $1
	popq %rsi
	movq %rsi, -8(%rbp)
	jmp .L2
.L0:
	movq -8(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -8(%rbp)
	movq -8(%rbp), %rdi
	pushq %rdi
	movq -8(%rbp), %rdi
	pushq %rdi
	call queens
	addq $8, %rsp
.L2:
	movq -8(%rbp), %rdi
	pushq %rdi
	pushq $10
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setl %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	jne .L0
.L1:
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
