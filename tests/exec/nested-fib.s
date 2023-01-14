	.text
	.globl	main
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
fib:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
mksum:
	pushq %rbp
	movq %rsp, %rbp
	subq $24, %rsp
	movq 16(%rbp), %rdi
	pushq %rdi
	pushq $2
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	call fib
	addq $8, %rsp
	movq -8(%rbp), %rdi
	pushq %rdi
	popq %rsi
	movq %rsi, -24(%rbp)
	movq 16(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	call fib
	addq $8, %rsp
	movq -8(%rbp), %rdi
	pushq %rdi
	movq -24(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -8(%rbp)
	movq %rbp, %rsp
	popq %rbp
	movq 16(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setle %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L3
	movq 16(%rbp), %rdi
	pushq %rdi
	popq %rsi
	movq %rsi, -8(%rbp)
	jmp .L4
.L3:
	call mksum
	addq $0, %rsp
.L4:
	movq %rbp, %rsp
	popq %rbp
	pushq $10
	call fib
	addq $8, %rsp
	jmp .L1
.L0:
	pushq $46
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
.L1:
	movq -8(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -8(%rbp)
	movq -8(%rbp), %rdi
	pushq %rdi
	pushq $0
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setg %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	jne .L0
.L2:
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
