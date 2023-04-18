# 3.16 é a penultina versão antes do 'stable' que é o 3.17
FROM alpine:3.16

# Instala o nginx
RUN	apk update && apk upgrade && apk add --no-cache nginx

# Somente o https será possivel ter o acesso
EXPOSE 443

# Executa o nginx
CMD ["nginx", "-g", "daemon off;"]
