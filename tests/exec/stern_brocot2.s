	.text
	.globl	main
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
	je .L2
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
	jmp .L3
.L2:
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
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	movq %rbp, %rsp
	popq %rbp
compute:
	pushq %rbp
	movq %rsp, %rbp
	subq $56, %rsp
	movq 8(%rbp), %rdi
	pushq %rdi
	pushq $0
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	sete %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	je .L0
	ret
	jmp .L1
.L0:
.L1:
	movq 16(%rbp), %rdi
	pushq %rdi
	movq 32(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -48(%rbp)
	movq 24(%rbp), %rdi
	pushq %rdi
	movq 40(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -56(%rbp)
	movq -56(%rbp), %rdi
	pushq %rdi
	movq -48(%rbp), %rdi
	pushq %rdi
	movq 24(%rbp), %rdi
	pushq %rdi
	movq 16(%rbp), %rdi
	pushq %rdi
	movq 8(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	call compute
	addq $40, %rsp
	pushq $32
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	movq -48(%rbp), %rdi
	pushq %rdi
	call print_int
	addq $8, %rsp
	pushq $47
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	movq -56(%rbp), %rdi
	pushq %rdi
	call print_int
	addq $8, %rsp
	movq 40(%rbp), %rdi
	pushq %rdi
	movq 32(%rbp), %rdi
	pushq %rdi
	movq -56(%rbp), %rdi
	pushq %rdi
	movq -48(%rbp), %rdi
	pushq %rdi
	movq 8(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	call compute
	addq $40, %rsp
	movq %rbp, %rsp
	popq %rbp
stern_brocot:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq $48
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	pushq $47
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	pushq $49
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	pushq $1
	pushq $1
	pushq $1
	pushq $0
	movq 8(%rbp), %rdi
	pushq %rdi
	call compute
	addq $40, %rsp
	pushq $32
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	pushq $49
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	pushq $47
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	pushq $49
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
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $0, %rsp
	pushq $0
	call stern_brocot
	addq $8, %rsp
	pushq $1
	call stern_brocot
	addq $8, %rsp
	pushq $2
	call stern_brocot
	addq $8, %rsp
	pushq $3
	call stern_brocot
	addq $8, %rsp
	pushq $4
	call stern_brocot
	addq $8, %rsp
	pushq $10
	call stern_brocot
	addq $8, %rsp
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
