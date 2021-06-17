    .data

menosuno: .float -1.0
n: .float 0.0
uno: .float 1.0
dos: .float 2.0

    .global tan
    .global sen
    .global cos

    .text

tan:

    movss %xmm0, %xmm2  # xmm2 = xmm0

    movss n, %xmm1

    movss menosuno, %xmm3  # xmm3 = -1.0

    movss menosuno,%xmm4    # xmm4 = -1.0 

    movss n,%xmm5    # xmm5 = 0.0 

sen:
    mulss menosuno, %xmm4 # multiplicamos -1 * -1 y lo almacenamos en xmm4
    addss uno, %xmm3
    
    ucomiss %xmm5,%xmm3     # Comparamos if(xmm0 == xmm4)
    jb sen                  #else{ volver a la etiqueta sen }

    movss dos, %xmm6    # movemos 2 al registro xmm6; xmm6 = 2.0 
    mulss %xmm5, %xmm6  # multiplicamos el valor en xmm5 el cual es equivalente al valor n xmm5 = n y multiplicamos xmm6 el cual es 2 entonces: xmm6 = 2 * n
    addss uno, %xmm6    # luego sumamos 1 siendo: xmm6 = xmm6 + 1
    
    movss uno, %xmm3 # xmm3 = 0.0

    ucomiss %xmm6, %xmm3    # Comparamos if(xmm6 == xmm3)
    je finexponentesen         # else{ vuelve a la etiqueta denominadorsen }

exponentesen:
    mulss %xmm0, %xmm2  # Multiplicamos el valor de xmm0 por xmm2 es igual a x: xmm2 = xmm0 * xmm2
    addss uno, %xmm3    # Sumamos 1 al contador

    ucomiss %xmm6, %xmm3    # Comparamos if(xmm6 >= xmm3)
    jb exponentesen         # else{ vuelve a la etiqueta denominadorsen }

finexponentesen:
    movss n, %xmm3      # xmm3 = 0.0
    movss uno, %xmm7    # xmm7 = 1.0 

denominadorsen:
    addss uno, %xmm3    # xmm3 = xmm3 + 1
    mulss %xmm3, %xmm7  # xmm7 = xmm3 * xmm7

    ucomiss %xmm6,%xmm3 # Comparamos if(xmm6 >= xmm3)
    jb denominadorsen   # else{ vuelve a la etiqueta denominadorsen }

    divss %xmm7, %xmm2  # dividimos valor de: xmm2 = (x^(2n+1))/(2n+1)!
    mulss %xmm4, %xmm2  # multiplicamos xmm4 = (-1)^n por xmm2: xmm2 = xmm2 * xmm4

    addss %xmm2, %xmm1  # hacemos suma total entre xmm1 y xmm2: xmm1 = xmm1 + xmm2
    
    movss menosuno, %xmm3  # xmm3 = -1.0
    movss %xmm0, %xmm2     # xmm2 = xmm0

    addss uno, %xmm5    # le sumamos 1 al contador total n: xmm5 = xmm5 + 1

    movss menosuno, %xmm4 # xmm4 = -1.0

    ucomiss %xmm0, %xmm5    # Comparamos if(xmm0 >= xmm5)
    jb sen                  # else{ vuelve a la etiqueta sen }
cosinicio:
    movss menosuno, %xmm3  # xmm3 = -1.0
    movss menosuno,%xmm4    # xmm4 = -1.0 
    movss n,%xmm5    # xmm5 = 0.0

    movss n, %xmm2
cos:
    mulss menosuno, %xmm4 # multiplicamos -1 * -1 y lo almacenamos en xmm4
    addss uno, %xmm3
    
    ucomiss %xmm5,%xmm3     # Comparamos if(xmm5 > xmm3)
    jb cos

    movss dos, %xmm6    # movemos 2 al registro xmm6; xmm6 = 2.0 
    mulss %xmm5, %xmm6  # multiplicamos el valor en xmm5 el cual es equivalente al valor n xmm5 = n y multiplicamos xmm6 el cual es 2 entonces: xmm6 = 2 * n

    ucomiss n, %xmm6    # Comparamos if(xmm6 >= xmm3)
    je finexponentecos         # else{ vuelve a la etiqueta denominadorsen }

    movss uno, %xmm7
    movss n, %xmm3

exponentecos:
    mulss %xmm0, %xmm7  # Multiplicamos el valor de xmm0 por xmm2 es igual a x: xmm2 = xmm0 * xmm2
    addss uno, %xmm3    # Sumamos 1 al contador

    ucomiss %xmm6, %xmm3    # Comparamos if(xmm6 >= xmm3)
    jb exponentecos         # else{ vuelve a la etiqueta denominadorsen }

    mulss %xmm7,%xmm4 # el valor xmm4 = (-1)^n * xmm7 = x y se almacena en xmm4

    movss n, %xmm3
    movss uno, %xmm7    # xmm7 = 1.0 

    je denominadorcos

finexponentecos:
    movss uno, %xmm4
    movss n, %xmm3
    movss uno, %xmm7    # xmm7 = 1.0 

    ucomiss n, %xmm6
    je divisioncos

denominadorcos:
    addss uno, %xmm3    # xmm3 = xmm3 + 1
    mulss %xmm3, %xmm7  # xmm7 = xmm3 * xmm7

    ucomiss %xmm6,%xmm3 # Comparamos if(xmm6 >= xmm3)
    jb denominadorcos   # else{ vuelve a la etiqueta denominadorsen }

divisioncos:
    divss %xmm7, %xmm4 # dividimos valor de: xmm4 = (x^(2n+1))/(2n+1)!

    addss %xmm4, %xmm2  # hacemos suma total entre xmm1 y xmm2: xmm1 = xmm1 + xmm2
    
    movss menosuno, %xmm3  # xmm3 = -1.0
    movss %xmm0, %xmm4     # xmm2 = xmm0

    addss uno, %xmm5    # le sumamos 1 al contador total n: xmm5 = xmm5 + 1

    movss menosuno, %xmm4 # xmm4 = -1.0

    ucomiss %xmm0, %xmm5    # Comparamos if(xmm0 >= xmm5)
    jb cos                  # else{ vuelve a la etiqueta sen }
    
tanres:
    divss %xmm2, %xmm1
    movss %xmm1, %xmm0
    
fin:
    ret
    

