
FROM mhart/alpine-node:4

# Home directory for Node-RED application source code.
RUN mkdir -p /usr/src/node-red

# User data directory, contains flows, config and nodes.
RUN mkdir /data

WORKDIR /usr/src/node-red

# Add node-red user so we aren't running as root.
RUN adduser -h /usr/src/node-red -D -H node-red \
    && chown -R node-red:node-red /data \
    && chown -R node-red:node-red /usr/src/node-red \
    && chown -R node-red:node-red /usr/include \
    && chown -R node-red:node-red /usr/lib 

USER node-red

# package.json contains Node-RED NPM module and node dependencies
COPY package.json /usr/src/node-red/
RUN npm install

# User configuration directory volume
VOLUME ["/data"]
EXPOSE 1880

# Environment variable holding file path for flows configuration
ENV FLOWS=flows.json

# User configuration directory volume
VOLUME ["/data"] 
EXPOSE 1880:1880
EXPOSE 3000:3000
#EXPOSE 3001:3001
# Environment variable holding file path for flows configuration 
ENV FLOWS=flows.json



#Récupération des fichiers SAP
RUN git clone https://github.com/sragneau/sapnwrfc.git
#Copie du sdk SAP 
RUN cd sapnwrfc ;chmod +x SAPCAR_721-20010450;./SAPCAR_721-20010450 -xvf *.SAR;cd nwrfcsdk; ls -l;cp ./lib/* /usr/lib;cp ./include/* /usr/include
RUN npm install sapnwrfc

CMD ["npm", "start", "--", "--userDir", "/data"]
