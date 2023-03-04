"""
Documentação barra de status:
https://pypi.org/project/progress/


pip install progress     - Para usar a barra de progresso

"""
import time
import socket
import subprocess
import os
from progress.bar import Bar

print(
'''
----------------------------------------------------------------------------------------------
                         ██████╗ ██╗███╗   ██╗ ██████╗     ██╗██████╗ ███████╗
                         ██╔══██╗██║████╗  ██║██╔════╝     ██║██╔══██╗██╔════╝
                         ██████╔╝██║██╔██╗ ██║██║  ███╗    ██║██████╔╝███████╗
                         ██╔═══╝ ██║██║╚██╗██║██║   ██║    ██║██╔═══╝ ╚════██║
                         ██║     ██║██║ ╚████║╚██████╔╝    ██║██║     ███████║
                         ╚═╝     ╚═╝╚═╝  ╚═══╝ ╚═════╝     ╚═╝╚═╝     ╚══════╝                                                                              
-----------------------------------------------------------------------------------------------

I.P Address - Endereço de Protocolo de Internet
 É o número identificador de uma interface de rede / dispositivo. 
 Esse número é formado por 4 octetos.

   Exemplo: 192.168.20.120 - Um dispositivo qualquer em uma rede caseira
   
 1º Octeto - 192 
 2º Octeto - 168
 3º Octeto - 20
 4° Octeto - 120

 Nesse programa, pesquisaremos os IP's que estão conectados em nossa rede. 
 A pesquisa será feita através dos números que inserirmos. 
''')

p = input("\nPrimeiro Octeto: ")
s = input("Segundo Octeto: ")
t = input("Terceiro Octeto: ")
q = int(input(("Quarto Octeto / Limite de Range - Até Qual Número Será Pesquisado: ")))
print()
bar = Bar('Status', max=q)                                                   # Configuração da Barra de Status


with open(os.devnull, "wb") as limbo:
        for n in range(0, q):                                                # Range que será utilizado - Puxando da Variável "q"
            ip="{primeiro}.{segundo}.{terceiro}.{0}".format(n,terceiro = t,segundo = s,primeiro = p)
            result=subprocess.Popen(["ping", "-n", "1", "-w", "100", ip],    #Processo que realiza o Ping
                     stdout=limbo, stderr=limbo).wait() 
            time.sleep(.002)
            
            if result:
                pass
            else:
                print(" --",ip,socket.getnameinfo((ip,0), 0))                 #Printar o Ping
            bar.next()
        bar.finish()
input("\n\nPesquisa Finalizada - Aperte Qualquer Tecla para Fechar o Programa")
