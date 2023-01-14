	.text
	.globl	main
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq $0
	popq %rsi
	movq %rsi, -8(%rbp)
	movq -8(%rbp), %rdi
	pushq %rdi
	popq %rdi
	pushq 0(%rdi)
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
