	.text
	.globl	main
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq $10
	popq %rsi
	movq %rsi, -8(%rbp)
	jmp .L2
.L0:
	pushq $65
	movq -8(%rbp), %rdi
	pushq %rdi
	movq -8(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -8(%rbp)
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
.L2:
	movq -8(%rbp), %rdi
	pushq %rdi
	popq %rdi
	cmpq $0, %rdi
	jne .L0
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
