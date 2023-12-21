network_configuration = {
  default_compartment_id    = "<REPLACE-BY-COMPARTMENT-OCID>"
  default_freeform_tags     = {}
  default_enable_cis_checks = false

  network_configuration_categories = {
    production = {
      category_freeform_tags = {
        "vision-sub-environment" = "prod"
      }

      vcns = {
        OKE-VCN-KEY = {
          display_name                     = "vcn-oke"
          is_ipv6enabled                   = false
          is_oracle_gua_allocation_enabled = false
          cidr_blocks                      = ["10.0.0.0/16"],
          dns_label                        = "vcnoke"
          is_create_igw                    = false
          is_attach_drg                    = false
          block_nat_traffic                = false
          default-security-list = {

          }

          security_lists = {
            SECLIST-API-KEY = {
              display_name = "sl-api"

              egress_rules = []

              ingress_rules = [
                {
                  description = "Ingress ICMP for path discovery"
                  stateless   = false
                  protocol    = "ICMP"
                  src         = "0.0.0.0/0"
                  src_type    = "CIDR_BLOCK"
                  icmp_type   = 3
                  icmp_code   = 4
                }

              ]
            }
            SECLIST-WORKERS-KEY = {
              display_name = "sl-workers"

              egress_rules = []

              ingress_rules = [
                {
                  description = "Ingress ICMP for path discovery"
                  stateless   = false
                  protocol    = "ICMP"
                  src         = "0.0.0.0/0"
                  src_type    = "CIDR_BLOCK"
                  icmp_type   = 3
                  icmp_code   = 4
                }
              ]
            }
            SECLIST-PODS-KEY = {
              display_name = "sl-pods"

              egress_rules = []

              ingress_rules = [
                {
                  description = "Ingress ICMP for path discovery"
                  stateless   = false
                  protocol    = "ICMP"
                  src         = "0.0.0.0/0"
                  src_type    = "CIDR_BLOCK"
                  icmp_type   = 3
                  icmp_code   = 4
                }
              ]
            }

            SECLIST-SERVICES-KEY = {
              display_name = "sl-services"

              egress_rules = []

              ingress_rules = [
                {
                  description = "Ingress ICMP for path discovery"
                  stateless   = false
                  protocol    = "ICMP"
                  src         = "0.0.0.0/0"
                  src_type    = "CIDR_BLOCK"
                  icmp_type   = 3
                  icmp_code   = 4
                }
              ]
            }

            SECLIST-OPERATOR-KEY = {
              display_name = "sl-operator"

              egress_rules = []

              ingress_rules = [
                {
                  description = "Ingress ICMP for path discovery"
                  stateless   = false
                  protocol    = "ICMP"
                  src         = "0.0.0.0/0"
                  src_type    = "CIDR_BLOCK"
                  icmp_type   = 3
                  icmp_code   = 4
                }
              ]
            }
          }

          route_tables = {
            RT-API-KEY = {
              display_name = "rt-api"
              route_rules = {
                sgw-route = {
                  network_entity_key = "SGW-KEY"
                  description        = "Route for sgw"
                  destination        = "all-services"
                  destination_type   = "SERVICE_CIDR_BLOCK"
                }
                natgw-route = {
                  network_entity_key = "NATGW-KEY"
                  description        = "Route for internet access via NAT GW"
                  destination        = "0.0.0.0/0"
                  destination_type   = "CIDR_BLOCK"
                }
              }
            }
            RT-WORKERS-KEY = {
              display_name = "rt-workers"
              route_rules = {
                sgw-route = {
                  network_entity_key = "SGW-KEY"
                  description        = "Route for sgw"
                  destination        = "all-services"
                  destination_type   = "SERVICE_CIDR_BLOCK"
                },
                natgw-route = {
                  network_entity_key = "NATGW-KEY"
                  description        = "Route for internet access via NAT GW"
                  destination        = "0.0.0.0/0"
                  destination_type   = "CIDR_BLOCK"
                }
              }
            }
            RT-PODS-KEY = {
              display_name = "rt-pods"
              route_rules = {
                sgw-route = {
                  network_entity_key = "SGW-KEY"
                  description        = "Route for sgw"
                  destination        = "all-services"
                  destination_type   = "SERVICE_CIDR_BLOCK"
                },
                natgw-route = {
                  network_entity_key = "NATGW-KEY"
                  description        = "Route for internet access via NAT GW"
                  destination        = "0.0.0.0/0"
                  destination_type   = "CIDR_BLOCK"
                }
              }
            }
            RT-SERVICES-KEY = {
              display_name = "rt-services"
              route_rules = {
                igw-route = {
                  network_entity_key = "IGW-KEY"
                  description        = "Route for igw"
                  destination        = "0.0.0.0/0"
                  destination_type   = "CIDR_BLOCK"
                }
              }
            }
            RT-OPERATOR-KEY = {
              display_name = "rt-operator"
              route_rules = {
                sgw-route = {
                  network_entity_key = "SGW-KEY"
                  description        = "Route for sgw"
                  destination        = "all-services"
                  destination_type   = "SERVICE_CIDR_BLOCK"
                }
                natgw-route = {
                  network_entity_key = "NATGW-KEY"
                  description        = "Route for internet access via NAT GW"
                  destination        = "0.0.0.0/0"
                  destination_type   = "CIDR_BLOCK"
                }
              }
            }
          }

          subnets = {
            API-SUBNET-KEY = {
              cidr_block                 = "10.0.0.0/30"
              dhcp_options_key           = "default_dhcp_options"
              display_name               = "sub-api"
              dns_label                  = "apisub"
              ipv6cidr_blocks            = []
              prohibit_internet_ingress  = true
              prohibit_public_ip_on_vnic = true
              route_table_key            = "RT-API-KEY"
              security_list_keys         = ["SECLIST-API-KEY"]
            }
            WORKERS-SUBNET-KEY = {
              cidr_block                 = "10.0.1.0/24"
              dhcp_options_key           = "default_dhcp_options"
              display_name               = "sub-workers"
              dns_label                  = "workerssub"
              ipv6cidr_blocks            = []
              prohibit_internet_ingress  = true
              prohibit_public_ip_on_vnic = true
              route_table_key            = "RT-WORKERS-KEY"
              security_list_keys         = ["SECLIST-WORKERS-KEY"]
            }
            PODS-SUBNET-KEY = {
              cidr_block                 = "10.0.32.0/19"
              dhcp_options_key           = "default_dhcp_options"
              display_name               = "sub-pods"
              dns_label                  = "podssub"
              ipv6cidr_blocks            = []
              prohibit_internet_ingress  = true
              prohibit_public_ip_on_vnic = true
              route_table_key            = "RT-PODS-KEY"
              security_list_keys         = ["SECLIST-PODS-KEY"]
            }
            SERVICES-SUBNET-KEY = {
              cidr_block                 = "10.0.2.0/24"
              dhcp_options_key           = "default_dhcp_options"
              display_name               = "sub-services"
              dns_label                  = "servicessub"
              ipv6cidr_blocks            = []
              prohibit_internet_ingress  = false
              prohibit_public_ip_on_vnic = false
              route_table_id             = null
              route_table_key            = "RT-SERVICES-KEY"
              security_list_keys         = ["SECLIST-SERVICES-KEY"]
            }
            OPERATOR-SUBNET-KEY = {
              cidr_block                 = "10.0.3.0/30"
              dhcp_options_key           = "default_dhcp_options"
              display_name               = "sub-operator"
              dns_label                  = "operatorsub"
              ipv6cidr_blocks            = []
              prohibit_internet_ingress  = true
              prohibit_public_ip_on_vnic = true
              route_table_key            = "RT-OPERATOR-KEY"
              security_list_keys         = ["SECLIST-OPERATOR-KEY"]
            }
          }

          network_security_groups = {

            NSG-API-KEY = {
              display_name = "nsg-api"
              egress_rules = {
                sgw_tcp = {
                  description = "Allow TCP egress from OKE control plane to OCI services"
                  stateless   = false
                  protocol    = "TCP"
                  dst         = "all-services"
                  dst_type    = "SERVICE_CIDR_BLOCK"
                }
                workers_healthcheck = {
                  description  = "Allow TCP egress from OKE control plane to Kubelet on worker nodes."
                  stateless    = false
                  protocol     = "TCP"
                  dst          = "NSG-WORKERS-KEY"
                  dst_type     = "NETWORK_SECURITY_GROUP"
                  dst_port_min = 10250
                  dst_port_max = 10250
                }
                workers_12250 = {
                  description  = "Allow TCP egress from OKE control plane to worker node"
                  stateless    = false
                  protocol     = "TCP"
                  dst          = "NSG-WORKERS-KEY"
                  dst_type     = "NETWORK_SECURITY_GROUP"
                  dst_port_min = 12250
                  dst_port_max = 12250
                }
                api_intercommunication = {
                  description  = "Allow TCP egress for Kubernetes control plane inter-communicatioN"
                  stateless    = false
                  protocol     = "TCP"
                  dst          = "NSG-API-KEY"
                  dst_type     = "NETWORK_SECURITY_GROUP"
                  dst_port_min = 6443
                  dst_port_max = 6443
                }
                workers_icmp = {
                  description = "Allow ICMP egress for path discovery to worker nodes"
                  stateless   = false
                  protocol    = "ICMP"
                  dst         = "NSG-WORKERS-KEY"
                  dst_type    = "NETWORK_SECURITY_GROUP"
                  icmp_type   = 3
                  icmp_code   = 4
                }
                #native
                pods_all = {
                  description = "Allow Kubernetes API endpoint to communicate with pods."
                  stateless   = false
                  protocol    = "ALL"
                  dst         = "NSG-PODS-KEY"
                  dst_type    = "NETWORK_SECURITY_GROUP"

                }

              }

              ingress_rules = {

                api_intercommunication = {
                  description  = "Allow TCP ingress for Kubernetes control plane inter-communication."
                  stateless    = false
                  protocol     = "TCP"
                  src          = "NSG-API-KEY"
                  src_type     = "NETWORK_SECURITY_GROUP"
                  dst_port_min = 6443
                  dst_port_max = 6443
                }
                client_access = {
                  description  = "Operator access to Kubernetes API endpoint"
                  stateless    = false
                  protocol     = "TCP"
                  src          = "NSG-OPERATOR-KEY"
                  src_type     = "NETWORK_SECURITY_GROUP"
                  dst_port_min = 6443
                  dst_port_max = 6443
                }

                workers_tcp_6443 = {
                  description  = "Allow TCP ingress to kube-apiserver from worker nodes"
                  stateless    = false
                  protocol     = "TCP"
                  src          = "NSG-WORKERS-KEY"
                  src_type     = "NETWORK_SECURITY_GROUP"
                  dst_port_min = 6443
                  dst_port_max = 6443
                }
                workers_tcp_12250 = {
                  description  = "Allow TCP ingress to OKE control plane from worker nodes"
                  stateless    = false
                  protocol     = "TCP"
                  src          = "NSG-WORKERS-KEY"
                  src_type     = "NETWORK_SECURITY_GROUP"
                  dst_port_min = 10250
                  dst_port_max = 10250
                }
                workers_tcp_12250 = {
                  description  = "Allow TCP ingress to OKE control plane from worker nodes"
                  stateless    = false
                  protocol     = "TCP"
                  src          = "NSG-WORKERS-KEY"
                  src_type     = "NETWORK_SECURITY_GROUP"
                  dst_port_min = 12250
                  dst_port_max = 12250
                }
                workers_icmp = {
                  description = "Allow ICMP ingress for path discovery from worker nodes."
                  stateless   = false
                  protocol    = "ICMP"
                  src         = "NSG-WORKERS-KEY"
                  src_type    = "NETWORK_SECURITY_GROUP"
                  icmp_type   = 3
                  icmp_code   = 4
                }
                #native
                pods_tcp_6443 = {
                  description  = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)"
                  stateless    = false
                  protocol     = "TCP"
                  src          = "NSG-PODS-KEY"
                  src_type     = "NETWORK_SECURITY_GROUP"
                  dst_port_min = 6443
                  dst_port_max = 6443
                }
                pods_tcp_12250 = {
                  description  = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)"
                  stateless    = false
                  protocol     = "TCP"
                  src          = "NSG-PODS-KEY"
                  src_type     = "NETWORK_SECURITY_GROUP"
                  dst_port_min = 12250
                  dst_port_max = 12250
                }


              }
            }

            NSG-OPERATOR-KEY = {
              display_name = "nsg-operator"
              egress_rules = {
                api_tcp_6443 = {
                  description  = "Allow TCP egress from workers to Kubernetes API server."
                  stateless    = false
                  protocol     = "TCP"
                  dst          = "NSG-API-KEY"
                  dst_type     = "NETWORK_SECURITY_GROUP"
                  dst_port_min = 6443
                  dst_port_max = 6443
                }
                workers_ssh = {
                  description  = "Allow ssh from operator to workers."
                  stateless    = false
                  protocol     = "TCP"
                  dst          = "NSG-WORKERS-KEY"
                  dst_type     = "NETWORK_SECURITY_GROUP"
                  dst_port_min = 22
                  dst_port_max = 22
                }
              }
              ingress_rules = {
                #what should be the ingress to operator?
                # ssh_22 = {
                #   description  = "(optional) Allow inbound SSH traffic to operator instance."
                #   stateless    = false
                #   protocol     = "TCP"
                #   src          = "0.0.0.0/0"
                #   src_type     = "CIDR_BLOCK"
                #   dst_port_min = 22
                #   dst_port_max = 22
                # }

              }
            }

            NSG-WORKERS-KEY = {

              display_name = "nsg-workers"
              egress_rules = {
                workers_all = {
                  description = "Allow ALL egress from workers to other workers."
                  stateless   = false
                  protocol    = "ALL"
                  dst         = "NSG-WORKERS-KEY"
                  dst_type    = "NETWORK_SECURITY_GROUP"
                }
                sgw_tcp = {
                  description = "Allow TCP egress from workers to OCI Services."
                  stateless   = false
                  protocol    = "TCP"
                  dst         = "all-services"
                  dst_type    = "SERVICE_CIDR_BLOCK"
                }
                api_tcp_6443 = {
                  description  = "Allow TCP egress from workers to Kubernetes API server."
                  stateless    = false
                  protocol     = "TCP"
                  dst          = "NSG-API-KEY"
                  dst_type     = "NETWORK_SECURITY_GROUP"
                  dst_port_min = 6443
                  dst_port_max = 6443
                }
                api_tcp_10250 = {
                  description  = "Allow TCP ingress to workers for health check from OKE control plane."
                  stateless    = false
                  protocol     = "TCP"
                  dst          = "NSG-API-KEY"
                  dst_type     = "NETWORK_SECURITY_GROUP"
                  dst_port_min = 10250
                  dst_port_max = 10250
                }
                api_tcp_12250 = {
                  description  = "Allow TCP egress from workers to OKE control plane."
                  stateless    = false
                  protocol     = "TCP"
                  dst          = "NSG-API-KEY"
                  dst_type     = "NETWORK_SECURITY_GROUP"
                  dst_port_min = 12250
                  dst_port_max = 12250
                }
                anywhere_icmp = {
                  description = "Path Discovery."
                  stateless   = false
                  protocol    = "ICMP"
                  dst         = "0.0.0.0/0"
                  dst_type    = "CIDR_BLOCK"
                  icmp_type   = 3
                  icmp_code   = 4
                }

                #native
                pods_all = {
                  description = "Allow worker nodes to access pods."
                  stateless   = false
                  protocol    = "ALL"
                  dst         = "NSG-PODS-KEY"
                  dst_type    = "NETWORK_SECURITY_GROUP"
                }

                anywhere_tcp = {
                  description = "(optional) Allow worker nodes to communicate with internet."
                  stateless   = false
                  protocol    = "TCP"
                  dst         = "0.0.0.0/0"
                  dst_type    = "CIDR_BLOCK"
                }


              }

              ingress_rules = {

                workers_all = {
                  description = "Allow ALL ingress to workers from other workers."
                  stateless   = false
                  protocol    = "ALL"
                  src         = "NSG-WORKERS-KEY"
                  src_type    = "NETWORK_SECURITY_GROUP"
                }
                api_all = {
                  description = "Allow ALL ingress to workers from Kubernetes control plane for webhooks served by workers."
                  stateless   = false
                  protocol    = "ALL"
                  src         = "NSG-API-KEY"
                  src_type    = "NETWORK_SECURITY_GROUP"
                }
                lb_tcp_10256 = {
                  description  = "Allow TCP ingress to workers for health check from public load balancers"
                  stateless    = false
                  protocol     = "TCP"
                  src          = "NSG-SERVICES-KEY"
                  src_type     = "NETWORK_SECURITY_GROUP"
                  dst_port_min = 10256
                  dst_port_max = 10256
                }
                lb_tcp = {
                  description  = "Allow TCP ingress to workers from public load balancers"
                  stateless    = false
                  protocol     = "TCP"
                  src          = "NSG-SERVICES-KEY"
                  src_type     = "NETWORK_SECURITY_GROUP"
                  dst_port_min = 30000
                  dst_port_max = 32767
                }
                anywhere_icmp = {
                  description = "Allow ICMP ingress to workers for path discovery."
                  stateless   = false
                  protocol    = "ICMP"
                  src         = "0.0.0.0/0"
                  src_type    = "CIDR_BLOCK"
                  icmp_type   = 3
                  icmp_code   = 4
                }

                services_ssh = {
                  description  = "Allow ssh to workers from services sub"
                  stateless    = false
                  protocol     = "TCP"
                  src          = "10.0.2.0/24"
                  src_type     = "CIDR_BLOCK"
                  dst_port_min = 22
                  dst_port_max = 22
                }
                ssh_22 = {
                  description  = "Allow inbound SSH traffic to worker nodes from operator."
                  stateless    = false
                  protocol     = "TCP"
                  src          = "NSG-OPERATOR-KEY"
                  src_type     = "NETWORK_SECURITY_GROUP"
                  dst_port_min = 22
                  dst_port_max = 22
                }
              }
            }
            NSG-PODS-KEY = {
              display_name = "nsg-pods"
              egress_rules = {
                pods_traffic = {
                  description = "Allow pods to communicate with other pods."
                  stateless   = false
                  protocol    = "ALL"
                  dst         = "NSG-PODS-KEY"
                  dst_type    = "NETWORK_SECURITY_GROUP"
                }
                sgw_icmp = {
                  description = "Path Discovery."
                  stateless   = false
                  protocol    = "ICMP"
                  dst         = "all-services"
                  dst_type    = "SERVICE_CIDR_BLOCK"
                  icmp_type   = 3
                  icmp_code   = 4
                }
                sgw_tcp = {
                  description = "Allow TCP egress from pods to OCI Services."
                  stateless   = false
                  protocol    = "TCP"
                  dst         = "all-services"
                  dst_type    = "SERVICE_CIDR_BLOCK"
                }
                anywhere_tcp = {
                  description = "(optional) Allow pods nodes to communicate with internet."
                  stateless   = false
                  protocol    = "TCP"
                  dst         = "0.0.0.0/0"
                  dst_type    = "CIDR_BLOCK"
                }
                api_tcp_6443 = {
                  description  = "Allow TCP egress from pods to Kubernetes API server."
                  stateless    = false
                  protocol     = "TCP"
                  dst          = "NSG-API-KEY"
                  dst_type     = "NETWORK_SECURITY_GROUP"
                  dst_port_min = 6443
                  dst_port_max = 6443
                }

                api_tcp_12250 = {
                  description  = "Allow TCP egress from pods to OKE control plane."
                  stateless    = false
                  protocol     = "TCP"
                  dst          = "NSG-API-KEY"
                  dst_type     = "NETWORK_SECURITY_GROUP"
                  dst_port_min = 12250
                  dst_port_max = 12250
                }

              }
              ingress_rules = {
                workers_all = {
                  description = "Allow worker nodes to access pods."
                  stateless   = false
                  protocol    = "ALL"
                  src         = "NSG-WORKERS-KEY"
                  src_type    = "NETWORK_SECURITY_GROUP"
                }
                api_all = {
                  description = "Allow Kubernetes API endpoint to communicate with pods."
                  stateless   = false
                  protocol    = "ALL"
                  src         = "NSG-API-KEY"
                  src_type    = "NETWORK_SECURITY_GROUP"
                }
                pods_all = {
                  description = "	Allow pods to communicate with other pods."
                  stateless   = false
                  protocol    = "ALL"
                  src         = "NSG-PODS-KEY"
                  src_type    = "NETWORK_SECURITY_GROUP"
                }
              }
            }

            NSG-SERVICES-KEY = {
              display_name = "nsg-services"
              egress_rules = {

                workers_traffic = {
                  description  = "Allow TCP egress from public load balancers to workers nodes for NodePort traffic"
                  stateless    = false
                  protocol     = "TCP"
                  dst          = "NSG-WORKERS-KEY"
                  dst_type     = "NETWORK_SECURITY_GROUP"
                  dst_port_min = 30000
                  dst_port_max = 32767
                }
                workers_tcp_10256 = {
                  description  = "Allow TCP egress from public load balancers to worker nodes for health checks."
                  stateless    = false
                  protocol     = "TCP"
                  dst          = "NSG-WORKERS-KEY"
                  dst_type     = "NETWORK_SECURITY_GROUP"
                  dst_port_min = 10256
                  dst_port_max = 10256
                }
                lb_workers_icmp = {
                  description = "Allow ICMP egress from public load balancers to worker nodes for path discovery."
                  stateless   = false
                  protocol    = "ICMP"
                  dst         = "NSG-WORKERS-KEY"
                  dst_type    = "NETWORK_SECURITY_GROUP"
                  icmp_type   = 3
                  icmp_code   = 4
                }

              }

              ingress_rules = {
                # tcp_443 = {
                #   description  = "Allow inbound traffic to Load Balancer."
                #   stateless    = false
                #   protocol     = "TCP"
                #   src          = "0.0.0.0/0"
                #   src_type     = "CIDR_BLOCK"
                #   dst_port_min = 443
                #   dst_port_max = 443
                # }

              }
            }
          }

          vcn_specific_gateways = {
            internet_gateways = {
              IGW-KEY = {
                enabled      = true
                display_name = "igw-prod-vcn"
              }
            }
            nat_gateways = {
              NATGW-KEY = {
                block_traffic = false
                display_name  = "natgw-prod-vcn"
              }
            }
            service_gateways = {
              SGW-KEY = {
                display_name = "sgw-prod-vcn"
                services     = "all-services"
              }
            }
          }
        }
      }
    }
  }
}