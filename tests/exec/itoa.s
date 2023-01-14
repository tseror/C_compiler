	.text
	.globl	main
itoa:
	pushq %rbp
	movq %rsp, %rbp
	subq $512, %rsp
	pushq $1
	popq %rsi
	movq %rsi, -16(%rbp)
	movq 8(%rbp), %rdi
	pushq %rdi
	pushq $0
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setl %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L11
	movq 8(%rbp), %rdi
	pushq %rdi
	popq %rax
	negq %rax
	pushq %rax
	popq %rsi
	movq %rsi, -24(%rbp)
	movq -16(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -16(%rbp)
	movq -16(%rbp), %rdi
	pushq %rdi
	jmp .L12
.L11:
	movq 8(%rbp), %rdi
	pushq %rdi
	popq %rsi
	movq %rsi, -24(%rbp)
.L12:
	movq -24(%rbp), %rdi
	pushq %rdi
	pushq $10
	popq %rbx
	popq %rax
	cqto
	idivq %rbx
	pushq %rax
	popq %rsi
	movq %rsi, -24(%rbp)
	jmp .L9
.L8:
	movq -16(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -16(%rbp)
	movq -16(%rbp), %rdi
	pushq %rdi
	movq -24(%rbp), %rdi
	pushq %rdi
	pushq $10
	popq %rbx
	popq %rax
	cqto
	idivq %rbx
	pushq %rax
	popq %rsi
	movq %rsi, -24(%rbp)
.L9:
	movq -24(%rbp), %rdi
	pushq %rdi
	pushq $0
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setne %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	jne .L8
.L10:
	movq -16(%rbp), %rdi
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
	movq %rsi, -32(%rbp)
	pushq $0
	movq -32(%rbp), %rdi
	pushq %rdi
	movq -16(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -16(%rbp)
	movq -16(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
	movq 8(%rbp), %rdi
	pushq %rdi
	pushq $0
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setl %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L6
	pushq $45
	movq -32(%rbp), %rdi
	pushq %rdi
	pushq $0
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
	movq 8(%rbp), %rdi
	pushq %rdi
	popq %rax
	negq %rax
	pushq %rax
	popq %rsi
	movq %rsi, 8(%rbp)
	jmp .L7
.L6:
.L7:
	jmp .L4
.L3:
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
	movq -32(%rbp), %rdi
	pushq %rdi
	movq -16(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -16(%rbp)
	movq -16(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
	movq 8(%rbp), %rdi
	pushq %rdi
	pushq $10
	popq %rbx
	popq %rax
	cqto
	idivq %rbx
	pushq %rax
	popq %rsi
	movq %rsi, 8(%rbp)
.L4:
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
	jne .L3
.L5:
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
	movq -32(%rbp), %rdi
	pushq %rdi
	movq -16(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
	movq -32(%rbp), %rdi
	pushq %rdi
	popq %rax
	ret
	movq %rbp, %rsp
	popq %rbp
print_string:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	jmp .L1
.L0:
	movq -16(%rbp), %rdi
	pushq %rdi
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
.L1:
	movq 8(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, 8(%rbp)
	movq 8(%rbp), %rdi
	pushq %rdi
	popq %rdi
	pushq 0(%rdi)
	popq %rsi
	movq %rsi, -16(%rbp)
	popq %rdi
	cmpq $0, %rdi
	jne .L0
.L2:
	movq %rbp, %rsp
	popq %rbp
print_endline:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	movq 8(%rbp), %rdi
	pushq %rdi
	call print_string
	addq $8, %rsp
	pushq $10
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
	pushq $0
	call itoa
	addq $8, %rsp
	call print_endline
	addq $8, %rsp
	pushq $17
	call itoa
	addq $8, %rsp
	call print_endline
	addq $8, %rsp
	pushq $5003
	call itoa
	addq $8, %rsp
	call print_endline
	addq $8, %rsp
	pushq $12
	popq %rax
	negq %rax
	pushq %rax
	call itoa
	addq $8, %rsp
	call print_endline
	addq $8, %rsp
	pushq $0
	popq %rax
	ret
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
