     .data

menosuno: .float -1.0
n: .float 0.0
uno: .float 1.0
dos: .float 2.0

    .global tang
    .global sen
    .global cos

    .text

tang:

    movss %xmm0, %xmm2  # xmm2 = xmm0

    xor %rax, %rax
    leaq n(%rip), %rax
    movss (%rax), %xmm1

    xor %rax, %rax
    leaq menosuno(%rip), %rax
    movss (%rax), %xmm3  # xmm3 = -1.0

    xor %rax, %rax
    leaq menosuno(%rip), %rax
    movss (%rax),%xmm4    # xmm4 = -1.0 

    xor %rax, %rax
    leaq n(%rip), %rax
    movss (%rax),%xmm5    # xmm5 = 0.0 

sen:
    xor %rax, %rax
    leaq menosuno(%rip), %rax
    mulss (%rax), %xmm4 # multiplicamos -1 * -1 y lo almacenamos en xmm4
    xor %rax, %rax
    leaq uno(%rip), %rax
    addss (%rax), %xmm3
    
    ucomiss %xmm5,%xmm3     # Comparamos if(xmm0 == xmm4)
    jb sen                  #else{ volver a la etiqueta sen }

    xor %rax, %rax
    leaq dos(%rip), %rax
    movss (%rax), %xmm6    # movemos 2 al registro xmm6; xmm6 = 2.0 
    mulss %xmm5, %xmm6  # multiplicamos el valor en xmm5 el cual es equivalente al valor n xmm5 = n y multiplicamos xmm6 el cual es 2 entonces: xmm6 = 2 * n
    xor %rax, %rax
    leaq uno(%rip), %rax
    addss (%rax), %xmm6    # luego sumamos 1 siendo: xmm6 = xmm6 + 1
    
    xor %rax, %rax
    leaq uno(%rip), %rax
    movss (%rax), %xmm3 # xmm3 = 0.0

    ucomiss %xmm6, %xmm3    # Comparamos if(xmm6 == xmm3)
    je finexponentesen         # else{ vuelve a la etiqueta denominadorsen }

exponentesen:
    mulss %xmm0, %xmm2  # Multiplicamos el valor de xmm0 por xmm2 es igual a x: xmm2 = xmm0 * xmm2
    xor %rax, %rax
    leaq uno(%rip), %rax
    addss (%rax), %xmm3    # Sumamos 1 al contador

    ucomiss %xmm6, %xmm3    # Comparamos if(xmm6 >= xmm3)
    jb exponentesen         # else{ vuelve a la etiqueta denominadorsen }

finexponentesen:
    xor %rax, %rax
    leaq n(%rip), %rax
    movss (%rax), %xmm3      # xmm3 = 0.0
    xor %rax, %rax
    leaq uno(%rip), %rax
    movss (%rax), %xmm7    # xmm7 = 1.0 

denominadorsen:
    xor %rax, %rax
    leaq uno(%rip), %rax
    addss (%rax), %xmm3    # xmm3 = xmm3 + 1
    mulss %xmm3, %xmm7  # xmm7 = xmm3 * xmm7

    ucomiss %xmm6,%xmm3 # Comparamos if(xmm6 >= xmm3)
    jb denominadorsen   # else{ vuelve a la etiqueta denominadorsen }

    divss %xmm7, %xmm2  # dividimos valor de: xmm2 = (x^(2n+1))/(2n+1)!
    mulss %xmm4, %xmm2  # multiplicamos xmm4 = (-1)^n por xmm2: xmm2 = xmm2 * xmm4

    addss %xmm2, %xmm1  # hacemos suma total entre xmm1 y xmm2: xmm1 = xmm1 + xmm2
    
    xor %rax, %rax
    leaq menosuno(%rip), %rax
    movss (%rax), %xmm3  # xmm3 = -1.0
    movss %xmm0, %xmm2     # xmm2 = xmm0

    xor %rax, %rax
    leaq uno(%rip), %rax
    addss (%rax), %xmm5    # le sumamos 1 al contador total n: xmm5 = xmm5 + 1

    xor %rax, %rax
    leaq menosuno(%rip), %rax
    movss (%rax), %xmm4 # xmm4 = -1.0

    ucomiss %xmm0, %xmm5    # Comparamos if(xmm0 >= xmm5)
    jb sen                  # else{ vuelve a la etiqueta sen }

cosinicio:
    xor %rax, %rax
    leaq menosuno(%rip), %rax
    movss (%rax), %xmm3  # xmm3 = -1.0
    xor %rax, %rax
    leaq menosuno(%rip), %rax
    movss (%rax),%xmm4    # xmm4 = -1.0 
    xor %rax, %rax
    leaq n(%rip), %rax
    movss (%rax),%xmm5    # xmm5 = 0.0

    xor %rax, %rax
    leaq uno(%rip), %rax
    movss (%rax), %xmm2   # Iniciamos a xmm2 en 0

