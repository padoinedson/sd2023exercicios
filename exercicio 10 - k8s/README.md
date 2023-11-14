


# K8S

## ---- CRIAÇÃO DE UM CLUSTER REMOTO (AWS, GG, ...) ----



        pre-requisitos   
        - docker  
        - kubeadm  
        - kubelet  
        - kubectl  

 





# SOMENTE NA MÁQUINA QUE SERÁ O **CONTROL PLANE NODE**


#### Start 

        $ kubeadm init

            > 1 - gera uns comandos para executar no master <mkdir ... >  
            > 2 - gera um token para rodar nas slaves (nodes)  <kubeadm join ... >  


#### Status    
    $ kubectl cluster-info
    $ kubectl get nodes



 
- Verificar uso das portas  
    $ netstat -plnt  

- reserar o serviço  
    $ sudo kubeadm reset  





 

# SOMENTE NAS MÁQUINAS QUE SERÃO WORKERS

## Habilitar o kubelet


 









Ref:  
        https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#config