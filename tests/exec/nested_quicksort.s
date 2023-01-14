	.text
	.globl	main
quicksort:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
swap:
	pushq %rbp
	movq %rsp, %rbp
	subq $40, %rsp
	movq 8(%rbp), %rdi
	pushq %rdi
	movq 24(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	popq %rsi
	movq %rsi, -40(%rbp)
	movq 8(%rbp), %rdi
	pushq %rdi
	movq 32(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	movq 8(%rbp), %rdi
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
	movq -40(%rbp), %rdi
	pushq %rdi
	movq 8(%rbp), %rdi
	pushq %rdi
	movq 32(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
	movq %rbp, %rsp
	popq %rbp
quickrec:
	pushq %rbp
	movq %rsp, %rbp
	subq $1128, %rsp
	movq 32(%rbp), %rdi
	pushq %rdi
	movq 24(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	pushq $1
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setle %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L14
	ret
	jmp .L15
.L14:
.L15:
	movq 8(%rbp), %rdi
	pushq %rdi
	movq 24(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	popq %rsi
	movq %rsi, -40(%rbp)
	movq 24(%rbp), %rdi
	pushq %rdi
	popq %rsi
	movq %rsi, -48(%rbp)
	movq 32(%rbp), %rdi
	pushq %rdi
	popq %rsi
	movq %rsi, -56(%rbp)
	movq 24(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -64(%rbp)
	jmp .L9
.L7:
	movq 8(%rbp), %rdi
	pushq %rdi
	movq -64(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	movq -40(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setl %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L10
	movq -48(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -48(%rbp)
	movq -48(%rbp), %rdi
	pushq %rdi
	movq -64(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -64(%rbp)
	movq -64(%rbp), %rdi
	pushq %rdi
	call swap
	addq $16, %rsp
	jmp .L11
.L10:
	movq 8(%rbp), %rdi
	pushq %rdi
	movq -64(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	movq -40(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	sete %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L12
	movq -64(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -64(%rbp)
	movq -64(%rbp), %rdi
	pushq %rdi
	jmp .L13
.L12:
	movq -56(%rbp), %rdi
	pushq %rdi
	movq -56(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -56(%rbp)
	movq -64(%rbp), %rdi
	pushq %rdi
	call swap
	addq $16, %rsp
.L13:
.L11:
.L9:
	movq -64(%rbp), %rdi
	pushq %rdi
	movq -56(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setl %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	jne .L7
.L8:
	movq -48(%rbp), %rdi
	pushq %rdi
	movq 24(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	movq 32(%rbp), %rdi
	pushq %rdi
	movq -56(%rbp), %rdi
	pushq %rdi
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
	je .L5
	movq -48(%rbp), %rdi
	pushq %rdi
	movq 24(%rbp), %rdi
	pushq %rdi
	call quickrec
	addq $16, %rsp
	movq 32(%rbp), %rdi
	pushq %rdi
	movq -56(%rbp), %rdi
	pushq %rdi
	call quickrec
	addq $16, %rsp
	jmp .L6
.L5:
	movq 32(%rbp), %rdi
	pushq %rdi
	movq -56(%rbp), %rdi
	pushq %rdi
	call quickrec
	addq $16, %rsp
	movq -48(%rbp), %rdi
	pushq %rdi
	movq 24(%rbp), %rdi
	pushq %rdi
	call quickrec
	addq $16, %rsp
.L6:
	movq %rbp, %rsp
	popq %rbp
	movq 16(%rbp), %rdi
	pushq %rdi
	pushq $0
	call quickrec
	addq $16, %rsp
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
	je .L3
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
	jmp .L4
.L3:
.L4:
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
	subq $64, %rsp
	pushq $5
	popq %rsi
	movq %rsi, -8(%rbp)
	movq -8(%rbp), %rdi
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
	pushq $42
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
	pushq $21
	movq -16(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
	pushq $42
	movq -16(%rbp), %rdi
	pushq %rdi
	pushq $2
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
	pushq $1
	movq -16(%rbp), %rdi
	pushq %rdi
	pushq $3
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
	pushq $1
	movq -16(%rbp), %rdi
	pushq %rdi
	pushq $4
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
	movq -8(%rbp), %rdi
	pushq %rdi
	movq -16(%rbp), %rdi
	pushq %rdi
	call quicksort
	addq $16, %rsp
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
	movq -16(%rbp), %rdi
	pushq %rdi
	movq -24(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	call print_int
	addq $8, %rsp
	pushq $92
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
.L2:
	movq -24(%rbp), %rdi
	pushq %rdi
	movq -8(%rbp), %rdi
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
	ret
	.data
