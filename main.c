/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   main.c
 * Author: usuario
 *
 * Created on 13 de junio de 2021, 11:09 AM
 */

#include <stdio.h>
#include <stdlib.h>

float tan(float);

/*
 * 
 */
int main(int argc, char** argv) {
    float x = 5.0;
    printf("El valo de tan(%f) es igual a %f\n",x,tan(x));

    return (EXIT_SUCCESS);
}

