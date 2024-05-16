.data

matrice:  .space 1300
    matrice_extinsa: .space 1600
    columnIndex: .space 4
    lineIndex:   .space 4
    lext: .space 4
    cext: .space 4
    m: .space 4
    n: .space 4
    p:           .space 4
    k:           .space 4
    contor:      .space 4
    linie: .space 4
    coloana: .space 4
    numar_evolutie: .space 4
    formatScanf: .asciz "%ld"
    formatPrintf:.asciz "%ld"
    newLine:     .asciz "\n"
    new_m: .space 4
    new_n: .space 4
    matriceL: .space 4
    matriceC: .space 4

.text

.global main

main:

    pushl $m
    pushl $formatScanf
    call  scanf
    popl  %ebx
    popl  %ebx

    pushl $n
    pushl $formatScanf
    call  scanf
    popl  %ebx
    popl  %ebx

    pushl $p
    pushl $formatScanf
    call  scanf
    popl  %ebx
    popl  %ebx

    movl $0, contor
    movl $0, numar_evolutie
    lea matrice, %edi
    lea matrice_extinsa, %esi

    movl n, %eax
    addl $2, %eax
    movl %eax, new_n
    movl m, %eax
    addl $2, %eax
    movl %eax, new_m

et_celule_vii:

movl contor, %ecx
    cmp %ecx, p
    je et_cont
    pushl $linie
    pushl $formatScanf
    call scanf
    popl %ebx
    popl %ebx

    pushl $coloana
    pushl $formatScanf
    call scanf
    popl %ebx
    popl %ebx

    lea matrice, %edi
    movl linie, %eax
    mull n
    addl coloana, %eax
    movl $1, (%edi, %eax, 4)

    incl contor
    jmp et_celule_vii

et_cont:

    pushl $k
    pushl $formatScanf
    call  scanf
    popl  %ebx
    popl  %ebx

et_extindere_matrice:
   
    movl numar_evolutie, %ecx
    cmpl %ecx,k
    je et_afis_matr
    movl $0, lineIndex
    movl $1, lext

et_copiere_linii:

    movl lineIndex, %ecx
    cmpl %ecx, m
    je verificare
    movl $0, columnIndex
    movl $1, cext

    et_copiere_coloane:

        movl columnIndex, %ecx
        cmpl %ecx, n
        je continuare

        movl lineIndex, %eax
        mull n
        addl columnIndex, %eax
        movl (%edi, %eax, 4), %ebx

        movl lext, %eax
        mull new_n
        addl cext, %eax
        movl %ebx, (%esi, %eax, 4)

        incl columnIndex
       
        incl cext
        jmp et_copiere_coloane

continuare:

        incl lineIndex
        incl lext
        jmp et_copiere_linii

verificare:

    movl $1, lineIndex
    movl $0, contor

et_linii:

    movl m, %eax
    addl $1, %eax

    movl lineIndex, %ecx
    cmpl %ecx, %eax
    je cont_et_extindere_matrice

    movl lineIndex, %ecx
    subl $1, %ecx
    movl %ecx, lext
    movl $1, columnIndex


et_coloane:

    movl n, %eax
    addl $1, %eax
    movl columnIndex, %ecx
    cmp %ecx, %eax
    je cont_et_linii
   
    movl columnIndex, %ecx
    addl $1, %ecx
    movl %ecx, cext

    movl lext, %eax
    mull new_n
    addl cext, %eax
    leal matrice_extinsa, %esi
    movl (%esi, %eax, 4), %ecx
    addl %ecx, contor

    decl cext
    movl lext, %eax
    mull new_n
    addl cext, %eax
    leal matrice_extinsa, %esi
    movl (%esi, %eax, 4), %ecx
    addl %ecx, contor

    decl cext
    movl lext, %eax
    mull new_n
    addl cext, %eax
    movl (%esi, %eax, 4), %ecx
    addl %ecx, contor

    incl lext
    movl lext, %eax
    mull new_n
    addl cext, %eax
    movl (%esi, %eax, 4), %ecx
    addl %ecx, contor

    incl cext
    incl cext
    movl lext, %eax
    mull new_n
    addl cext, %eax
    movl (%esi, %eax, 4), %ecx
    addl %ecx, contor

    incl lext
    movl lext, %eax
    mull new_n
    addl cext, %eax
    movl (%esi, %eax, 4), %ecx
    addl %ecx, contor

    decl cext
    movl lext, %eax
    mull new_n
    addl cext, %eax
    movl (%esi, %eax, 4), %ecx
    addl %ecx, contor

    decl cext
    movl lext, %eax
    mull new_n
    addl cext, %eax
    movl (%esi, %eax, 4), %ecx
    addl %ecx, contor

    decl lext
    decl lext

    movl lineIndex, %eax
    subl $1, %eax
    movl %eax, matriceL
    movl columnIndex, %eax
    subl $1, %eax
    movl %eax, matriceC

    movl matriceL, %eax
    mull n
    addl matriceC, %eax
    leal matrice, %edi
    movl (%edi, %eax, 4), %ecx
    cmp $1, %ecx
    je celula_vie
    jmp celula_moarta


celula_moarta:

    movl contor, %edx
    cmp $3, %edx
    je transformare_vie
    jmp cont_et_coloane

celula_vie:

    movl contor, %edx
    cmpl $2, %edx
    jl transformare_moarta

    movl contor, %edx
    cmpl $3, %edx
    jg transformare_moarta
    jmp cont_et_coloane

transformare_moarta:

movl lineIndex, %eax
subl $1, %eax
movl %eax, matriceL

movl columnIndex, %eax
subl $1, %eax
movl %eax, matriceC

    movl matriceL, %eax
    mull n
    addl matriceC, %eax
    movl $0, (%edi, %eax, 4)
    jmp cont_et_coloane

transformare_vie:

movl lineIndex, %eax
subl $1, %eax
movl %eax, matriceL

movl columnIndex, %eax
subl $1, %eax
movl %eax, matriceC

    movl matriceL, %eax
    mull n
    addl matriceC, %eax
    movl $1, (%edi, %eax, 4)
    jmp cont_et_coloane


cont_et_coloane:

    incl columnIndex
    movl $0, contor
    jmp et_coloane

cont_et_linii:

    incl lineIndex
    jmp et_linii

cont_et_extindere_matrice:

    incl numar_evolutie
    jmp et_extindere_matrice  

et_afis_matr:

    movl $0, lineIndex

for_lines:

    movl lineIndex, %ecx
    cmp %ecx, m
    je et_exit
    movl $0, columnIndex

for_columns:

    movl columnIndex, %ecx
    cmp %ecx, n
    je cont
    movl lineIndex, %eax
    mull n
    addl columnIndex, %eax
    lea matrice, %edi
    movl (%edi, %eax, 4), %ebx
    pushl %ebx
    pushl $formatPrintf
    call printf
    popl %ebx
    popl %ebx
    pushl $0
    call fflush
    popl %ebx
    incl columnIndex
    jmp for_columns

cont:
movl $4, %eax
movl $1, %ebx
movl $newLine, %ecx
movl $2, %edx
int $0x80
incl lineIndex
jmp for_lines

et_exit:
    mov $1, %eax
    xor %ebx, %ebx
    int $0x80
