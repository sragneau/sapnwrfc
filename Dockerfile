#Image de l'OS
FROM ubuntu

# Home directory for Node-RED application source code. 
RUN mkdir -p /usr/src/node-red
WORKDIR /usr/src/node-red

# package
RUN apt-get update
RUN apt-get install curl -y
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get install nodejs -y
RUN apt-get install build-essential -y
RUN apt-get install git -y
RUN apt-get install python-dev -y
RUN apt-get install nano -y

#node-red
RUN npm install -g node-red

# User configuration directory volume
VOLUME ["/data"] 
EXPOSE 1880
# Environment variable holding file path for flows configuration 
ENV FLOWS=flows.json

	
#Récupération des fichiers SAP
RUN git clone https://github.com/sragneau/sapnwrfc.git
#Copie du sdk SAP 
RUN cd sapnwrfc ;chmod +x SAPCAR_721-20010450;./SAPCAR_721-20010450 -xvf *.SAR;cd nwrfcsdk;cp ./lib/* /usr/lib;cp ./include/* /usr/include
RUN mkdir -p /$HOME/.node-red/nodes
RUN mkdir -p /$HOME/.node-red/nodes/icons

#Copie des noeuds spécifiques 
WORKDIR /usr/src/node-red
RUN cd sapnwrfc ;cp sap.png /$HOME/.node-red/nodes/icons;cp bapi.js /$HOME/.node-red/nodes/;cp bapi.html /$HOME/.node-red/nodes/


RUN npm install sapnwrfc

#CMD ["npm", "start", "--", "--userDir", "/data"]

