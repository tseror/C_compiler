	.text
	.globl	main
fact_imp:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	pushq $1
	popq %rsi
	movq %rsi, -16(%rbp)
	jmp .L7
.L6:
	movq -16(%rbp), %rdi
	pushq %rdi
	movq 8(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, 8(%rbp)
	movq 8(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	imulq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -16(%rbp)
.L7:
	movq 8(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setg %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	jne .L6
.L8:
	movq -16(%rbp), %rdi
	pushq %rdi
	popq %rax
	ret
	movq %rbp, %rsp
	popq %rbp
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $0, %rsp
	pushq $0
	call fact_imp
	addq $8, %rsp
	pushq $1
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	sete %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L4
	pushq $49
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	jmp .L5
.L4:
.L5:
	pushq $1
	call fact_imp
	addq $8, %rsp
	pushq $1
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	sete %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L2
	pushq $50
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	jmp .L3
.L2:
.L3:
	pushq $5
	call fact_imp
	addq $8, %rsp
	pushq $120
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	sete %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L0
	pushq $51
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	jmp .L1
.L0:
.L1:
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
