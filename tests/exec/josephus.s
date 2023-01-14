	.text
	.globl	main
cycle:
	pushq %rbp
	movq %rsp, %rbp
	subq $40, %rsp
	movq 8(%rbp), %rdi
	pushq %rdi
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
	pushq $0
	popq %rsi
	movq %rsi, -24(%rbp)
	jmp .L10
.L8:
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
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	movq 8(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	cqto
	idivq %rbx
	movq %rdx, %rax
	pushq %rax
	movq -16(%rbp), %rdi
	pushq %rdi
	movq -24(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
.L10:
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
	jne .L8
.L9:
	movq -16(%rbp), %rdi
	pushq %rdi
	popq %rax
	ret
	movq %rbp, %rsp
	popq %rbp
josephus:
	pushq %rbp
	movq %rsp, %rbp
	subq $104, %rsp
	movq 8(%rbp), %rdi
	pushq %rdi
	call cycle
	addq $8, %rsp
	popq %rsi
	movq %rsi, -24(%rbp)
	pushq $0
	popq %rsi
	movq %rsi, -32(%rbp)
	jmp .L3
.L2:
	pushq $1
	popq %rsi
	movq %rsi, -40(%rbp)
	jmp .L7
.L5:
	movq -40(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -40(%rbp)
	movq -40(%rbp), %rdi
	pushq %rdi
	movq -24(%rbp), %rdi
	pushq %rdi
	movq -32(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	popq %rsi
	movq %rsi, -32(%rbp)
.L7:
	movq -40(%rbp), %rdi
	pushq %rdi
	movq 16(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setl %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	jne .L5
.L6:
	movq -24(%rbp), %rdi
	pushq %rdi
	movq -24(%rbp), %rdi
	pushq %rdi
	movq -32(%rbp), %rdi
	pushq %rdi
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
	popq %rdi
	pushq 0(%rdi)
	movq -24(%rbp), %rdi
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
	movq -24(%rbp), %rdi
	pushq %rdi
	movq -32(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	popq %rsi
	movq %rsi, -32(%rbp)
.L3:
	movq -24(%rbp), %rdi
	pushq %rdi
	movq -32(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	movq -32(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setne %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	jne .L2
.L4:
	movq -32(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rax
	ret
	movq %rbp, %rsp
	popq %rbp
print_int:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	movq 8(%rbp), %rdi
	pushq %rdi
	pushq $9
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setg %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L0
	movq 8(%rbp), %rdi
	pushq %rdi
	pushq $10
	popq %rbx
	popq %rax
	cqto
	idivq %rbx
	pushq %rax
	call print_int
	addq $8, %rsp
	jmp .L1
.L0:
.L1:
	pushq $48
	movq 8(%rbp), %rdi
	pushq %rdi
	pushq $10
	popq %rbx
	popq %rax
	cqto
	idivq %rbx
	movq %rdx, %rax
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
	movq %rbp, %rsp
	popq %rbp
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $0, %rsp
	pushq $5
	pushq $7
	call josephus
	addq $16, %rsp
	call print_int
	addq $8, %rsp
	pushq $10
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	pushq $5
	pushq $5
	call josephus
	addq $16, %rsp
	call print_int
	addq $8, %rsp
	pushq $10
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	pushq $17
	pushq $5
	call josephus
	addq $16, %rsp
	call print_int
	addq $8, %rsp
	pushq $10
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	pushq $2
	pushq $13
	call josephus
	addq $16, %rsp
	call print_int
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
