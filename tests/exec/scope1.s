	.text
	.globl	main
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	pushq $10
	popq %rsi
	movq %rsi, -8(%rbp)
	pushq $65
	popq %rsi
	movq %rsi, -16(%rbp)
	jmp .L2
.L0:
	movq -16(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -16(%rbp)
	movq -16(%rbp), %rdi
	pushq %rdi
	movq -16(%rbp), %rdi
	pushq %rdi
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	pushq $46
	popq %rsi
	movq %rsi, -24(%rbp)
	movq -24(%rbp), %rdi
	pushq %rdi
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
.L2:
	movq -16(%rbp), %rdi
	pushq %rdi
	pushq $91
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setl %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	jne .L0
.L1:
	movq -8(%rbp), %rdi
	pushq %rdi
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
