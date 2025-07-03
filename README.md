<p align="center">
  <h1 align="center">Consul Service Network Solutions</h1>
  <p align="center">
    <a href="README.md"><strong>English</strong></a> | <strong>简体中文</strong>
  </p>
</p>

## Table of Contents

- [Repository Introduction](#repository-introduction)
- [Prerequisites](#prerequisites)
- [Image Specifications](#image-specifications)
- [Getting Help](#getting-help)
- [How to Contribute](#how-to-contribute)

## Repository Introduction
‌[Consul‌](https://github.com/hashicorp/consul) Consul is an open-source tool developed by HashiCorp, mainly used for service discovery, configuration management, and service mesh functions. It adopts a distributed architecture, ensures consistency based on the Raft protocol, supports multi-data center deployment, and is widely used in microservices and cloud-native scenarios.

**Core Features:**
1. Service Discovery and Health Checks: Supports multiple service discovery mechanisms (DNS, HTTP API, Kubernetes, AWS, etc.), dynamically registering and deregistering service instances. Built-in health check functionality actively monitors service status (e.g., HTTP/TCP/script checks), automatically removing unhealthy nodes from traffic to ensure service availability.
2. Key-Value Store (KV Store): Provides a distributed, highly available key-value store, supporting consistent read and write (ensuring CP characteristics through the Raft protocol). Suitable for dynamic configuration storage, feature toggles, or coordinating metadata, supporting TTL expiration and atomic operations.
3. Multi-Data Center Support: Natively supports multi-data center deployment, with communication between data centers via the WAN Gossip protocol, enabling cross-regional service discovery and fault isolation. Supports local data center priority routing policies to enhance inter-data center access efficiency.
4. Service Mesh Integration: Deeply integrates with proxies like Envoy, providing service mesh data plane (e.g., xDS API), dynamically issuing load balancing and traffic control rules. Supports advanced traffic management scenarios like canary releases and blue-green deployments.
5. Access Control and Security: Provides ACL (Access Control List) and token systems for fine-grained control of service/key-value read/write permissions. Supports TLS encrypted communication and mTLS mutual authentication to ensure data transmission security.
6. DNS/HTTP Dual Interface: Queries services via DNS or HTTP API, compatible with traditional DNS architectures and modern microservice architectures. For example, web.service.consul can resolve to a list of healthy Web service IPs.
7. High Availability and Consistency: Implements strong consistency based on the Raft protocol, supporting leader election and data replication, tolerating node failures (N/2+1 survival is sufficient to operate). Both service registration and KV storage support multiple replicas to avoid single points of failure.
8. Lightweight and Scalable: Single binary deployment with no external dependencies, supports containerization (e.g., Docker/Kubernetes). Provides rich APIs and plugin mechanisms, easily integrating with tools like Prometheus, Vault, etc.
9. Network Automation: Supports Connect feature (TLS encryption and authentication between services), automatically generating and rotating certificates to achieve zero-trust networks. Can replace traditional VPNs, simplifying secure communication configurations.
10. Monitoring and Observability Integration: Built-in Prometheus metrics endpoint, exposing cluster status and performance data (e.g., Raft transaction count, health check status). Integrates with tools like Grafana, OpenTelemetry, etc., visualizing service topology and performance metrics.

This project offers pre-configured [**`Consul-Service Network Solutions`**]()，images with Consul and its runtime environment pre-installed, along with deployment templates. Follow the guide to enjoy an "out-of-the-box" experience.

**Architecture Design:**

![](./images/img.png)

> **System Requirements:**
> - CPU: 4vCPUs or higher
> - RAM: 16GB or more
> - Disk: At least 50GB

## Prerequisites
[Register a Huawei account and activate Huawei Cloud](https://support.huaweicloud.com/usermanual-account/account_id_001.html)

## Image Specifications

| Image Version          | Description | Notes |
|------------------------| --- | --- |
| [Consul1.17.0-arm-v1.0](https://github.com/HuaweiCloudDeveloper/consul-image/tree/Consul1.17.0-arm-v1.0?tab=readme-ov-file) | Deployed on Kunpeng servers with Huawei Cloud EulerOS 2.0 64bit |  |

## Getting Help
- Submit an [issue](https://github.com/HuaweiCloudDeveloper/consul-image/issues)
- Contact Huawei Cloud Marketplace product support

## How to Contribute
- Fork this repository and submit a merge request.
- Update README.md synchronously based on your open-source mirror information.