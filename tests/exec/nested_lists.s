	.text
	.globl	main
run:
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
	pushq $1
	popq %rax
	negq %rax
	pushq %rax
	popq %rsi
	movq %rsi, -24(%rbp)
	pushq $0
	popq %rsi
	movq %rsi, -32(%rbp)
car:
	pushq %rbp
	movq %rsp, %rbp
	subq $40, %rsp
	movq -16(%rbp), %rdi
	pushq %rdi
	movq 40(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	popq %rax
	ret
	movq %rbp, %rsp
	popq %rbp
set_car:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movq 48(%rbp), %rdi
	pushq %rdi
	movq -16(%rbp), %rdi
	pushq %rdi
	movq 40(%rbp), %rdi
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
cdr:
	pushq %rbp
	movq %rsp, %rbp
	subq $40, %rsp
	movq -16(%rbp), %rdi
	pushq %rdi
	movq 40(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	pushq 0(%rdi)
	popq %rax
	ret
	movq %rbp, %rsp
	popq %rbp
set_cdr:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	movq 48(%rbp), %rdi
	pushq %rdi
	movq -16(%rbp), %rdi
	pushq %rdi
	movq 40(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
	movq %rbp, %rsp
	popq %rbp
cons:
	pushq %rbp
	movq %rsp, %rbp
	subq $56, %rsp
	movq -32(%rbp), %rdi
	pushq %rdi
	popq %rsi
	movq %rsi, -56(%rbp)
	movq -32(%rbp), %rdi
	pushq %rdi
	pushq $2
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -32(%rbp)
	movq 40(%rbp), %rdi
	pushq %rdi
	movq -16(%rbp), %rdi
	pushq %rdi
	movq -56(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
	movq 48(%rbp), %rdi
	pushq %rdi
	movq -16(%rbp), %rdi
	pushq %rdi
	movq -56(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rdi
	popq %rsi
	movq %rsi, 0(%rdi)
	movq -56(%rbp), %rdi
	pushq %rdi
	popq %rax
	ret
	movq %rbp, %rsp
	popq %rbp
interval:
	pushq %rbp
	movq %rsp, %rbp
	subq $112, %rsp
	movq -24(%rbp), %rdi
	pushq %rdi
	popq %rsi
	movq %rsi, -56(%rbp)
	jmp .L7
.L6:
	movq -56(%rbp), %rdi
	pushq %rdi
	movq 48(%rbp), %rdi
	pushq %rdi
	call cons
	addq $16, %rsp
	popq %rsi
	movq %rsi, -56(%rbp)
.L7:
	movq 40(%rbp), %rdi
	pushq %rdi
	movq 48(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	subq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, 48(%rbp)
	movq 48(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setl %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	jne .L6
.L8:
	movq -56(%rbp), %rdi
	pushq %rdi
	popq %rax
	ret
	movq %rbp, %rsp
	popq %rbp
list_reversal:
	pushq %rbp
	movq %rsp, %rbp
	subq $104, %rsp
	movq -24(%rbp), %rdi
	pushq %rdi
	popq %rsi
	movq %rsi, -48(%rbp)
	jmp .L4
.L3:
	movq 40(%rbp), %rdi
	pushq %rdi
	popq %rsi
	movq %rsi, -56(%rbp)
	movq 40(%rbp), %rdi
	pushq %rdi
	call cdr
	addq $8, %rsp
	popq %rsi
	movq %rsi, 40(%rbp)
	movq -48(%rbp), %rdi
	pushq %rdi
	movq -56(%rbp), %rdi
	pushq %rdi
	call set_cdr
	addq $16, %rsp
	movq -56(%rbp), %rdi
	pushq %rdi
	popq %rsi
	movq %rsi, -48(%rbp)
.L4:
	movq 40(%rbp), %rdi
	pushq %rdi
	movq -24(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setne %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	jne .L3
.L5:
	movq -48(%rbp), %rdi
	pushq %rdi
	popq %rax
	ret
	movq %rbp, %rsp
	popq %rbp
print:
	pushq %rbp
	movq %rsp, %rbp
	subq $40, %rsp
	jmp .L2
.L0:
	movq 40(%rbp), %rdi
	pushq %rdi
	call cdr
	addq $8, %rsp
	popq %rsi
	movq %rsi, 40(%rbp)
	movq 40(%rbp), %rdi
	pushq %rdi
	call car
	addq $8, %rsp
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
.L2:
	movq 40(%rbp), %rdi
	pushq %rdi
	movq -24(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setne %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	jne .L0
.L1:
	pushq $10
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	movq %rbp, %rsp
	popq %rbp
	pushq $122
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	pushq $97
	call interval
	addq $16, %rsp
	popq %rsi
	movq %rsi, -40(%rbp)
	movq -40(%rbp), %rdi
	pushq %rdi
	call print
	addq $8, %rsp
	movq -40(%rbp), %rdi
	pushq %rdi
	call list_reversal
	addq $8, %rsp
	popq %rsi
	movq %rsi, -40(%rbp)
	movq -40(%rbp), %rdi
	pushq %rdi
	call print
	addq $8, %rsp
	movq %rbp, %rsp
	popq %rbp
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $0, %rsp
	pushq $100
	call run
	addq $8, %rsp
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
