#!/bin/bash

echo ">>> Limpando ambiente antigo..."
rm -rf /publico /adm /ven /sec

# Remover usuários (ignora erro se não existirem)
for user in carlos maria joao debora sebastiana roberto josefina amanda rogerio; do
    userdel -r $user 2>/dev/null
done

# Remover grupos
for group in GRP_ADM GRP_VEN GRP_SEC; do
    groupdel $group 2>/dev/null
done

echo ">>> Criando diretórios..."
mkdir /publico /adm /ven /sec

echo ">>> Criando grupos..."
groupadd GRP_ADM
groupadd GRP_VEN
groupadd GRP_SEC

echo ">>> Criando usuários e adicionando aos grupos..."

# Função para criar usuário com senha criptografada
criar_usuario() {
    nome=$1
    grupo=$2
    useradd $nome -m -s /bin/bash -p $(openssl passwd -6 Senha123) -G $grupo
}

# GRP_ADM
criar_usuario carlos GRP_ADM
criar_usuario maria GRP_ADM
criar_usuario joao GRP_ADM

# GRP_VEN
criar_usuario debora GRP_VEN
criar_usuario sebastiana GRP_VEN
criar_usuario roberto GRP_VEN

# GRP_SEC
criar_usuario josefina GRP_SEC
criar_usuario amanda GRP_SEC
criar_usuario rogerio GRP_SEC

echo ">>> Definindo permissões de diretórios..."
chown root:GRP_ADM /adm
chown root:GRP_VEN /ven
chown root:GRP_SEC /sec

chmod 770 /adm
chmod 770 /ven
chmod 770 /sec
chmod 777 /publico

echo ">>> Script finalizado com sucesso!"
