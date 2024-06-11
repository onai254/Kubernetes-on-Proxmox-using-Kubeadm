
   33  curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
   34  echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
   35  sudo apt-get update
   36  sudo apt-get install -y kubelet kubeadm kubectl
   37  kubeadm join 192.168.1.111:6443 --token y7pcoc.x7gxv0d6tgja8b16 --discovery-token-ca-cert-hash sha256:903e70fc56ccbb0db69c80d0882d3321c71667c082aaffc4448c198b7ecd2875
   38  sudo kubeadm join 192.168.1.111:6443 --token y7pcoc.x7gxv0d6tgja8b16 --discovery-token-ca-cert-hash sha256:903e70fc56ccbb0db69c80d0882d3321c71667c082aaffc4448c198b7ecd2875
   39  sudo sysctl -p
   40  sudo nano /etc/sysctl.conf
   41  sudo sysctl -p
   42  sudo sysctl restart
   43  sudo kubeadm join 192.168.1.111:6443 --token y7pcoc.x7gxv0d6tgja8b16 --discovery-token-ca-cert-hash sha256:903e70fc56ccbb0db69c80d0882d3321c71667c082aaffc4448c198b7ecd2875
   44  hostanamectl node02
   45  hostanamectl hostname node02
   46  hostnamectl hostname node02
   47  hostname
   48  sudo kubeadm join 192.168.1.111:6443 --token y7pcoc.x7gxv0d6tgja8b16 --discovery-token-ca-cert-hash sha256:903e70fc56ccbb0db69c80d0882d3321c71667c082aaffc4448c198b7ecd2875
   49  sudo kubeadm join 192.168.1.111:6443 --token y7pcoc.x7gxv0d6tgja8b16 --discovery-token-ca-cert-hash sha256:903e70fc56ccbb0db69c80d0882d3321c71667c082aaffc4448c198b7ecd2875 --ignore-preflight-errors
   50  clear
   51  sudo kubeadm join 192.168.1.111:6443 --token y7pcoc.x7gxv0d6tgja8b16 --discovery-token-ca-cert-hash sha256:903e70fc56ccbb0db69c80d0882d3321c71667c082aaffc4448c198b7ecd2875
   52  sudo kubeadm reset
   53  sudo kubeadm join 192.168.1.111:6443 --token y7pcoc.x7gxv0d6tgja8b16 --discovery-token-ca-cert-hash sha256:903e70fc56ccbb0db69c80d0882d3321c71667c082aaffc4448c198b7ecd2875
   54  reboot
   55  sudo reboot
   56  timedatectl
   57  timedatectl set-timezone Africa/Nairobi
   58  clear
   59  history