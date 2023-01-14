	.text
	.globl	main
print_int:
	pushq %rbp
	movq %rsp, %rbp
	subq $24, %rsp
	movq 8(%rbp), %rdi
	pushq %rdi
	pushq $0
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	sete %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L21
	ret
	jmp .L22
.L21:
.L22:
	movq 24(%rbp), %rdi
	pushq %rdi
	pushq $10
	popq %rbx
	popq %rax
	cqto
	idivq %rbx
	pushq %rax
	pushq $0
	movq 8(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	call print_int
	addq $24, %rsp
	movq 24(%rbp), %rdi
	pushq %rdi
	pushq $0
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	sete %al
	pushq %rax
	movq 16(%rbp), %rdi
	pushq %rdi
	popq %rax
	notq %rax
	pushq %rax
	popq %rbx
	popq %rax
	cmpq $0, %rax
	movq $0, %rax
	je .L20
	cmpq $0, %rbx
	je .L20
	movq $1, %rax
.L20:
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L18
	pushq $32
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	jmp .L19
.L18:
	pushq $48
	movq 24(%rbp), %rdi
	pushq %rdi
	pushq $10
	popq %rbx
	popq %rax
	cqto
	idivq %rbx
	movq %rdx, %rax
	pushq %rax
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
.L19:
	movq %rbp, %rsp
	popq %rbp
print:
	pushq %rbp
	movq %rsp, %rbp
	subq $1744, %rsp
	pushq $1
	movq 32(%rbp), %rdi
	pushq %rdi
	pushq $5
	popq %rbx
	popq %rax
	cqto
	idivq %rbx
	pushq %rax
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -40(%rbp)
	pushq $0
	popq %rsi
	movq %rsi, -48(%rbp)
	jmp .L17
.L15:
	movq -48(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -48(%rbp)
	movq -48(%rbp), %rdi
	pushq %rdi
	pushq $32
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	movq 8(%rbp), %rdi
	pushq %rdi
	movq -48(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	pushq $1
	movq -40(%rbp), %rdi
	pushq %rdi
	call print_int
	addq $24, %rsp
.L17:
	movq -48(%rbp), %rdi
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
	jne .L15
.L16:
	pushq $92
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	pushq $0
	popq %rsi
	movq %rsi, -144(%rbp)
	jmp .L11
.L9:
	movq -144(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -144(%rbp)
	movq -144(%rbp), %rdi
	pushq %rdi
	pushq $32
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	pushq $0
	popq %rsi
	movq %rsi, -152(%rbp)
	jmp .L14
.L12:
	movq -152(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -152(%rbp)
	movq -152(%rbp), %rdi
	pushq %rdi
	pushq $45
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
.L14:
	movq -152(%rbp), %rdi
	pushq %rdi
	movq -40(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setl %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	jne .L12
.L13:
.L11:
	movq -144(%rbp), %rdi
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
	jne .L9
.L10:
	pushq $92
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	pushq $0
	popq %rsi
	movq %rsi, -584(%rbp)
	jmp .L8
.L6:
	movq -584(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -584(%rbp)
	movq -584(%rbp), %rdi
	pushq %rdi
	pushq $32
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	movq 16(%rbp), %rdi
	pushq %rdi
	movq -584(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	pushq $1
	movq -40(%rbp), %rdi
	pushq %rdi
	call print_int
	addq $24, %rsp
.L8:
	movq -584(%rbp), %rdi
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
	jne .L6
.L7:
	movq %rbp, %rsp
	popq %rbp
pow2:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movq 8(%rbp), %rdi
	pushq %rdi
	pushq $0
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	sete %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L4
	pushq $1
	popq %rax
	ret
	jmp .L5
.L4:
.L5:
	movq 8(%rbp), %rdi
	pushq %rdi
	pushq $2
	popq %rbx
	popq %rax
	cqto
	idivq %rbx
	pushq %rax
	call pow2
	addq $8, %rsp
	popq %rsi
	movq %rsi, -16(%rbp)
	movq -16(%rbp), %rdi
	pushq %rdi
	movq -16(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	imulq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -16(%rbp)
	movq 8(%rbp), %rdi
	pushq %rdi
	pushq $2
	popq %rbx
	popq %rax
	cqto
	idivq %rbx
	movq %rdx, %rax
	pushq %rax
	pushq $1
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	sete %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L2
	pushq $2
	movq -16(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	imulq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -16(%rbp)
	jmp .L3
.L2:
.L3:
	movq -16(%rbp), %rdi
	pushq %rdi
	popq %rax
	ret
	movq %rbp, %rsp
	popq %rbp
compute:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movq 24(%rbp), %rdi
	pushq %rdi
	pushq $0
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	sete %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L0
	ret
	jmp .L1
.L0:
.L1:
	movq 32(%rbp), %rdi
	pushq %rdi
	movq 40(%rbp), %rdi
	pushq %rdi
	movq 32(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	pushq $2
	popq %rbx
	popq %rax
	cqto
	idivq %rbx
	pushq %rax
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -48(%rbp)
	movq 8(%rbp), %rdi
	pushq %rdi
	movq 32(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	movq 8(%rbp), %rdi
	pushq %rdi
	movq 40(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	movq 8(%rbp), %rdi
	pushq %rdi
	movq -48(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
	movq 16(%rbp), %rdi
	pushq %rdi
	movq 32(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	movq 16(%rbp), %rdi
	pushq %rdi
	movq 40(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	movq 16(%rbp), %rdi
	pushq %rdi
	movq -48(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
	movq -48(%rbp), %rdi
	pushq %rdi
	movq 32(%rbp), %rdi
	pushq %rdi
	movq 24(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	movq 16(%rbp), %rdi
	pushq %rdi
	movq 8(%rbp), %rdi
	pushq %rdi
	call compute
	addq $40, %rsp
	movq 40(%rbp), %rdi
	pushq %rdi
	movq -48(%rbp), %rdi
	pushq %rdi
	movq 24(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	movq 16(%rbp), %rdi
	pushq %rdi
	movq 8(%rbp), %rdi
	pushq %rdi
	call compute
	addq $40, %rsp
	movq %rbp, %rsp
	popq %rbp
stern_brocot:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq 8(%rbp), %rdi
	pushq %rdi
	call pow2
	addq $8, %rsp
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -16(%rbp)
	movq -16(%rbp), %rdi
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
	movq %rsi, -24(%rbp)
	movq -16(%rbp), %rdi
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
	movq %rsi, -32(%rbp)
	pushq $0
	movq -24(%rbp), %rdi
	pushq %rdi
	pushq $0
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
	pushq $1
	movq -32(%rbp), %rdi
	pushq %rdi
	pushq $0
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
	pushq $1
	movq -24(%rbp), %rdi
	pushq %rdi
	movq -16(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
	pushq $1
	movq -32(%rbp), %rdi
	pushq %rdi
	movq -16(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
	movq -16(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	pushq $0
	movq 8(%rbp), %rdi
	pushq %rdi
	movq -32(%rbp), %rdi
	pushq %rdi
	movq -24(%rbp), %rdi
	pushq %rdi
	call compute
	addq $40, %rsp
	movq 8(%rbp), %rdi
	pushq %rdi
	movq -16(%rbp), %rdi
	pushq %rdi
	movq -32(%rbp), %rdi
	pushq %rdi
	movq -24(%rbp), %rdi
	pushq %rdi
	call print
	addq $32, %rsp
	movq %rbp, %rsp
	popq %rbp
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $0, %rsp
	pushq $4
	call stern_brocot
	addq $8, %rsp
	pushq $10
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
