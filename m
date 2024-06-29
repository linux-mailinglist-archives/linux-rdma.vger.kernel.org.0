Return-Path: <linux-rdma+bounces-3567-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B16491C9BC
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Jun 2024 02:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72751C22152
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Jun 2024 00:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E5E64C;
	Sat, 29 Jun 2024 00:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NK9lGUev"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46F663C
	for <linux-rdma@vger.kernel.org>; Sat, 29 Jun 2024 00:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719620111; cv=none; b=dlrTQ/ldrZ17Ewe0qSqz0J+c6jhewentFHRI5Rz6pTK5R0lTSoif0rL9JLcovHfN6h5ZNSuhiNpgLNJIFsX/gXFn/QahnyL3tuLefplXydXgVY1dIHGopf1OSC40oTqL3JhwNXV9f0aVguZRrKQ6JKgNLNQX2V7QhsWNfNd2e/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719620111; c=relaxed/simple;
	bh=tI2z/Iyr4qDyCs3OL1ejkmQI3eZIFl39QnR9SITdkSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c16OiMTmKchVn18AHK3D4a0lyr1/TX0ybYTjFMN+hJ+8W++T478gD603j4xg9PyBMZ5lWPX4RirDmvbT+LLvplrA2zSyjaa67EYs564RcYuRv9PsmguVMy+TLuca9VjuBTeXfrEn2RbK5O+QZyzl2ouPKpron6GGdB80hltu8O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NK9lGUev; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: leon@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719620105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C3QoZpNlv8D7GeF339Zvt+uVl22HnLNRakAAPipjiyk=;
	b=NK9lGUevVWYUEaHgJzLoAQikfWolAPkEfX1WOMJ/EoKExDzAhk5hatyfo9feag0OsAolz7
	lM8Q9DpizB+blhTHWKX/1J+igXLVyPr/G5zhZdMLcxfinerZ5Auyf3YzGSvF15lDtPf9O/
	ybJNomx5Wav041xa+uRo4UlqYyZX7JY=
X-Envelope-To: jgg@nvidia.com
X-Envelope-To: markzhang@nvidia.com
X-Envelope-To: davem@davemloft.net
X-Envelope-To: edumazet@google.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: saeedm@nvidia.com
X-Envelope-To: tariqt@nvidia.com
Message-ID: <8dd1179c-a738-4abe-b21b-448ff8a21ebb@linux.dev>
Date: Sat, 29 Jun 2024 08:14:56 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 04/12] RDMA/core: Support IB sub device with
 type "SMI"
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Zhang <markzhang@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
References: <cover.1718553901.git.leon@kernel.org>
 <44253f7508b21eb2caefea3980c2bc072869116c.1718553901.git.leon@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <44253f7508b21eb2caefea3980c2bc072869116c.1718553901.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/6/17 0:08, Leon Romanovsky 写道:
