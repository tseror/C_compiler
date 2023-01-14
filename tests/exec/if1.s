	.text
	.globl	main
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq $65
	popq %rsi
	movq %rsi, -8(%rbp)
	movq -8(%rbp), %rdi
	pushq %rdi
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	movq -8(%rbp), %rdi
	pushq %rdi
	popq %rdi
	cmpq $0, %rdi
	je .L12
	pushq $66
	popq %rsi
	movq %rsi, -8(%rbp)
	jmp .L13
.L12:
.L13:
	movq -8(%rbp), %rdi
	pushq %rdi
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	movq -8(%rbp), %rdi
	pushq %rdi
	pushq $0
	popq %rbx
	popq %rax
	cmpq $0, %rax
	movq $0, %rax
	je .L11
	cmpq $0, %rbx
	je .L11
	movq $1, %rax
.L11:
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L9
	pushq $67
	popq %rsi
	movq %rsi, -8(%rbp)
	jmp .L10
.L9:
.L10:
	movq -8(%rbp), %rdi
	pushq %rdi
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	movq -8(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	cmpq $0, %rax
	movq $0, %rax
	je .L8
	cmpq $0, %rbx
	je .L8
	movq $1, %rax
.L8:
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L6
	pushq $68
	popq %rsi
	movq %rsi, -8(%rbp)
	jmp .L7
.L6:
.L7:
	movq -8(%rbp), %rdi
	pushq %rdi
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	movq -8(%rbp), %rdi
	pushq %rdi
	pushq $0
	popq %rbx
	popq %rax
	cmpq $0, %rax
	movq $1, %rax
	jne .L5
	cmpq $0, %rbx
	jne .L5
	movq $0, %rax
.L5:
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L3
	pushq $69
	popq %rsi
	movq %rsi, -8(%rbp)
	jmp .L4
.L3:
.L4:
	movq -8(%rbp), %rdi
	pushq %rdi
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	movq -8(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	cmpq $0, %rax
	movq $1, %rax
	jne .L2
	cmpq $0, %rbx
	jne .L2
	movq $0, %rax
.L2:
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L0
	pushq $70
	popq %rsi
	movq %rsi, -8(%rbp)
	jmp .L1
.L0:
.L1:
	movq -8(%rbp), %rdi
	pushq %rdi
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
