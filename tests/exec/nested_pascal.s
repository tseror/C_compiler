	.text
	.globl	main
pascal:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	movq 8(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	pushq $8
	popq %rbx
	popq %rax
	imulq %rbx, %rax
	pushq %rax
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call malloc
	movq %rbx, %rsp
	pushq %rax
	popq %rsi
	movq %rsi, -16(%rbp)
print_row:
	pushq %rbp
	movq %rsp, %rbp
	subq $56, %rsp
	pushq $0
	popq %rsi
	movq %rsi, -32(%rbp)
	jmp .L8
.L6:
	movq -32(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -32(%rbp)
	movq -32(%rbp), %rdi
	pushq %rdi
	movq -16(%rbp), %rdi
	pushq %rdi
	movq -32(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	pushq $0
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setne %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L9
	pushq $42
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	jmp .L10
.L9:
	pushq $46
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
.L10:
.L8:
	movq -32(%rbp), %rdi
	pushq %rdi
	movq 24(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setle %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	jne .L6
.L7:
	pushq $10
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	movq %rbp, %rsp
	popq %rbp
compute_row:
	pushq %rbp
	movq %rsp, %rbp
	subq $56, %rsp
	pushq $0
	movq -16(%rbp), %rdi
	pushq %rdi
	movq 24(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
	movq 24(%rbp), %rdi
	pushq %rdi
	popq %rsi
	movq %rsi, -32(%rbp)
	jmp .L5
.L3:
	movq -32(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -32(%rbp)
	movq -32(%rbp), %rdi
	pushq %rdi
	movq -16(%rbp), %rdi
	pushq %rdi
	movq -32(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	movq -16(%rbp), %rdi
	pushq %rdi
	movq -32(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	pushq $7
	popq %rbx
	popq %rax
	cqto
	idivq %rbx
	movq %rdx, %rax
	pushq %rax
	movq -16(%rbp), %rdi
	pushq %rdi
	movq -32(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
.L5:
	movq -32(%rbp), %rdi
	pushq %rdi
	pushq $0
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setg %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	jne .L3
.L4:
	pushq $1
	movq -16(%rbp), %rdi
	pushq %rdi
	pushq $0
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
	movq %rbp, %rsp
	popq %rbp
	pushq $0
	popq %rsi
	movq %rsi, -24(%rbp)
	jmp .L2
.L0:
	movq -24(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -24(%rbp)
	movq -24(%rbp), %rdi
	pushq %rdi
	movq -24(%rbp), %rdi
	pushq %rdi
	call compute_row
	addq $8, %rsp
	movq -24(%rbp), %rdi
	pushq %rdi
	call print_row
	addq $8, %rsp
.L2:
	movq -24(%rbp), %rdi
	pushq %rdi
	movq 8(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setl %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	jne .L0
.L1:
	movq %rbp, %rsp
	popq %rbp
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $0, %rsp
	pushq $42
	call pascal
	addq $8, %rsp
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
