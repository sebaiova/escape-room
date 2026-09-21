#include <stdio.h>
#include <string.h>

int main()
{
    const char* key = "IC2026";
    char input[24];

    printf("La puerta esta cerrada.\n");
    printf("Ingrese la clave: ");

    scanf("%23s", input);

    if(strcmp(key, input) )
    {
        printf("ACCESO DENEGADO.\n");
    }

    else 
    {
        printf("ACCESO PERMITIDO.\n");
        printf("¡Felicitaciones! Lograste escapar.\n");
    }

    return 0;
}