	.text
	.globl	main
fact_rec:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	movq 8(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setle %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L6
	pushq $1
	popq %rax
	ret
	jmp .L7
.L6:
.L7:
	movq 8(%rbp), %rdi
	pushq %rdi
	movq 8(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	call fact_rec
	addq $8, %rsp
	popq %rbx
	popq %rax
	imulq %rbx, %rax
	pushq %rax
	popq %rax
	ret
	movq %rbp, %rsp
	popq %rbp
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $0, %rsp
	pushq $0
	call fact_rec
	addq $8, %rsp
	pushq $1
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	sete %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L4
	pushq $49
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	jmp .L5
.L4:
.L5:
	pushq $1
	call fact_rec
	addq $8, %rsp
	pushq $1
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	sete %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L2
	pushq $50
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	jmp .L3
.L2:
.L3:
	pushq $5
	call fact_rec
	addq $8, %rsp
	pushq $120
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	sete %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L0
	pushq $51
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	jmp .L1
.L0:
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