> From: Mark Zhang <markzhang@nvidia.com>
> 
> This patch adds 2 APIs, as well as driver operations to support adding
> and deleting an IB sub device, which provides part of functionalities
> of it's parent.
> 
> A sub device has a type; for a sub device with type "SMI", it provides
> the smi capability through umad for its parent, meaning uverb is not
> supported.
> 
> A sub device cannot live without a parent. So when a parent is
> released, all it's sub devices are released as well.
> 
> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>   drivers/infiniband/core/device.c      | 68 +++++++++++++++++++++++++++
>   drivers/infiniband/core/uverbs_main.c |  3 +-
>   include/rdma/ib_verbs.h               | 43 +++++++++++++++++
>   include/uapi/rdma/rdma_netlink.h      |  5 ++
>   4 files changed, 118 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 55aa7aa32d4a..8547cab50b23 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -641,6 +641,11 @@ struct ib_device *_ib_alloc_device(size_t size)
>   		BIT_ULL(IB_USER_VERBS_CMD_REG_MR) |
>   		BIT_ULL(IB_USER_VERBS_CMD_REREG_MR) |
>   		BIT_ULL(IB_USER_VERBS_CMD_RESIZE_CQ);
> +
> +	mutex_init(&device->subdev_lock);
> +	INIT_LIST_HEAD(&device->subdev_list_head);
> +	INIT_LIST_HEAD(&device->subdev_list);
> +
>   	return device;
>   }
>   EXPORT_SYMBOL(_ib_alloc_device);
> @@ -1461,6 +1466,18 @@ EXPORT_SYMBOL(ib_register_device);
>   /* Callers must hold a get on the device. */
>   static void __ib_unregister_device(struct ib_device *ib_dev)
>   {
> +	struct ib_device *sub, *tmp;
> +
> +	mutex_lock(&ib_dev->subdev_lock);
> +	list_for_each_entry_safe_reverse(sub, tmp,
> +					 &ib_dev->subdev_list_head,
> +					 subdev_list) {
> +		list_del(&sub->subdev_list);
> +		ib_dev->ops.del_sub_dev(sub);
> +		ib_device_put(ib_dev);
> +	}
> +	mutex_unlock(&ib_dev->subdev_lock);
> +
>   	/*
>   	 * We have a registration lock so that all the calls to unregister are
>   	 * fully fenced, once any unregister returns the device is truely
> @@ -2597,6 +2614,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
>   		ops->uverbs_no_driver_id_binding;
>   
>   	SET_DEVICE_OP(dev_ops, add_gid);
> +	SET_DEVICE_OP(dev_ops, add_sub_dev);
>   	SET_DEVICE_OP(dev_ops, advise_mr);
>   	SET_DEVICE_OP(dev_ops, alloc_dm);
>   	SET_DEVICE_OP(dev_ops, alloc_hw_device_stats);
> @@ -2631,6 +2649,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
>   	SET_DEVICE_OP(dev_ops, dealloc_ucontext);
>   	SET_DEVICE_OP(dev_ops, dealloc_xrcd);
>   	SET_DEVICE_OP(dev_ops, del_gid);
> +	SET_DEVICE_OP(dev_ops, del_sub_dev);
>   	SET_DEVICE_OP(dev_ops, dereg_mr);
>   	SET_DEVICE_OP(dev_ops, destroy_ah);
>   	SET_DEVICE_OP(dev_ops, destroy_counters);
> @@ -2727,6 +2746,55 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
>   }
>   EXPORT_SYMBOL(ib_set_device_ops);
>   
> +int ib_add_sub_device(struct ib_device *parent,
> +		      enum rdma_nl_dev_type type,
> +		      const char *name)
> +{
> +	struct ib_device *sub;
> +	int ret = 0;
> +
> +	if (!parent->ops.add_sub_dev || !parent->ops.del_sub_dev)
> +		return -EOPNOTSUPP;
> +
> +	if (!ib_device_try_get(parent))
> +		return -EINVAL;
> +
> +	sub = parent->ops.add_sub_dev(parent, type, name);
> +	if (IS_ERR(sub)) {
> +		ib_device_put(parent);
> +		return PTR_ERR(sub);
> +	}
> +
> +	sub->type = type;
> +	sub->parent = parent;
> +
> +	mutex_lock(&parent->subdev_lock);
> +	list_add_tail(&parent->subdev_list_head, &sub->subdev_list);
> +	mutex_unlock(&parent->subdev_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(ib_add_sub_device);
> +
> +int ib_del_sub_device_and_put(struct ib_device *sub)
> +{
> +	struct ib_device *parent = sub->parent;
> +
> +	if (!parent)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&parent->subdev_lock);

mutex_destroy of subdev_lock is missing. When mutex_lock is called, it 
had better call mutex_destroy when the mutex lock is not used any more.
Other mutex locks in this file, for example subdev_lock and subdev_lock,
call mutex_destroy in the function ib_device_release.

Perhaps subdev_lock can also call mutex_destroy in ib_device_release?

Zhu Yanjun

> +	list_del(&sub->subdev_list);
> +	mutex_unlock(&parent->subdev_lock);
> +
> +	ib_device_put(sub);
> +	parent->ops.del_sub_dev(sub);
> +	ib_device_put(parent);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(ib_del_sub_device_and_put);
> +
>   #ifdef CONFIG_INFINIBAND_VIRT_DMA
>   int ib_dma_virt_map_sg(struct ib_device *dev, struct scatterlist *sg, int nents)
>   {
> diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
> index 495d5a5d0373..bc099287de9a 100644
> --- a/drivers/infiniband/core/uverbs_main.c
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@ -1114,7 +1114,8 @@ static int ib_uverbs_add_one(struct ib_device *device)
>   	struct ib_uverbs_device *uverbs_dev;
>   	int ret;
>   
> -	if (!device->ops.alloc_ucontext)
> +	if (!device->ops.alloc_ucontext ||
> +	    device->type == RDMA_DEVICE_TYPE_SMI)
>   		return -EOPNOTSUPP;
>   
>   	uverbs_dev = kzalloc(sizeof(*uverbs_dev), GFP_KERNEL);
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 477bf9dd5e71..bebc2d22f466 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -2661,6 +2661,18 @@ struct ib_device_ops {
>   	 */
>   	int (*get_numa_node)(struct ib_device *dev);
>   
> +	/**
> +	 * add_sub_dev - Add a sub IB device
> +	 */
> +	struct ib_device *(*add_sub_dev)(struct ib_device *parent,
> +					 enum rdma_nl_dev_type type,
> +					 const char *name);
> +
> +	/**
> +	 * del_sub_dev - Delete a sub IB device
> +	 */
> +	void (*del_sub_dev)(struct ib_device *sub_dev);
> +
>   	DECLARE_RDMA_OBJ_SIZE(ib_ah);
>   	DECLARE_RDMA_OBJ_SIZE(ib_counters);
>   	DECLARE_RDMA_OBJ_SIZE(ib_cq);
> @@ -2771,6 +2783,15 @@ struct ib_device {
>   	char iw_ifname[IFNAMSIZ];
>   	u32 iw_driver_flags;
>   	u32 lag_flags;
> +
> +	/* A parent device has a list of sub-devices */
> +	struct mutex subdev_lock;
> +	struct list_head subdev_list_head;
> +
> +	/* A sub device has a type and a parent */
> +	enum rdma_nl_dev_type type;
> +	struct ib_device *parent;
> +	struct list_head subdev_list;
>   };
>   
>   static inline void *rdma_zalloc_obj(struct ib_device *dev, size_t size,
> @@ -4820,4 +4841,26 @@ static inline u16 rdma_get_udp_sport(u32 fl, u32 lqpn, u32 rqpn)
>   
>   const struct ib_port_immutable*
>   ib_port_immutable_read(struct ib_device *dev, unsigned int port);
> +
> +/** ib_add_sub_device - Add a sub IB device on an existing one
> + *
> + * @parent: The IB device that needs to add a sub device
> + * @type: The type of the new sub device
> + * @name: The name of the new sub device
> + *
> + *
> + * Return 0 on success, an error code otherwise
> + */
> +int ib_add_sub_device(struct ib_device *parent,
> +		      enum rdma_nl_dev_type type,
> +		      const char *name);
> +
> +
> +/** ib_del_sub_device_and_put - Delect an IB sub device while holding a 'get'
> + *
> + * @sub: The sub device that is going to be deleted
> + *
> + * Return 0 on success, an error code otherwise
> + */
> +int ib_del_sub_device_and_put(struct ib_device *sub);
>   #endif /* IB_VERBS_H */
> diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
> index a214fc259f28..d15ee16be722 100644
> --- a/include/uapi/rdma/rdma_netlink.h
> +++ b/include/uapi/rdma/rdma_netlink.h
> @@ -602,4 +602,9 @@ enum rdma_nl_counter_mask {
>   	RDMA_COUNTER_MASK_QP_TYPE = 1,
>   	RDMA_COUNTER_MASK_PID = 1 << 1,
>   };
> +
> +/* Supported rdma device types. */
> +enum rdma_nl_dev_type {
> +	RDMA_DEVICE_TYPE_SMI = 1,
> +};
>   #endif /* _UAPI_RDMA_NETLINK_H */


