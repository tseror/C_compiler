	.text
	.globl	main
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $0, %rsp
	pushq $65
	pushq $1
	pushq $1
	popq %rbx
	popq %rax
	cmpq $0, %rax
	movq $0, %rax
	je .L2
	cmpq $0, %rbx
	je .L2
	movq $1, %rax
.L2:
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
	pushq $65
	pushq $1
	pushq $2
	popq %rbx
	popq %rax
	cmpq $0, %rax
	movq $0, %rax
	je .L1
	cmpq $0, %rbx
	je .L1
	movq $1, %rax
.L1:
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
	pushq $65
	pushq $1
	pushq $0
	popq %rbx
	popq %rax
	cmpq $0, %rax
	movq $0, %rax
	je .L0
	cmpq $0, %rbx
	je .L0
	movq $1, %rax
.L0:
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
