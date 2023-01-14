	.text
	.globl	main
f:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq 8(%rbp), %rdi
	pushq %rdi
	popq %rax
	notq %rax
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L0
	ret
	jmp .L1
.L0:
.L1:
	movq 8(%rbp), %rdi
	pushq %rdi
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	movq 8(%rbp), %rdi
	pushq %rdi
	movq 32(%rbp), %rdi
	pushq %rdi
	movq 24(%rbp), %rdi
	pushq %rdi
	movq 16(%rbp), %rdi
	pushq %rdi
	call f
	addq $32, %rsp
	movq %rbp, %rsp
	popq %rbp
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $0, %rsp
	pushq $0
	pushq $67
	pushq $66
	pushq $65
	call f
	addq $32, %rsp
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