cos:
    xor %rax, %rax
    leaq menosuno(%rip), %rax
    mulss (%rax), %xmm4 # multiplicamos -1 * -1 y lo almacenamos en xmm4
    xor %rax, %rax
    leaq uno(%rip), %rax
    addss (%rax), %xmm3      # Contador para comparar con  el xmm5: xmm3 = xmm3 + 1.0
    
    ucomiss %xmm5,%xmm3     # Comparamos if(xmm5 > xmm3)
    jb cos

    xor %rax, %rax
    leaq dos(%rip), %rax
    movss (%rax), %xmm6    # movemos 2 al registro xmm6; xmm6 = 2.0 
    mulss %xmm5, %xmm6  # multiplicamos el valor en xmm5 el cual es equivalente al valor n xmm5 = n y multiplicamos xmm6 el cual es 2 entonces: xmm6 = 2 * n

    xor %rax, %rax
    leaq n(%rip), %rax
    ucomiss (%rax), %xmm6    # Comparamos if(xmm6 == n): 0 < n < x 
    je finexponentecos         # else{ vuelve a la etiqueta denominadorsen }

    xor %rax, %rax
    leaq uno(%rip), %rax
    movss (%rax), %xmm7    # Lo volvemos uno para poder operar la multiplicacion entre el xmm4 y x^2n
    xor %rax, %rax
    leaq n(%rip), %rax
    movss (%rax), %xmm3      # Volvemos a 0 el contador

exponentecos:
    mulss %xmm0, %xmm7  # Multiplicamos el valor de xmm0 por xmm7 es igual a x: xmm2 = xmm0 * xmm7
    xor %rax, %rax
    leaq uno(%rip), %rax
    addss (%rax), %xmm3    # Sumamos 1 al contador

    ucomiss %xmm6, %xmm3    # Comparamos if(xmm6 >= xmm3)
    jb exponentecos         # else{ vuelve a la etiqueta denominadorcos }

    mulss %xmm7,%xmm4   # El valor xmm4 = (-1)^n * xmm7 = x y se almacena en xmm4

    xor %rax, %rax
    leaq n(%rip), %rax
    movss (%rax), %xmm3      # xmm3 lo volvemos a 0
    xor %rax, %rax
    leaq uno(%rip), %rax
    movss (%rax), %xmm7    # xmm7 = 1.0 

    je denominadorcos   # Salto a la etiqueta denominadorcos

finexponentecos:
    xor %rax, %rax
    leaq uno(%rip), %rax
    movss (%rax), %xmm4    # Movemos el uno al xmm4 
    xor %rax, %rax
    leaq n(%rip), %rax
    movss (%rax), %xmm3      # Reiniciamos el contador
    xor %rax, %rax
    leaq uno(%rip), %rax
    movss (%rax), %xmm7    # xmm7 = 1.0 

    ucomiss n, %xmm6    # Comparamos if(xmm6 == n): 0 < n < x 
    je divisioncos      # else{ salto a la etiquita divisioncos }

denominadorcos:
    xor %rax, %rax
    leaq uno(%rip), %rax
    addss (%rax), %xmm3    # xmm3 = xmm3 + 1
    mulss %xmm3, %xmm7  # xmm7 = xmm3 * xmm7

    ucomiss %xmm6,%xmm3 # Comparamos if(xmm6 >= xmm3)
    jb denominadorcos   # else{ vuelve a la etiqueta denominadorcos }

divisioncos:
    divss %xmm7, %xmm4 # dividimos valor de: xmm4 = (x^(2n+1))/(2n+1)!

    addss %xmm4, %xmm2  # hacemos suma total entre xmm4 y xmm2: xmm2 = xmm2 + xmm4
    
    xor %rax, %rax
    leaq menosuno(%rip), %rax
    movss (%rax), %xmm3  # xmm3 = -1.0
    movss %xmm0, %xmm4     # xmm4 = xmm0

    xor %rax, %rax
    leaq uno(%rip), %rax
    addss (%rax), %xmm5    # le sumamos 1 al contador total n: xmm5 = xmm5 + 1

    xor %rax, %rax
    leaq menosuno(%rip), %rax

    movss (%rax), %xmm4 # xmm4 = -1.0

    ucomiss %xmm0, %xmm5    # Comparamos if(xmm0 >= xmm5)
    jb cos                  # else{ vuelve a la etiqueta cos }
    
tanres:
    divss %xmm2, %xmm1      # Hacemos la division entre el seno y el coseno: xmm1 = sin(x), xmm2 = cos(X): xmm1 = xmm1/xmm2
    movss %xmm1, %xmm0      # xmm0 = xmm1
    
fin:
    ret
    

