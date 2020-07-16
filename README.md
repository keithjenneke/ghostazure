# Deploy Single Tier GHOST Blog on Linux and Azure Bastion Host
This template deploys a single tier Ghost Blog and all necessary infrastrucrture components. When deployed, the resulting resource group will contain an initial secure instance of GHOST which is accessible via the Azure public DNS name of the VM. The Azure Bastion Host Service must be used to connect to the VM for administrative purposes.

[![Deploy to Azure](https://azuredeploy.net/deploybutton.png)](https://azuredeploy.net/)

The architecture is similar to this:

![Single Tier Ghost Blog on Linux and Azure Bastion Host](https://user-images.githubusercontent.com/35787200/87607435-afd49380-c740-11ea-83a5-092d43a9fc6f.png)

# Next Steps
This is a starter template and is designed to make it easy to deploy Ghost and all required components including NGINX and MYSQL on a single VM. Once deployed it is recommended that you register an CNAME record in your DNS Zone and run ghost setup ssl to configure HTTPS before your begin customising your ghost install and publishing content.

# References 
1. https://ghost.org/docs/install/ubuntu/#install-ghost