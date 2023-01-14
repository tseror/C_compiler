	.text
	.globl	main
f:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
g:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
add:
	pushq %rbp
	movq %rsp, %rbp
	subq $24, %rsp
	movq 24(%rbp), %rdi
	pushq %rdi
	popq %rdi
	pushq 0(%rdi)
	movq 16(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	movq 24(%rbp), %rdi
	pushq %rdi
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
	movq %rbp, %rsp
	popq %rbp
	leaq 8(%rbp), %rdi
	pushq %rdi
	call add
	addq $8, %rsp
	movq 8(%rbp), %rdi
	pushq %rdi
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	movq %rbp, %rsp
	popq %rbp
	pushq $104
	pushq $97
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	call g
	addq $8, %rsp
	pushq $101
	pushq $104
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	call g
	addq $8, %rsp
	pushq $108
	pushq $101
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	call g
	addq $8, %rsp
	pushq $108
	pushq $108
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	call g
	addq $8, %rsp
	pushq $111
	pushq $108
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	call g
	addq $8, %rsp
	pushq $32
	pushq $111
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	call g
	addq $8, %rsp
	pushq $119
	pushq $32
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	call g
	addq $8, %rsp
	pushq $111
	pushq $119
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	call g
	addq $8, %rsp
	pushq $114
	pushq $111
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	call g
	addq $8, %rsp
	pushq $108
	pushq $114
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	call g
	addq $8, %rsp
	pushq $100
	pushq $108
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	call g
	addq $8, %rsp
	pushq $92
	pushq $100
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	call g
	addq $8, %rsp
	movq %rbp, %rsp
	popq %rbp
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $0, %rsp
	pushq $97
	call f
	addq $8, %rsp
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
