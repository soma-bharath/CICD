FROM ngix:latest
COPY index.html /usr/share/nginx/html
EXPOSE 80
CMD ["nginx","-g","demon off;"]
