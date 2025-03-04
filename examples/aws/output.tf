# OUTPUTS

output "c8000v_aws" {
  description = "Details of all C8000v instances"
  value = {
    public_ip    = module.c8000v_aws.instance_details.public_ip
    transport_ip = module.c8000v_aws.instance_details.transport_ip
    service_ip   = module.c8000v_aws.instance_details.service_ip
  }
}
