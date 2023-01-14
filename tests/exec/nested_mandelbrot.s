	.text
	.globl	main
add:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movq 8(%rbp), %rdi
	pushq %rdi
	movq 16(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rax
	ret
	movq %rbp, %rsp
	popq %rbp
sub:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movq 8(%rbp), %rdi
	pushq %rdi
	movq 16(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	popq %rax
	ret
	movq %rbp, %rsp
	popq %rbp
mul:
	pushq %rbp
	movq %rsp, %rbp
	subq $24, %rsp
	movq 8(%rbp), %rdi
	pushq %rdi
	movq 16(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	imulq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -24(%rbp)
	movq -24(%rbp), %rdi
	pushq %rdi
	pushq $8192
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
	pushq $8192
	popq %rbx
	popq %rax
	cqto
	idivq %rbx
	pushq %rax
	popq %rax
	ret
	movq %rbp, %rsp
	popq %rbp
divide:
	pushq %rbp
	movq %rsp, %rbp
	subq $24, %rsp
	movq 8(%rbp), %rdi
	pushq %rdi
	pushq $8192
	popq %rbx
	popq %rax
	imulq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -24(%rbp)
	movq -24(%rbp), %rdi
	pushq %rdi
	movq 16(%rbp), %rdi
	pushq %rdi
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
	movq 16(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	cqto
	idivq %rbx
	pushq %rax
	popq %rax
	ret
	movq %rbp, %rsp
	popq %rbp
of_int:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	movq 8(%rbp), %rdi
	pushq %rdi
	pushq $8192
	popq %rbx
	popq %rax
	imulq %rbx, %rax
	pushq %rax
	popq %rax
	ret
	movq %rbp, %rsp
	popq %rbp
inside:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
iter:
	pushq %rbp
	movq %rsp, %rbp
	subq $56, %rsp
	movq 24(%rbp), %rdi
	pushq %rdi
	pushq $100
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	sete %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L10
	pushq $1
	popq %rax
	ret
	jmp .L11
.L10:
.L11:
	movq 32(%rbp), %rdi
	pushq %rdi
	movq 32(%rbp), %rdi
	pushq %rdi
	call mul
	addq $16, %rsp
	popq %rsi
	movq %rsi, -48(%rbp)
	movq 40(%rbp), %rdi
	pushq %rdi
	movq 40(%rbp), %rdi
	pushq %rdi
	call mul
	addq $16, %rsp
	popq %rsi
	movq %rsi, -56(%rbp)
	movq -56(%rbp), %rdi
	pushq %rdi
	movq -48(%rbp), %rdi
	pushq %rdi
	call add
	addq $16, %rsp
	pushq $4
	call of_int
	addq $8, %rsp
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setg %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L8
	pushq $0
	popq %rax
	ret
	jmp .L9
.L8:
.L9:
	movq 16(%rbp), %rdi
	pushq %rdi
	movq 40(%rbp), %rdi
	pushq %rdi
	movq 32(%rbp), %rdi
	pushq %rdi
	call mul
	addq $16, %rsp
	pushq $2
	call of_int
	addq $8, %rsp
	call mul
	addq $16, %rsp
	call add
	addq $16, %rsp
	movq 8(%rbp), %rdi
	pushq %rdi
	movq -56(%rbp), %rdi
	pushq %rdi
	movq -48(%rbp), %rdi
	pushq %rdi
	call sub
	addq $16, %rsp
	call add
	addq $16, %rsp
	movq 24(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	call iter
	addq $24, %rsp
	popq %rax
	ret
	movq %rbp, %rsp
	popq %rbp
	pushq $0
	call of_int
	addq $8, %rsp
	pushq $0
	call of_int
	addq $8, %rsp
	pushq $0
	call iter
	addq $24, %rsp
	popq %rax
	ret
	movq %rbp, %rsp
	popq %rbp
run:
	pushq %rbp
	movq %rsp, %rbp
	subq $360, %rsp
	pushq $2
	popq %rax
	negq %rax
	pushq %rax
	call of_int
	addq $8, %rsp
	popq %rsi
	movq %rsi, -16(%rbp)
	pushq $1
	call of_int
	addq $8, %rsp
	popq %rsi
	movq %rsi, -24(%rbp)
	pushq $2
	movq 8(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	imulq %rbx, %rax
	pushq %rax
	call of_int
	addq $8, %rsp
	movq -16(%rbp), %rdi
	pushq %rdi
	movq -24(%rbp), %rdi
	pushq %rdi
	call sub
	addq $16, %rsp
	call divide
	addq $16, %rsp
	popq %rsi
	movq %rsi, -32(%rbp)
	pushq $1
	popq %rax
	negq %rax
	pushq %rax
	call of_int
	addq $8, %rsp
	popq %rsi
	movq %rsi, -40(%rbp)
	pushq $1
	call of_int
	addq $8, %rsp
	popq %rsi
	movq %rsi, -48(%rbp)
	movq 8(%rbp), %rdi
	pushq %rdi
	call of_int
	addq $8, %rsp
	movq -40(%rbp), %rdi
	pushq %rdi
	movq -48(%rbp), %rdi
	pushq %rdi
	call sub
	addq $16, %rsp
	call divide
	addq $16, %rsp
	popq %rsi
	movq %rsi, -56(%rbp)
	pushq $0
	popq %rsi
	movq %rsi, -64(%rbp)
	jmp .L2
.L0:
	movq -64(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -64(%rbp)
	movq -64(%rbp), %rdi
	pushq %rdi
	movq -56(%rbp), %rdi
	pushq %rdi
	movq -64(%rbp), %rdi
	pushq %rdi
	call of_int
	addq $8, %rsp
	call mul
	addq $16, %rsp
	movq -40(%rbp), %rdi
	pushq %rdi
	call add
	addq $16, %rsp
	popq %rsi
	movq %rsi, -72(%rbp)
	pushq $0
	popq %rsi
	movq %rsi, -80(%rbp)
	jmp .L5
.L3:
	movq -80(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -80(%rbp)
	movq -80(%rbp), %rdi
	pushq %rdi
	movq -32(%rbp), %rdi
	pushq %rdi
	movq -80(%rbp), %rdi
	pushq %rdi
	call of_int
	addq $8, %rsp
	call mul
	addq $16, %rsp
	movq -16(%rbp), %rdi
	pushq %rdi
	call add
	addq $16, %rsp
	popq %rsi
	movq %rsi, -88(%rbp)
	movq -72(%rbp), %rdi
	pushq %rdi
	movq -88(%rbp), %rdi
	pushq %rdi
	call inside
	addq $16, %rsp
	popq %rdi
	cmpq $0, %rdi
	je .L6
	pushq $48
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	jmp .L7
.L6:
	pushq $49
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
.L7:
.L5:
	movq -80(%rbp), %rdi
	pushq %rdi
	pushq $2
	movq 8(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	imulq %rbx, %rax
	pushq %rax
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setl %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	jne .L3
.L4:
	pushq $10
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
.L2:
	movq -64(%rbp), %rdi
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
	jne .L0
.L1:
	movq %rbp, %rsp
	popq %rbp
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $0, %rsp
	pushq $30
	call run
	addq $8, %rsp
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
