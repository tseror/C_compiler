	.text
	.globl	main
comb1:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	movq 16(%rbp), %rdi
	pushq %rdi
	pushq $0
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	sete %al
	pushq %rax
	movq 16(%rbp), %rdi
	pushq %rdi
	movq 8(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	sete %al
	pushq %rax
	popq %rbx
	popq %rax
	cmpq $0, %rax
	movq $1, %rax
	jne .L15
	cmpq $0, %rbx
	jne .L15
	movq $0, %rax
.L15:
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L13
	pushq $1
	popq %rax
	ret
	jmp .L14
.L13:
.L14:
	movq 16(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	movq 8(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	call comb1
	addq $16, %rsp
	movq 16(%rbp), %rdi
	pushq %rdi
	movq 8(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	call comb1
	addq $16, %rsp
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rax
	ret
	movq %rbp, %rsp
	popq %rbp
comb2:
	pushq %rbp
	movq %rsp, %rbp
	subq $128, %rsp
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
	movq %rsi, -24(%rbp)
	pushq $0
	popq %rsi
	movq %rsi, -32(%rbp)
	jmp .L9
.L7:
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
	movq 16(%rbp), %rdi
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
	pushq $0
	popq %rsi
	movq %rsi, -40(%rbp)
	jmp .L12
.L10:
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
	pushq $0
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
	movq -40(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
.L12:
	movq -40(%rbp), %rdi
	pushq %rdi
	movq 16(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setle %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	jne .L10
.L11:
.L9:
	movq -32(%rbp), %rdi
	pushq %rdi
	movq 8(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setle %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	jne .L7
.L8:
compute:
	pushq %rbp
	movq %rsp, %rbp
	subq $152, %rsp
	movq -24(%rbp), %rdi
	pushq %rdi
	movq 136(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	movq 144(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	popq %rsi
	movq %rsi, -152(%rbp)
	movq -152(%rbp), %rdi
	pushq %rdi
	pushq $0
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setg %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L5
	movq -152(%rbp), %rdi
	pushq %rdi
	popq %rax
	ret
	jmp .L6
.L5:
.L6:
	movq 144(%rbp), %rdi
	pushq %rdi
	pushq $0
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	sete %al
	pushq %rax
	movq 144(%rbp), %rdi
	pushq %rdi
	movq 136(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	sete %al
	pushq %rax
	popq %rbx
	popq %rax
	cmpq $0, %rax
	movq $1, %rax
	jne .L4
	cmpq $0, %rbx
	jne .L4
	movq $0, %rax
.L4:
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L2
	pushq $1
	popq %rsi
	movq %rsi, -152(%rbp)
	jmp .L3
.L2:
	movq 144(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	movq 136(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	call compute
	addq $16, %rsp
	movq 144(%rbp), %rdi
	pushq %rdi
	movq 136(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	call compute
	addq $16, %rsp
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -152(%rbp)
.L3:
	movq -152(%rbp), %rdi
	pushq %rdi
	movq -24(%rbp), %rdi
	pushq %rdi
	movq 136(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	movq 144(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
	popq %rax
	ret
	movq %rbp, %rsp
	popq %rbp
	movq 16(%rbp), %rdi
	pushq %rdi
	movq 8(%rbp), %rdi
	pushq %rdi
	call compute
	addq $16, %rsp
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
	pushq $10
	call comb1
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
	pushq $10
	call comb2
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
