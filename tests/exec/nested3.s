	.text
	.globl	main
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $0, %rsp
f:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	pushq $1
	popq %rsi
	movq %rsi, -16(%rbp)
g:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	pushq $3
	popq %rsi
	movq %rsi, -40(%rbp)
	pushq $5
	popq %rsi
	movq %rsi, -48(%rbp)
h:
	pushq %rbp
	movq %rsp, %rbp
	subq $80, %rsp
	pushq $34
	popq %rsi
	movq %rsi, -80(%rbp)
	movq 8(%rbp), %rdi
	pushq %rdi
	movq -16(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	movq 24(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	movq 32(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	movq -40(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	movq -48(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	movq 56(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	movq 64(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	movq 72(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	movq -80(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rax
	ret
	movq %rbp, %rsp
	popq %rbp
	pushq $21
	pushq $13
	pushq $8
	call h
	addq $24, %rsp
	popq %rax
	ret
	movq %rbp, %rsp
	popq %rbp
	pushq $2
	pushq $1
	call g
	addq $16, %rsp
	popq %rax
	ret
	movq %rbp, %rsp
	popq %rbp
	pushq $0
	call f
	addq $8, %rsp
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	pushq $101
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	pushq $115
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
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
