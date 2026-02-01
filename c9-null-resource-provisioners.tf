resource "null_resource" "cluster" {
  # Changes to any instance of the cluster requires re-provisioning

  depends_on = [ module.ec2-public ]
  # triggers = {
  #   cluster_instance_ids = join(",", aws_instance.cluster[*].id)
  # }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = ""
    host     = aws_eip.bastion_host_eip.public_ip
    private_key = file("private-key/terraform-pk.pem")
  }

  // creation time provisioners - during terraform apply
  provisioner "file" {
    destination = "/tmp/terraform-pk.pem"
    source      = "./private-key/terraform-pk.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/terraform-pk.pem",
    ]
  }

  provisioner "local-exec" {
    command = "echo vpc created on `date` and VPC ID: ${module.vpc.vpc_id} >> creation-time-vpcid.txt"
    working_dir = "./local-exec-output-files/"
    # on_failure = continue
    # when = destroy
  }

  # // destroy time provisioners - during terraform destroy
  # provisioner "local-exec" {
  #   command = "echo Destroy time `date` >> destroy-time-prov.txt"
  #   working_dir = "./local-exec-output-files/"
  #   # on_failure = continue
  #   when = destroy
  # }
}




