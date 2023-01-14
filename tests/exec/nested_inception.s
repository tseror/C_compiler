	.text
	.globl	main
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $120, %rsp
	pushq $89
	popq %rsi
	movq %rsi, -8(%rbp)
	pushq $65
	popq %rsi
	movq %rsi, -16(%rbp)
	pushq $69
	popq %rsi
	movq %rsi, -24(%rbp)
	pushq $67
	popq %rsi
	movq %rsi, -32(%rbp)
	pushq $83
	popq %rsi
	movq %rsi, -40(%rbp)
	pushq $65
	popq %rsi
	movq %rsi, -48(%rbp)
	pushq $82
	popq %rsi
	movq %rsi, -56(%rbp)
	pushq $1
	popq %rsi
	movq %rsi, -64(%rbp)
	pushq $1
	popq %rsi
	movq %rsi, -72(%rbp)
	pushq $1
	popq %rsi
	movq %rsi, -80(%rbp)
	pushq $1
	popq %rsi
	movq %rsi, -88(%rbp)
	pushq $1
	popq %rsi
	movq %rsi, -96(%rbp)
	pushq $1
	popq %rsi
	movq %rsi, -104(%rbp)
	pushq $1
	popq %rsi
	movq %rsi, -112(%rbp)
	pushq $1
	popq %rsi
	movq %rsi, -120(%rbp)
present:
	pushq %rbp
	movq %rsp, %rbp
	subq $136, %rsp
	pushq $32
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	movq 128(%rbp), %rdi
	pushq %rdi
	popq %rdi
	cmpq $0, %rdi
	je .L6
	movq 136(%rbp), %rdi
	pushq %rdi
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
	jmp .L7
.L6:
	pushq $32
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
.L7:
	movq %rbp, %rsp
	popq %rbp
draw:
	pushq %rbp
	movq %rsp, %rbp
	subq $376, %rsp
	pushq $0
	popq %rsi
	movq %rsi, -128(%rbp)
	jmp .L5
.L3:
	movq -128(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -128(%rbp)
	movq -128(%rbp), %rdi
	pushq %rdi
	movq -8(%rbp), %rdi
	pushq %rdi
	movq -72(%rbp), %rdi
	pushq %rdi
	call present
	addq $16, %rsp
	movq -16(%rbp), %rdi
	pushq %rdi
	movq -80(%rbp), %rdi
	pushq %rdi
	call present
	addq $16, %rsp
	movq -24(%rbp), %rdi
	pushq %rdi
	movq -88(%rbp), %rdi
	pushq %rdi
	call present
	addq $16, %rsp
	movq -48(%rbp), %rdi
	pushq %rdi
	movq -112(%rbp), %rdi
	pushq %rdi
	call present
	addq $16, %rsp
	movq -56(%rbp), %rdi
	pushq %rdi
	movq -120(%rbp), %rdi
	pushq %rdi
	call present
	addq $16, %rsp
	movq -32(%rbp), %rdi
	pushq %rdi
	movq -96(%rbp), %rdi
	pushq %rdi
	call present
	addq $16, %rsp
	movq -40(%rbp), %rdi
	pushq %rdi
	movq -104(%rbp), %rdi
	pushq %rdi
	call present
	addq $16, %rsp
	pushq $10
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
.L5:
	movq -128(%rbp), %rdi
	pushq %rdi
	movq -64(%rbp), %rdi
	pushq %rdi
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setl %al
	pushq %rax
	popq %rdi
	cmpq $0, %rdi
	jne .L3
.L4:
	movq %rbp, %rsp
	popq %rbp
airplane:
	pushq %rbp
	movq %rsp, %rbp
	subq $120, %rsp
van:
	pushq %rbp
	movq %rsp, %rbp
	subq $120, %rsp
hotel:
	pushq %rbp
	movq %rsp, %rbp
	subq $120, %rsp
fortress:
	pushq %rbp
	movq %rsp, %rbp
	subq $120, %rsp
dream_city:
	pushq %rbp
	movq %rsp, %rbp
	subq $248, %rsp
limbo:
	pushq %rbp
	movq %rsp, %rbp
	subq $120, %rsp
	call draw
	addq $0, %rsp
	movq %rbp, %rsp
	popq %rbp
	pushq $0
	popq %rsi
	movq %rsi, -128(%rbp)
	jmp .L2
.L0:
	movq -128(%rbp), %rdi
	pushq %rdi
	pushq $1
	popq %rbx
	popq %rax
	addq %rbx, %rax
	pushq %rax
	popq %rsi
	movq %rsi, -128(%rbp)
	movq -128(%rbp), %rdi
	pushq %rdi
	pushq $45
	popq %rdi
	movq %rsp, %rbx
	andq $-16, %rsp
	call putchar
	movq %rbx, %rsp
.L2:
	movq -128(%rbp), %rdi
	pushq %rdi
	pushq $14
	popq %rbx
	popq %rax
	cmpq %rbx, %rax
	setl %al
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
	pushq $0
	popq %rsi
	movq %rsi, -112(%rbp)
	pushq $0
	popq %rsi
	movq %rsi, -120(%rbp)
	call limbo
	addq $0, %rsp
	movq %rbp, %rsp
	popq %rbp
	call draw
	addq $0, %rsp
	call dream_city
	addq $0, %rsp
	movq %rbp, %rsp
	popq %rbp
	call draw
	addq $0, %rsp
	pushq $0
	popq %rsi
	movq %rsi, -88(%rbp)
	call fortress
	addq $0, %rsp
	movq %rbp, %rsp
	popq %rbp
	call draw
	addq $0, %rsp
	pushq $0
	popq %rsi
	movq %rsi, -80(%rbp)
	call hotel
	addq $0, %rsp
	movq %rbp, %rsp
	popq %rbp
	call draw
	addq $0, %rsp
	pushq $0
	popq %rsi
	movq %rsi, -72(%rbp)
	call van
	addq $0, %rsp
	movq %rbp, %rsp
	popq %rbp
	call airplane
	addq $0, %rsp
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
