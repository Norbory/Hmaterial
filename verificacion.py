from time import sleep


def run():
    N_flutes= int(input("Seleccione el numero de flutes: "))
    Feed_rate= int(input("Seleccione el feed rate: "))
    RPM= int(input("Seleccione los RPM: "))
    Chipload = (Feed_rate/(N_flutes*RPM))
    if Chipload >= 0.013 and Chipload <= 0.025:
        print("Configuracion correcta")
    else:
        print('Configuracion incorrecta coloca otros valores')
    sleep(2000)

if __name__=='__main__':
    run()
