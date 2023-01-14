	.text
	.globl	main
f:
	pushq %rbp
	movq %rsp, %rbp
	subq $24, %rsp
	movq 8(%rbp), %rdi
	pushq %rdi
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	movq 16(%rbp), %rdi
	pushq %rdi
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	movq 24(%rbp), %rdi
	pushq %rdi
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
	movq 8(%rbp), %rdi
	pushq %rdi
	pushq $99
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setne %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L0
	movq 8(%rbp), %rdi
	pushq %rdi
	movq 24(%rbp), %rdi
	pushq %rdi
	movq 16(%rbp), %rdi
	pushq %rdi
	call f
	addq $24, %rsp
	jmp .L1
.L0:
.L1:
	movq %rbp, %rsp
	popq %rbp
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $0, %rsp
	pushq $99
	pushq $98
	pushq $97
	call f
	addq $24, %rsp
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
