from cProfile import label
from time import sleep
from turtle import goto

Grabado_Al={
    'Broca':'De 60 o 90 grados',
    'Profundidad': 'De 0.01mm si las dimensiones del grabado son pequeñas o de 0.025mm para dimensiones algo mayores y dar varias pasadas (max. 3)',
    'Parametros':'Elegir en el create broca para aluminio de 1/8"(la #102 no #102z) y dejar los parametros preestablecidos',
}

Retiro_Al={
    'Broca':'De 1/8" o  0.125" de diametro con 2 flutes',
    'Profundidad': """Primero pasar 0.01mm 2 veces,luego pasadas de 0.01 hasta llegar al 0.04.
    Despues pasar de 0.04 al 0.2 con pasadas de 0.04.
    Finalmente hacer pasadas de 0.1 hasta terminar la operacion.
    En todo momento retirar las virutas y refrigerar la maquina.""",
    'Parametros':'Elegir en el create broca para aluminio de 1/8"(la #102 no #102z) y dejar los parametros preestablecidos',
}

Retiro_Wood={
    'Broca':'Usar brocas de 1/8" para adelante es correcto, ya que la madera brinda mayor libertas',
    "Profundidad":"""Primero dar pasadas pequeñas de 0.1 especialmente si se usan brocas de 1/8
    ,mas si se usan brocas mas grandes las pasadas pueden ser de mayores dimensiones que 0.25.
    Buscar mas informacion en Internet""",
    'Parametros':'Elegir el tipo de madera en el Create y trabajar con esos parametros',
}

def Info():
    print("""Que informacion desea
    [1] Brocas
    [2] Profundidad
    [3] Parametros(Feedrate, RPM, etc)
    [4] Toda""")
    desi = int(input('Elija una opcion:'))
    return desi


def Operacion():
    conforme = False
    print("""Bienvenido Operario 
    
    Que operacion desea realizar
    [1] Grabado-Aluminio
    [2] Retiro de material-Alumnio
    [3] Retiro de material-Madera""")
    desicion = int(input("Elija el numero correspondiente a su operacion: "))
    if (desicion==1):
        while(conforme==False):
            desi = Info()
            if (desi==1):
                print (Grabado_Al['Broca'])
            elif (desi==2):
                print (Grabado_Al['Profundidad'])
            elif (desi==3):
                print (Grabado_Al['Parametros'])
            elif (desi==4):
                print (Grabado_Al['Broca'])
                print("")
                sleep(1)
                print (Grabado_Al['Profundidad'])
                print("")
                sleep(1)
                print (Grabado_Al['Parametros'])
            else:
                print("Elige bien mrd")
            conforme = bool(int(input("Pon 1 si estas conforme pon 0 si no lo estas: ")))

    elif (desicion==2):
        while(conforme==False):
            desi = Info()
            if (desi==1):
                print (Retiro_Al['Broca'])
            elif (desi==2):
                print (Retiro_Al['Profundidad'])
            elif (desi==3):
                print (Retiro_Al['Parametros'])
            elif (desi==4):
                print (Retiro_Al['Broca'])
                print("")
                sleep(1)
                print (Retiro_Al['Profundidad'])
                print("")
                sleep(1)
                print (Retiro_Al['Parametros'])
            else:
                print("Elige bien mrd")
            conforme = bool(int(input("Pon 1 si estas conforme pon 0 si no lo estas: ")))

    elif (desicion==3):
        while(conforme==False):
            desi = Info()
            if (desi==1):
                print (Retiro_Wood['Broca'])
            elif (desi==2):
                print (Retiro_Wood['Profundidad'])
            elif (desi==3):
                print (Retiro_Wood['Parametros'])
            elif (desi==4):
                print (Retiro_Wood['Broca'])
                print("")
                sleep(1)
                print (Retiro_Wood['Profundidad'])
                print("")
                sleep(1)
                print (Retiro_Wood['Parametros'])
            else:
                print("Elige bien mrd")
            conforme = bool(int(input("Pon 1 si estas conforme pon 0 si no lo estas: ")))
            
    else:
        print("Escoja una de las opciones")
    
    
        

def run():
    Operacion()
    fin = False
    while (fin==False):
        Para = input('¿Cambiaste los parametros? (Pon Y o N): ')
        if (Para == 'Y'):
            N_flutes= int(input("Seleccione el numero de flutes: "))
            Feed_rate= int(input("Seleccione el feed rate: "))
            RPM= int(input("Seleccione los RPM: "))
            Chipload = (Feed_rate/(N_flutes*RPM))
            if Chipload >= 0.013 and Chipload <= 0.025:
                print("""Configuracion correcta
                Feliz operacion""")
                fin = True
            else:
                print('Configuracion incorrecta coloca otros valores')
        elif (Para=='N'):
            print('Feliz operacion')
            fin = True
    sleep(3)
        

if __name__=='__main__':
    run()
