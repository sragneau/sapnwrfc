FROM mhart/alpine-node:4
WORKDIR /src
ADD . .

# If you have native dependencies, you'll need extra tools
# RUN apk add --no-cache make gcc g++ python

# If you need npm, don't use a base tag
# RUN npm install

EXPOSE 3000
#CMD ["node", "index.js"]
#FROM nodered/node-red-docker
#RUN npm install node-red-node-wordpos
 
# Home directory for Node-RED application source code. 
#RUN mkdir -p /usr/src/node-red
#WORKDIR /usr/src/node-red

# User configuration directory volume
#VOLUME ["/data"] 
#EXPOSE 1880:1880
#EXPOSE 3000:3000
#EXPOSE 3001:3001
# Environment variable holding file path for flows configuration 
#ENV FLOWS=flows.json



#Récupération des fichiers SAP
#RUN git clone https://github.com/sragneau/sapnwrfc.git
#Copie du sdk SAP 
#RUN cd sapnwrfc ;chmod +x SAPCAR_721-20010450;./SAPCAR_721-20010450 -xvf *.SAR;
#RUN cd nwrfcsdk; ls -l;cp ./lib/* /usr/lib;cp ./include/* /usr/include


#RUN npm install sapnwrfc
