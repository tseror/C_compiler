	.text
	.globl	main
print:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movq 8(%rbp), %rdi
	pushq %rdi
	popq %rsi
	movq %rsi, -16(%rbp)
	movq -16(%rbp), %rdi
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
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $24, %rsp
	pushq $42
	popq %rsi
	movq %rsi, -8(%rbp)
	leaq -8(%rbp), %rdi
	pushq %rdi
	popq %rsi
	movq %rsi, -16(%rbp)
	movq -16(%rbp), %rdi
	pushq %rdi
	popq %rsi
	movq %rsi, -24(%rbp)
	movq -24(%rbp), %rdi
	pushq %rdi
	call print
	addq $8, %rsp
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
