[33mcommit e0f3722568633b60566b1d9a1cec59a5304ab1a6[m[33m ([m[1;36mHEAD[m[33m -> [m[1;32mmain[m[33m, [m[1;31morigin/main[m[33m, [m[1;31morigin/HEAD[m[33m)[m
Author: Juan José Zapata Cadavid <juazapataca@unal.edu.co>
Date:   Thu Jan 11 09:28:29 2024 -0500

    Agregamos curso Git

[1mdiff --git a/7. Git y GitHub.md b/7. Git y GitHub.md[m
[1mnew file mode 100644[m
[1mindex 0000000..b6ca99b[m
[1m--- /dev/null[m
[1m+++ b/7. Git y GitHub.md[m	
[36m@@ -0,0 +1,121 @@[m
[32m+[m[32m# Git y GitHub[m
[32m+[m
[32m+[m[32mGit es un sistema de control de versiones ideal para guardar código, en donde solamente guarda los cambios que se realizaron, quien lo hizo y en qué parte del archivo. Git fue creado por Linux Torvald[m
[32m+[m
[32m+[m[32m## Comandos[m
[32m+[m
[32m+[m[32m### Windows[m
[32m+[m
[32m+[m[41m    [m
[32m+[m[32m- **Carpeta actual**[m
[32m+[m[32m    ```console[m
[32m+[m[32m    pwd[m
[32m+[m[32m    ```[m[41m    [m
[32m+[m[32m- **Cambiar directorio**[m
[32m+[m[32m    ```console[m
[32m+[m[32m    cd \ # Ir al home del SO[m
[32m+[m[32m    cd ruta[m
[32m+[m[32m    ```[m[41m    [m
[32m+[m[32m- **Crear carpeta**[m
[32m+[m[32m    ```console[m
[32m+[m[32m    mkdir nombre_carpeta[m
[32m+[m[32m    ```[m[41m    [m
[32m+[m[32m- **Mostrar archivos de la carpeta actual**[m
[32m+[m[32m    ```console[m
[32m+[m[32m    dir[m
[32m+[m[32m    ```[m[41m    [m
[32m+[m[32m- **Crear archivo**[m
[32m+[m[32m    ```console[m
[32m+[m[32m    touch nombre_archivo[m
[32m+[m[32m    ```[m[41m    [m
[32m+[m[32m- **Mostrar texto plano del archivo**[m
[32m+[m[32m    ```console[m
[32m+[m[32m    cat nombre_archivo[m
[32m+[m[32m    ```[m[41m    [m
[32m+[m[32m- **Eliminar archivo**[m
[32m+[m[32m    ```console[m
[32m+[m[32m    rm nombre_archivo[m
[32m+[m[32m    ```[m[41m    [m
[32m+[m[32m- ****[m
[32m+[m[32m    ```console[m
[32m+[m[41m    [m
[32m+[m[32m    ```[m[41m    [m
[32m+[m[32m- ****[m
[32m+[m[32m    ```console[m
[32m+[m[41m    [m
[32m+[m[32m    ```[m[41m    [m
[32m+[m[32m- ****[m
[32m+[m[32m    ```console[m
[32m+[m[41m    [m
[32m+[m[32m    ```[m
[32m+[m[32m### Git[m
[32m+[m
[32m+[m[32m- **Crear repositorio**[m
[32m+[m[32m    ```console[m
[32m+[m[32m    git init[m
[32m+[m[32m    ```[m
[32m+[m[32m- **Agregar archivo al repositorio**[m
[32m+[m[32m    ```console[m
[32m+[m[32m    git add nombre_archivo[m
[32m+[m[41m    [m
[32m+[m[32m    # Agregar todos los archivos que han cambiado[m
[32m+[m[32m    git add .[m[41m [m
[32m+[m[32m    ```[m
[32m+[m[32m- **Envía los cambios del archivo al sistema de versiones**[m
[32m+[m[32m    ```console[m
[32m+[m[32m    git commit -m "nombre_version"[m
[32m+[m[32m    ```[m
[32m+[m[32m- **Mostrar estado del repositorio**[m
[32m+[m[32m    ```console[m
[32m+[m[32m    git[m
[32m+[m[32m    ```[m[41m    [m
[32m+[m[32m- **Mostrar cambios históricos**[m
[32m+[m[32m    ```console[m
[32m+[m[32m    git show[m
[32m+[m[32m    ```[m[41m    [m
[32m+[m[32m- **Mostrar historia de un archivo**[m
[32m+[m[32m    ```console[m
[32m+[m[32m    git log nombre_archivo[m
[32m+[m[32m    ```[m[41m    [m
[32m+[m[32m- **Enviar a un repositorio**[m
[32m+[m[32m    ```console[m
[32m+[m[32m    git push[m
[32m+[m[32m    ```[m[41m    [m
[32m+[m[32m- **Traer desde un repositorio**[m
[32m+[m[32m    ```console[m
[32m+[m[32m    git pull[m
[32m+[m[32m    ```[m[41m    [m
[32m+[m[32m- **Eliminar un archivo al que no se le ha hecho un commit**[m
[32m+[m[32m    ```console[m
[32m+[m[32m    git rm --cached nombre_archivo[m
[32m+[m[32m    ```[m[41m    [m
[32m+[m[32m- **Configurar git**[m
[32m+[m[32m    ```console[m
[32m+[m[32m    # Mostrar lista de cuales son los parametros[m
[32m+[m[32m    git config[m[41m [m
[32m+[m
[32m+[m[32m    # Mostrar configuración por defecto[m
[32m+[m[32m    git config --list[m
[32m+[m
[32m+[m
[32m+[m[32m    ```[m[41m    [m
[32m+[m[32m- ****[m
[32m+[m[32m    ```console[m
[32m+[m[32m    git[m
[32m+[m[32m    ```[m[41m    [m
[32m+[m[32m- ****[m
[32m+[m[32m    ```console[m
[32m+[m[32m    git[m
[32m+[m[32m    ```[m[41m    [m
[32m+[m[32m- ****[m
[32m+[m[32m    ```console[m
[32m+[m[32m    git[m
[32m+[m[32m    ```[m[41m    [m
[32m+[m[32m- ****[m
[32m+[m[32m    ```console[m
[32m+[m[32m    git[m
[32m+[m[32m    ```[m[41m    [m
[32m+[m[32m- ****[m
[32m+[m[32m    ```console[m
[32m+[m[32m    git[m
[32m+[m[32m    ```[m
\ No newline at end of file[m
