	.text
	.globl	main
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	leaq -8(%rbp), %rdi
	pushq %rdi
	popq %rsi
	movq %rsi, -16(%rbp)
	pushq $65
	movq -16(%rbp), %rdi
	pushq %rdi
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
	movq -8(%rbp), %rdi
	pushq %rdi
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	movq -16(%rbp), %rdi
	pushq %rdi
	popq %rdi
	pushq 0(%rdi)
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	pushq $66
	popq %rsi
	movq %rsi, -8(%rbp)
	movq -8(%rbp), %rdi
	pushq %rdi
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	movq -16(%rbp), %rdi
	pushq %rdi
	popq %rdi
	pushq 0(%rdi)
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	pushq $67
	movq -16(%rbp), %rdi
	pushq %rdi
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
	movq -8(%rbp), %rdi
	pushq %rdi
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	movq -16(%rbp), %rdi
	pushq %rdi
	popq %rdi
	pushq 0(%rdi)
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
