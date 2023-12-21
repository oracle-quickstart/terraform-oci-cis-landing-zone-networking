<!-- BEGIN_TF_DOCS -->
# OKE Flannel networking architecture - topology provisioning 

## Description

This is an example for a Flannel CNI with Private API Endpoint, Private Worker Nodes and Public Load Balancers instantiation of the ```terraform-oci-cis-landing-zone-networking``` networking core module.

It is designed to use NSGS instead of Security Lists.

For detailed description of the ```terraform-oci-cis-landing-zone-networking``` networking core module please refer to the core module specific [README.md](../../README.md) and [SPEC.md](../../SPEC.md).

This example is leveraging the fully dynamic characteristics of the complex networking module input to describe the following networking topology:

- networking construct provisioned on a single compartment
- single networking category defined
- the category will contain one single VCN (10.0.0.0/16)
- the VCN will contain the following:
    - Four security lists:
        - an api endpoint security list allowing ingress for ICMP (Path Discovery).
        - a workers security list allowing ingress for ICMP (Path Discovery).
        - an operator security list allowing ingress for ICMP (Path Discovery).
        - a services security list allowing ingress for ICMP (Path Discovery).
    - Three gateways:
        - One Internet Gateway
        - One NAT Gateway
        - One Service Gateway
    - Four route tables:
        - ```rt-services``` defines a route to the Internet Gateway
        - ```rt-api``` defines two routes:
            - a route to the NAT GW;
            - a route to the Service GW;
        - ```rt-workers``` defines two routes:
            - a route to the NAT GW;
            - a route to the Service GW;
        - ```rt-operator``` defines two routes:
            - a route to the NAT GW;
            - a route to the Service GW;                        
    - Four Network Security Groups (NSGs)
        - ```nsg-api```
        - ```nsg-operator``` 
        - ```nsg-workers``` 
        - ```nsg-services```
    - all NSGs contain the rules to allow a Kubernetes Cluster with Flannel CNI to run correctly.
    - Four subnets:
        - ```sub-api``` (10.0.0.0/30) for the api endpoint. This subnet will be using the ```rt-api``` route table, default VCN DHCP options and the api security list.
        -  ```sub-workers``` (10.0.1.0/24) for the application tier. This subnet will be using the ```rt-workers``` route table, default VCN DHCP options and the workers security list.
        - ```sub-services``` (10.0.2.0/24) for the database tier. This subnet will be using the ```rt-services``` route table, default VCN DHCP options and the services security list.
        - ```sub-operator``` (10.0.3.0/30) for the database tier. This subnet will be using the ```rt-operator``` route table, default VCN DHCP options and the operator security list.



__NOTE:__ Please note that the entire configuration is a single complex input parameter and you're able to edit it and change the resources names and any of their configuration (like VCN and subnet CIDR blocks, dns labels...) and, also, you're able to change the input configuration topology/structure like adding more categories, more VCNs inside a category, more subnets inside a VCN or inject new resources into existing VCNs and this will reflect into the topology that terraform will provision.


## Instantiation

For clarity and proper separation and isolation we've separated the input parameters into 2 files by leveraging terraform ```*.auto.tfvars``` feature:

- [terraform.tfvars](./terraform.tfvars.template)


- [network_configuration.auto.tfvars](./network_configuration.auto.tfvars)

