Return-Path: <linux-rdma+bounces-6114-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 384669D9A7C
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2024 16:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C770516466A
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2024 15:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0271D63D8;
	Tue, 26 Nov 2024 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EByRBnu8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FEB1917E6
	for <linux-rdma@vger.kernel.org>; Tue, 26 Nov 2024 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732635394; cv=none; b=Utp9B+8PEDkLoRcy1QnVQkxsXJZr8yeLwgjFeZiKA0h66NCsqbGn1Qxa4tPjkWwxKVvFvUnKjFoXLg9/lIe0SPECgDCq2k1Dnjfc1WwRUazi2L+auIh5obowgpkrdvcBoaBojH+kgBPbA4V/NVt0IYhInAKotAftAGfeVSxrjB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732635394; c=relaxed/simple;
	bh=Xp+L8BZDnhKVcoPwx7TBi4ep6MKUfMLr/t0URwAOxxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uR8N5PUbkk4RKlFhguhv0E/czaXilTzgWf/FF4QsQggx2EESye3HVGbj2l9y9Q1HenalwFZVb3QIOhuGrAxQ2qE3VI0mu9bbmHfnsGXrbURwlMXrLf/LT4Vt+e/2kve4kXiJ2/781LRYhLta5kI5TE9rp+vzZ3IiDiL4uPIdcJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EByRBnu8; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e03c5cf0-f4dc-41c2-af48-a95463592eed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732635389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MLbW3T2XOthOCjNgt+0KG0jJfgqgLap2Mxl/kjFwzGU=;
	b=EByRBnu8r8OQ4tD1Fhe69DxNvqJbOl3M6jJmGvWA3oF/Rao36IKpCsquQWLMt9B7yIy6n6
	0LY8lsb8noH8c3jYczCEbKSgXU/hGGQZEn2YqWoklUAWxvjxmmRdSk2ldLdrUe2rrZCrDm
	S8+om0VFzlJF71t1sWsuYu+iNL5piUs=
Date: Tue, 26 Nov 2024 16:36:26 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next 1/8] RDMA/erdma: Probe the erdma RoCEv2 device
To: Boshi Yu <boshiyu@linux.alibaba.com>, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, kaishen@linux.alibaba.com,
 chengyou@linux.alibaba.com
References: <20241126070351.92787-1-boshiyu@linux.alibaba.com>
 <20241126070351.92787-2-boshiyu@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20241126070351.92787-2-boshiyu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/11/26 7:59, Boshi Yu 写道:
> Currently, the erdma driver supports both the iWARP and RoCEv2 protocols.
> The erdma driver reads the ERDMA_REGS_DEV_PROTO_REG register to identify
> the protocol used by the erdma device. Since each protocol requires
> different ib_device_ops, we introduce the erdma_device_ops_iwarp and
> erdma_device_ops_rocev2 for iWARP and RoCEv2 protocols, respectively.
> 
Hi, Boshi

 From alomost all of the RDMA users, it seems that RoCEv2 protocol is 
required while very few users request iWARP protocol in their production 
hosts. But in the erdma HW/FW, this iWARP protocol is supported. Is this 
iWARP protocol for some special use cases in the Ali-Cloud environment?

I am just curious about this, not to be against this patch series. If 
this is related with the Ali-Cloud security, you can ignore this.

Thanks,
Zhu Yanjun

> Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
> Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>   drivers/infiniband/hw/erdma/Kconfig       |  2 +-
>   drivers/infiniband/hw/erdma/erdma.h       |  3 +-
>   drivers/infiniband/hw/erdma/erdma_hw.h    |  7 ++++
>   drivers/infiniband/hw/erdma/erdma_main.c  | 47 ++++++++++++++++++-----
>   drivers/infiniband/hw/erdma/erdma_verbs.c | 16 +++++++-
>   drivers/infiniband/hw/erdma/erdma_verbs.h | 12 ++++++
>   6 files changed, 75 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/erdma/Kconfig b/drivers/infiniband/hw/erdma/Kconfig
> index 169038e3ceb1..267fc1f3c42a 100644
> --- a/drivers/infiniband/hw/erdma/Kconfig
> +++ b/drivers/infiniband/hw/erdma/Kconfig
> @@ -5,7 +5,7 @@ config INFINIBAND_ERDMA
>   	depends on INFINIBAND_ADDR_TRANS
>   	depends on INFINIBAND_USER_ACCESS
>   	help
> -	  This is a RDMA/iWarp driver for Alibaba Elastic RDMA Adapter(ERDMA),
> +	  This is a RDMA driver for Alibaba Elastic RDMA Adapter(ERDMA),
>   	  which supports RDMA features in Alibaba cloud environment.
>   
>   	  To compile this driver as module, choose M here. The module will be
> diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
> index 3c166359448d..ad4dc1a4bdc7 100644
> --- a/drivers/infiniband/hw/erdma/erdma.h
> +++ b/drivers/infiniband/hw/erdma/erdma.h
> @@ -16,7 +16,7 @@
>   #include "erdma_hw.h"
>   
>   #define DRV_MODULE_NAME "erdma"
> -#define ERDMA_NODE_DESC "Elastic RDMA(iWARP) stack"
> +#define ERDMA_NODE_DESC "Elastic RDMA Adapter stack"
>   
>   struct erdma_eq {
>   	void *qbuf;
> @@ -215,6 +215,7 @@ struct erdma_dev {
>   
>   	struct dma_pool *db_pool;
>   	struct dma_pool *resp_pool;
> +	enum erdma_proto_type proto;
>   };
>   
>   static inline void *get_queue_entry(void *qbuf, u32 idx, u32 depth, u32 shift)
> diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
> index 05978f3b1475..970b392d4fb4 100644
> --- a/drivers/infiniband/hw/erdma/erdma_hw.h
> +++ b/drivers/infiniband/hw/erdma/erdma_hw.h
> @@ -21,8 +21,15 @@
>   #define ERDMA_NUM_MSIX_VEC 32U
>   #define ERDMA_MSIX_VECTOR_CMDQ 0
>   
> +/* erdma device protocol type */
> +enum erdma_proto_type {
> +	ERDMA_PROTO_IWARP = 0,
> +	ERDMA_PROTO_ROCEV2 = 1,
> +};
> +
>   /* PCIe Bar0 Registers. */
>   #define ERDMA_REGS_VERSION_REG 0x0
> +#define ERDMA_REGS_DEV_PROTO_REG 0xC
>   #define ERDMA_REGS_DEV_CTRL_REG 0x10
>   #define ERDMA_REGS_DEV_ST_REG 0x14
>   #define ERDMA_REGS_NETDEV_MAC_L_REG 0x18
> diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
> index 62f497a71004..b6706c74cd96 100644
> --- a/drivers/infiniband/hw/erdma/erdma_main.c
> +++ b/drivers/infiniband/hw/erdma/erdma_main.c
> @@ -172,6 +172,12 @@ static int erdma_device_init(struct erdma_dev *dev, struct pci_dev *pdev)
>   {
>   	int ret;
>   
> +	dev->proto = erdma_reg_read32(dev, ERDMA_REGS_DEV_PROTO_REG);
> +	if (!erdma_device_iwarp(dev) && !erdma_device_rocev2(dev)) {
> +		dev_err(&pdev->dev, "Unsupported protocol: %d\n", dev->proto);
> +		return -ENODEV;
> +	}
> +
>   	dev->resp_pool = dma_pool_create("erdma_resp_pool", &pdev->dev,
>   					 ERDMA_HW_RESP_SIZE, ERDMA_HW_RESP_SIZE,
>   					 0);
> @@ -474,6 +480,21 @@ static void erdma_res_cb_free(struct erdma_dev *dev)
>   		bitmap_free(dev->res_cb[i].bitmap);
>   }
>   
> +static const struct ib_device_ops erdma_device_ops_rocev2 = {
> +	.get_link_layer = erdma_get_link_layer,
> +};
> +
> +static const struct ib_device_ops erdma_device_ops_iwarp = {
> +	.iw_accept = erdma_accept,
> +	.iw_add_ref = erdma_qp_get_ref,
> +	.iw_connect = erdma_connect,
> +	.iw_create_listen = erdma_create_listen,
> +	.iw_destroy_listen = erdma_destroy_listen,
> +	.iw_get_qp = erdma_get_ibqp,
> +	.iw_reject = erdma_reject,
> +	.iw_rem_ref = erdma_qp_put_ref,
> +};
> +
>   static const struct ib_device_ops erdma_device_ops = {
>   	.owner = THIS_MODULE,
>   	.driver_id = RDMA_DRIVER_ERDMA,
> @@ -494,14 +515,6 @@ static const struct ib_device_ops erdma_device_ops = {
>   	.get_dma_mr = erdma_get_dma_mr,
>   	.get_hw_stats = erdma_get_hw_stats,
>   	.get_port_immutable = erdma_get_port_immutable,
> -	.iw_accept = erdma_accept,
> -	.iw_add_ref = erdma_qp_get_ref,
> -	.iw_connect = erdma_connect,
> -	.iw_create_listen = erdma_create_listen,
> -	.iw_destroy_listen = erdma_destroy_listen,
> -	.iw_get_qp = erdma_get_ibqp,
> -	.iw_reject = erdma_reject,
> -	.iw_rem_ref = erdma_qp_put_ref,
>   	.map_mr_sg = erdma_map_mr_sg,
>   	.mmap = erdma_mmap,
>   	.mmap_free = erdma_mmap_free,
> @@ -522,6 +535,18 @@ static const struct ib_device_ops erdma_device_ops = {
>   	INIT_RDMA_OBJ_SIZE(ib_qp, erdma_qp, ibqp),
>   };
>   
> +static void erdma_device_init_iwarp(struct ib_device *ibdev)
> +{
> +	ibdev->node_type = RDMA_NODE_RNIC;
> +	ib_set_device_ops(ibdev, &erdma_device_ops_iwarp);
> +}
> +
> +static void erdma_device_init_rocev2(struct ib_device *ibdev)
> +{
> +	ibdev->node_type = RDMA_NODE_IB_CA;
> +	ib_set_device_ops(ibdev, &erdma_device_ops_rocev2);
> +}
> +
>   static int erdma_ib_device_add(struct pci_dev *pdev)
>   {
>   	struct erdma_dev *dev = pci_get_drvdata(pdev);
> @@ -537,7 +562,11 @@ static int erdma_ib_device_add(struct pci_dev *pdev)
>   	if (ret)
>   		return ret;
>   
> -	ibdev->node_type = RDMA_NODE_RNIC;
> +	if (erdma_device_iwarp(dev))
> +		erdma_device_init_iwarp(&dev->ibdev);
> +	else
> +		erdma_device_init_rocev2(&dev->ibdev);
> +
>   	memcpy(ibdev->node_desc, ERDMA_NODE_DESC, sizeof(ERDMA_NODE_DESC));
>   
>   	/*
> diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
> index 51d619edb6c5..3b7e55515cfd 100644
> --- a/drivers/infiniband/hw/erdma/erdma_verbs.c
> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
> @@ -395,8 +395,17 @@ int erdma_query_port(struct ib_device *ibdev, u32 port,
>   int erdma_get_port_immutable(struct ib_device *ibdev, u32 port,
>   			     struct ib_port_immutable *port_immutable)
>   {
> +	struct erdma_dev *dev = to_edev(ibdev);
> +
> +	if (erdma_device_iwarp(dev)) {
> +		port_immutable->core_cap_flags = RDMA_CORE_PORT_IWARP;
> +	} else {
> +		port_immutable->core_cap_flags =
> +			RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP;
> +		port_immutable->max_mad_size = IB_MGMT_MAD_SIZE;
> +	}
> +
>   	port_immutable->gid_tbl_len = 1;
> -	port_immutable->core_cap_flags = RDMA_CORE_PORT_IWARP;
>   
>   	return 0;
>   }
> @@ -1839,3 +1848,8 @@ int erdma_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
>   
>   	return stats->num_counters;
>   }
> +
> +enum rdma_link_layer erdma_get_link_layer(struct ib_device *ibdev, u32 port_num)
> +{
> +	return IB_LINK_LAYER_ETHERNET;
> +}
> diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
> index c998acd39a78..90e2b35a0973 100644
> --- a/drivers/infiniband/hw/erdma/erdma_verbs.h
> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
> @@ -291,6 +291,16 @@ int erdma_modify_qp_internal(struct erdma_qp *qp, struct erdma_qp_attrs *attrs,
>   void erdma_qp_llp_close(struct erdma_qp *qp);
>   void erdma_qp_cm_drop(struct erdma_qp *qp);
>   
> +static inline bool erdma_device_iwarp(struct erdma_dev *dev)
> +{
> +	return dev->proto == ERDMA_PROTO_IWARP;
> +}
> +
> +static inline bool erdma_device_rocev2(struct erdma_dev *dev)
> +{
> +	return dev->proto == ERDMA_PROTO_ROCEV2;
> +}
> +
>   static inline struct erdma_ucontext *to_ectx(struct ib_ucontext *ibctx)
>   {
>   	return container_of(ibctx, struct erdma_ucontext, ibucontext);
> @@ -370,5 +380,7 @@ struct rdma_hw_stats *erdma_alloc_hw_port_stats(struct ib_device *device,
>   						u32 port_num);
>   int erdma_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
>   		       u32 port, int index);
> +enum rdma_link_layer erdma_get_link_layer(struct ib_device *ibdev,
> +					  u32 port_num);
>   
>   #endif


