# OUTPUTS

output "c8000v_instances_aws" {
  description = "Details of all C8000v instances"
  value = {
    for hostname, instance in module.c8000v_aws : hostname => {
      public_ip    = instance.instance_details.public_ip
      transport_ip = instance.instance_details.transport_ip
      service_ip   = instance.instance_details.service_ip
    }
  }
}

output "c8000v_instances_azure" {
  description = "Details of all C8000v instances in Azure"
  value = {
    for hostname, instance in module.c8000v_azure : hostname => {
      public_ip    = instance.instance_details.public_ip
      transport_ip = instance.instance_details.transport_ip
      service_ip   = instance.instance_details.service_ip
    }
  }
}
