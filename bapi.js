



module.exports = function(RED) {
    
var sapnwrfc = require('sapnwrfc');


   function BapiNode(config) {
	

	
	var connectionParams = {
	  ashost: config.ip,
	  sysid: config.env,
	  sysnr: "00",
	  user: config.user,
	  passwd: config.pwd,
	  client: config.mandant
	};

	
	

        RED.nodes.createNode(this,config);

        var node = this;
	
        this.on('input', function(msg) {
			// Récupération connexion si déjà créée		
			try {		
				var con = msg.con( );
			}
			catch (e) {			  
			   //console.log(e); 
			}			

			if ( con === undefined || con === null)
			{

				var con = new sapnwrfc.Connection;
		 	        con.Open(connectionParams, function(err) {
		    		if (err) {      			
		      		   node.error(err.message);
		    		}			 	
				    var func = con.Lookup(config.bapi);
				   
				    func.Invoke(msg.payload, function(err, result) {
				      if (err) {
					 node.error(err.message);
				      }
				      else {	       			      
				      	msg.con = function() {
						return con;
				      	}
					console.log(result);
					msg.payload = result;
		                      }
				      node.send(msg);
				    });
				  });
			}
			else {
				
				var func = con.Lookup(config.bapi);
				   
				    func.Invoke(msg.payload, function(err, result) {
				      if (err) {
					 node.error(err.message);
				      }
				      else {	       			      
				      	msg.con = function() {
						return con;
				      	}
					console.log(result);
					msg.payload = result;
		                      }
				      node.send(msg);
				  });
				 
			}
		
        });
    }
    RED.nodes.registerType("BAPI",BapiNode);
}
