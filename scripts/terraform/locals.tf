locals {
  // you need to specify a unique name under a tenant according to the business, which will be used as part of the resource name
  app_id = format("%s-%s", "app", formatdate("hhmm", timestamp()))

  name_suffix = "mkp"

  // Tags of HUAWEI CLOUD resources. You can add tags to resources to classify resources.
  // for more details, please refer to https://support.huaweicloud.com/usermanual-tms/zh-cn_topic_0056266263.html
  tags = { Purpose = "MkpApplication" }



  # Configuration of the ECS memory size and number of cores
  # instance_flavor_cpu    = 4
  # instance_flavor_memory = 16
  #  通用计算增强型
  instance_performance_type = "kunpeng_computing"
  # 系统盘: 通用SSD
  ecs_volume_type = "GPSSD"

  # 规格：通用入门型
  #ecs_flavor = "kc1.xlarge.4"

  // Billing model for cloud resources, You need to modify it according to your actual situation.
  // In the development and testing phase, pay-per-use billing is recommended.
  // You can also set these three parameters as variables, allowing users to select at deployment time.
  charging_mode = var.charging_mode
  period_unit   = var.period_unit
  period        = var.period

  // The billing model for bandwidth, You need to modify it according to your actual situation.
  publicip_type         = "5_bgp"     # 全动态
  bandwidth_share_type  = "PER"       # 独享带宽
  bandwidth_charge_mode = "bandwidth" # 按带宽计费
  bandwidth_size        = 10          # 带宽大小

  # Image information in different regions, you need to enter your own image ID or add another region.
  # For Marketplace Image Id,you can log in to Seller Console, view the marketplace image id on Product Specifications section of My Products detail page.
  # 镜像版本：
  #Consul-1.17.0-kunpeng-HCE2.0
  instance_image_id_maps_v1 = {
#     北京4
    cn-north-4     = "d7400fd1-92fc-4b52-a2ff-901ed1f14a80"
#     广州
    cn-south-1     = "5d0c2dda-9d44-4f90-8f5a-ff1bf8413cbf"
#     上海一
    cn-east-3      = "c8072764-0d23-4b7f-9c85-8f37edf2a223"
#     乌兰察布一
    cn-north-9     = "9f73a4b4-7731-462e-a1e9-9d9fc6b3ac31"
#     贵阳一
    cn-southwest-2 = "5c5a0e2a-82b5-44c2-a355-a75e66293857"

  }
  #Consul-1.17.0-kunpeng-Ubuntu24.04
  instance_image_id_maps_v2 = {
#     北京4
    cn-north-4     = "36f75d3c-2afe-4a9e-9c25-01bdc3b82dbf"
#     广州
    cn-south-1     = "6ba216aa-3472-4c54-8c53-79848541edd9"
#     上海一
    cn-east-3      = "399de33c-97fc-4f46-b19e-91f69173bb59"
#     乌兰察布一
    cn-north-9     = "e8934817-bf64-4c86-9f25-a44180392944"
#     贵阳一
    cn-southwest-2 = "b327f498-5079-4c42-9136-1d81713c66fb"

  }  
  # # 其他版本增加（注意修改var参数和镜像的版本的判断部分）
  #  instance_image_id_maps = {
  #   #     北京4
  #   cn-north-4 = ""
  #  }  

  # Specifies the DNS server address list of a subnet. For details about the private DNS address, see https://support.huaweicloud.com/dns_faq/dns_faq_002.html#?
  subnet_dns_list_maps = {
    cn-north-4     = ["100.125.1.250", "100.125.129.250"]
    cn-south-1     = ["100.125.1.250", "100.125.136.29"]
    cn-east-3      = ["100.125.1.250", "100.125.64.250"]
    cn-north-9     = ["100.125.1.250", "100.125.107.250"]
    cn-southwest-2 = ["100.125.1.250", "100.125.129.250"]
  }


}